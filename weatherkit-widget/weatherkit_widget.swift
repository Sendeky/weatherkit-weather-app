//
//  weatherkit_widget.swift
//  weatherkit-widget
//
//  Created by RuslanS on 12/3/22.
//

import WidgetKit
import SwiftUI
import Foundation

struct Provider: TimelineProvider {
    //NAME OF APP GROUP IS VERY IMPORTANT!! ("widgetData")
    //Accesses App Group data which has WidgetData (temps, etc.)
    @AppStorage("widgetData", store: UserDefaults(suiteName: "group.com.ES.weatherkit-programmatic-app")) var primaryData : Data = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        //Sets widgetData placeholder (before data from main app is passed in)
        let widgetData = WidgetData(temp: "-", tempMax: "-", tempMin: "-")
        return SimpleEntry(widgetData: widgetData)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        //Decodes widgetData from AppGroup
        guard let widgetData = try? JSONDecoder().decode(WidgetData.self, from: primaryData) else {return}
        //Entry is widgetData
        let entry = SimpleEntry(widgetData: widgetData)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        //Decodes widgetData from AppGroup
        guard let widgetData = try? JSONDecoder().decode(WidgetData.self, from: primaryData) else {return}
        //Entry is eqaul to widgetData
        let entry = SimpleEntry(widgetData: widgetData)
        //Adds entry to timeline
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date = Date()
    let widgetData : WidgetData
}

struct weatherkit_widgetEntryView : View {
    
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.blue.gradient)
            
            VStack {
                HStack {
                    Text("Current")
                        .fontWeight(.light)
                        .font(.title)
                }
                //Sets text as "temp" from widgetData
                Text(entry.widgetData.temp)
                    .font(.system(size: 60))
            }
        }
        //Sets text as "temp" from widgetData
//        Text(entry.widgetData.temp)
    }
}

@main
struct weatherkit_widget: Widget {
    let kind: String = "weatherkit_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            weatherkit_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct weatherkit_widget_Previews: PreviewProvider {
    //Preview WidgetData data (seen when choosing widgets)
    static let widgetData = WidgetData(temp: "12", tempMax: "16", tempMin: "8")
    static var previews: some View {
        weatherkit_widgetEntryView(entry: SimpleEntry(widgetData: widgetData))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

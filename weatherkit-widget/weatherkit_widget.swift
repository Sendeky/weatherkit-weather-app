//
//  weatherkit_widget.swift
//  weatherkit-widget
//
//  Created by RuslanS on 12/3/22.
//


import WidgetKit
import SwiftUI
import Foundation
import Charts

struct Provider: TimelineProvider {
    //NAME OF APP GROUP IS VERY IMPORTANT!! ("widgetData")
    //Accesses App Group data which has WidgetData (temps, etc.)
    @AppStorage("widgetData", store: UserDefaults(suiteName: "group.com.ES.weatherkit-programmatic-app")) var primaryData : Data = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        //Sets widgetData placeholder (before data from main app is passed in)
        let widgetData = WidgetData(temp: "-", tempMax: "-", tempMin: "-", symbolName: "-", hourlyForecast: [0.0], forecastTimeArray: ["-"])
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

struct Item: Identifiable {
    var id = UUID()
    var type: String
    var value: Double
    var time: String
}

struct weatherkit_widgetEntryView : View {
    
    var entry: Provider.Entry
    
    //@State allows value to be changed
    //Initialises with empty array
    @State var items: [Item] = []
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        
        switch family {
        case .systemSmall:
            //Layout for small widget
            ZStack {
                ContainerRelativeShape()
                    .fill(LinearGradient(colors: [.cyan, .indigo], startPoint: .bottomLeading, endPoint: .top))
                
                VStack(spacing: 0) {
                    //"Current" text at top
                    Text("Current")
                        .font(Font.custom("JosefinSans-Regular", size: 32.0))
                        .frame(height: 50)
                    //Horizontal stack with temp and icon
                    HStack {
                        //Sets text as "temp" from widgetData
                        Text(entry.widgetData.temp)
                            .font(.system(size: 32.0))
                            .padding(.vertical, 5)
                        //Weather Symbol
                        Image(uiImage: UIImage(systemName: entry.widgetData.symbolName + ".fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28.0))!).renderingMode(.template)
                    }
                    Spacer()
                    Chart(items) { item in
                        BarMark(
                            x: .value("", item.time),
                            y: .value("", item.value)
                        )
                    }
                    .foregroundStyle(.white)
                    .opacity(0.5)
                    .chartYAxis(.hidden)
                    Spacer()
                }
            }
            .onAppear {
                for i in 1...4 {
                    items.append(Item(type: "\(i)H", value: entry.widgetData.hourlyForecast[i], time: entry.widgetData.forecastTimeArray[i - 1]))
                }
            }
        case .systemMedium:
            //Layout for medium widget
            ZStack {
                ContainerRelativeShape()
                    .fill(LinearGradient(colors: [.cyan, .indigo], startPoint: .bottomLeading, endPoint: .top))
                
                VStack(spacing: 0) {
                    Spacer()
                    //Horizontal stack with temp and icon
                    HStack(alignment: .center) {
                        //Sets text as "temp" from widgetData
                        Text(entry.widgetData.temp)
                            .font(.largeTitle)
                            
                        //Weather Symbol
                        Image(uiImage: UIImage(systemName: entry.widgetData.symbolName + ".fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28.0))!)
                            .renderingMode(.template)
                        VStack {
                            Text("Max: \(entry.widgetData.tempMax)")
                            Text("Min: \(entry.widgetData.tempMin)")
                        }
                    }
                    Spacer()
                    Chart(items) { item in
                        BarMark(x: .value("", item.time),
                                yStart: .value("", item.value - 1.5),
                                yEnd: .value("", item.value + 1.5)
                        )
                        .opacity(0.5)
                        .foregroundStyle(.primary)
                        .interpolationMethod(.monotone)
                        LineMark (
                            x: .value("", item.time),
                            y: .value("", item.value)
                        )
                        .interpolationMethod(.monotone)
                        .lineStyle(StrokeStyle(lineWidth: 4))
                    }
                    .chartYAxis(.hidden)
                    .padding(.horizontal, 5)
                    .foregroundColor(.white)
                    Spacer()
                }
            }
            .onAppear {
                for i in 1...7 {
                    items.append(Item(type: "\(i)", value: entry.widgetData.hourlyForecast[i], time: entry.widgetData.forecastTimeArray[i - 1]))
                }
                
            }
        case .systemLarge:
            //Layout for large widget
            ZStack {
                ContainerRelativeShape()
                    .fill(LinearGradient(colors: [.cyan, .indigo], startPoint: .bottomLeading, endPoint: .top))
                
                VStack(spacing: 0) {
                    Spacer()
                    //Horizontal stack with temp and icon
                    HStack(alignment: .center) {
                        //Sets text as "temp" from widgetData
                        Text(entry.widgetData.temp)
                            .font(.largeTitle)
                            
                        //Weather Symbol
                        Image(uiImage: UIImage(systemName: entry.widgetData.symbolName + ".fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28.0))!)
                            .renderingMode(.template)
                        VStack {
                            Text("Max: \(entry.widgetData.tempMax)")
                            Text("Min: \(entry.widgetData.tempMin)")
                        }
                    }
                    Spacer()
                    Chart(items) { item in
                        BarMark(x: .value("", item.time),
                                yStart: .value("", item.value - 1.5),
                                yEnd: .value("", item.value + 1.5)
                        )
                        .opacity(0.5)
                        .foregroundStyle(.primary)
                        .interpolationMethod(.monotone)
                        LineMark (
                            x: .value("", item.time),
                            y: .value("", item.value)
                        )
                        .interpolationMethod(.monotone)
                        .lineStyle(StrokeStyle(lineWidth: 4))
                    }
                    .frame(width: UIScreen.main.bounds.width - 55, height: UIScreen.main.bounds.height / 5)
                    .chartYAxis(.hidden)
                    .padding(.horizontal, 5)
                    .foregroundColor(.white)
                    Spacer()
                    Spacer()
                    VStack {
                        Text("Text")
                    }
                }
            }
            .onAppear {
                for i in 1...7 {
                    items.append(Item(type: "\(i)", value: entry.widgetData.hourlyForecast[i], time: entry.widgetData.forecastTimeArray[i - 1]))
                }
                
            }
        default:
            Text("Some other WidgetFamily in the future.")
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
        static let widgetData = WidgetData(temp: "12˚C", tempMax: "16˚C", tempMin: "8˚C", symbolName: "cloud.sun.bolt.fill", hourlyForecast: [12.0, 11.0, 11.0, 9.0, 7.0], forecastTimeArray: ["9AM", "10AM", "11AM", "12PM"])
        static var previews: some View {
            weatherkit_widgetEntryView(entry: SimpleEntry(widgetData: widgetData))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}

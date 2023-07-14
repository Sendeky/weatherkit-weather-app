//
//  WindSpeedPopUpVC.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/13/22.
//

import SwiftUI
import Charts

struct Item: Identifiable{
    var id = UUID()
    var value1: Double
    var value2: Double
}

struct WindSpeedPopUpVC: View {
    
    // @State is used because "items" changes
    // Variable for graph values
    @State var items = [Item]()
    @State var currentTime = 0  // Array for current time (for graph)
    @State var gusts = [String]()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Wind")
                    .font(Font.custom("SpaceX", size: 24.0))
                    .padding()
                HStack(alignment: .firstTextBaseline) {
                    VStack {
                        Text("\(WeatherKitData.WindSpeed)")
                            .font(Font.custom("SpaceX", size: 24.0))
                            .padding(.leading)
                        Text(WeatherKitData.WindDirection)
                            .padding(.leading)
//                            .font(Font.custom("SpaceX", size: 10.0))
                    }
                    Spacer()
                }
                VStack {
                    Color(.clear)
                        .frame(height: UIScreen.main.bounds.height / 3)
//                        .foregroundColor(.blue)
                        .overlay(Chart(items) { item in
                            // AreaMark for WindSpeed
                            AreaMark(x: .value("", item.value1 + Double(currentTime)),
                                     yStart: .value("Min", item.value1 > 0 ? item.value1  - item.value1 : item.value1 + item.value1), //ternary for when temp is less than 0
                                     yEnd: .value("Max", item.value2)
                            )
                            .opacity(0.5)
                            .foregroundStyle(.primary)
                            .interpolationMethod(.monotone)
                            // LineMark for WindSpeed (drawn on top of AreaMark)
                            LineMark (
                                x: .value("", item.value1 + Double(currentTime)),
                                y: .value("", item.value2)
                            ) //LineMark
                            .interpolationMethod(.monotone)
                            .lineStyle(StrokeStyle(lineWidth: 4))
                            
                        }) //Chart
                        .chartXScale(domain: (currentTime + 1)...(currentTime + 10))
                        .chartXAxisLabel("Time")
                        .chartYScale(domain: Int(WeatherKitData.WindSpeedForecast.min()! - 5)...Int(WeatherKitData.WindSpeedForecast.max()! + 5))
                        .chartYAxisLabel("MPH")
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        .padding()
                    
                    // Will probably do a seperate line/points on graph for gusts
                    /*
                    VStack {
                        Text("Weather Information")
                            .font(.title)
                            .padding(.bottom, 10)
                               
                        ForEach(gusts, id: \.self) { gust in
                            Text("Gust: \(gust)")
                        }
                    }
                     */
                    Spacer()
                }
            }
        }
            .background(BackgroundBlurView())
        .onAppear {
//            print(WeatherKitData.WindSpeedForecast)
            items.removeAll(keepingCapacity: false)
            
            // Min/Max length of wind forecast, because if 0 app will crash when doing range n...n+
            let ForecastMin = Int(WeatherKitData.WindSpeedForecast.min() ?? 0)
            var CastMax = Int(WeatherKitData.WindSpeedForecast.max() ?? 0)
            //checks if Forecast has more than 10 entries, so that chart doesn't get too big
            if CastMax > 10 {CastMax = 10} else {}
            
            if CastMax > 0 {
                for i in ForecastMin...CastMax {
                    items.append(Item(value1: Double(i), value2: WeatherKitData.WindSpeedForecast[i]))
                }
//                print("items: \(items)")
                // I have no bloody clue why this happens but it does. Maybe when [Items] gets initialized??
                items.remove(at: 0) //need this because the 0 item in "items" is a dummy value
            }
            
            let GustLen = WeatherKitData.WindGusts.count
            
            if (GustLen > 10) {
                // measurement formatter for gusts
                let MF = MeasurementFormatter()
                // maximum 1 digit after decimal
                MF.numberFormatter.maximumFractionDigits = 1
                // current locale (ie. mph, kmh, etc.)
                MF.locale = .current
                
                for i in 0...9 {
                    // gets (formatted to locale) string from WeatherKitData.WindGusts
                    print("MF VALUE: \(WeatherKitData.WindGusts[i].value)")
                    let gust = MF.string(from: WeatherKitData.WindGusts[i])
                    gusts.append(gust)
                }
                print("gusts \(gusts)")
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "h a"
            
            // Get the current time
            let CurrentTime = Calendar.current.dateComponents([.hour], from: Date())        // gets current time (hour)
            let currentHour = CurrentTime.hour ?? 0
            
            currentTime = currentHour
            print("currentTime: \(CurrentTime)")
            currentTime = currentTime > 12 ? currentTime - 13 : currentTime - 1     // Some extremely stupid logic to get the chart to fill up and have the time line up
                                                                                    // It's "-13" and "-1" because I think the array starts at 1
                                                                                    // (first element in windspeed array is empty, so we start with the first one, mgiht fix later)

            print("Current Time: \(currentHour)")
            
        }.edgesIgnoringSafeArea(.bottom)
    }
}


// Preview Struct
struct WindSpeedPopUpVC_Previews: PreviewProvider {
    static var previews: some View {
        WindSpeedPopUpVC()
    }
}

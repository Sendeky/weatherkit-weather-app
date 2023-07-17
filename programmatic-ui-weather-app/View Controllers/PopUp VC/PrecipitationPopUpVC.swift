//
//  PrecipitationPopUpVC.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 7/14/23.
//

import Charts
import SwiftUI

struct GraphItem: Identifiable{
    var id = UUID()
    var value1: Double
    var value2: Double
}

struct PrecipitationPopUpVC: View {
    
    // @State is used because "items" changes
    // Variable for graph values
    @State var graphItems = [GraphItem]()
    @State var currentTime = 0  // Array for current time (for graph)
    @State var chances = [Double]()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Rain")
                    .font(Font.custom("SpaceX", size: 24.0))
                    .padding()
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading) {
                        Text("\(WeatherKitData.PrecipitationChance)% Chance")
                            .font(Font.custom("SpaceX", size: 24.0))
                            .padding(.leading)
                    }
                    Spacer()
                }
                VStack {
                    Color(.clear)
                        .frame(height: UIScreen.main.bounds.height / 3)
//                        .foregroundColor(.blue)
                    
                        .overlay(Chart(graphItems) { item in
                            // AreaMark for WindSpeed
                            AreaMark(x: .value("", item.value1 + Double(currentTime)),
                                     yStart: .value("Min", item.value2),
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
                        .chartYScale(domain: 0...100) // 0-100%
                        .chartYAxisLabel("%")
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        .padding()
                    Spacer()
                }
            }
        }.background(BackgroundBlurView())      //BackgroundBlurView is from "SwiftUIBackgroundBlur.swift" in "AnimationsEffects" folder
            .onAppear{
                // cleans graphItems in case something is left
                graphItems.removeAll(keepingCapacity: false)
                
                // Min/Max length of precipitationChance forecast, because if 0 app will crash when doing range n...n+
                let CastMin = Int(WeatherKitData.PrecipitationChanceForecast.min() ?? 0)
                var CastMax = Int(WeatherKitData.PrecipitationChanceForecast.count)
                
                //checks if Forecast has more than 10 entries, so that chart doesn't get too big
                if CastMax > 10 {CastMax = 10} else {}
                
                if CastMax > 0 {
                    for i in CastMin...CastMax {
//                        graphItems.append(GraphItem(value1: Double(i), value2: WeatherKitData.PrecipitationChanceForecast[i]))
                        graphItems.append(GraphItem(value1: Double(i), value2: WeatherKitData.PrecipitationChanceForecast[i]))
                    }
                    
                    // I have no clue why this happens. Maybe when [GraphItems] gets initialized?
                    graphItems.remove(at: 0) //need this because the 0 item in "items" is a dummy value
                    print("graphItems: \(graphItems)")
                }
                
                // gets currentTime
                let CurrentTime = (Calendar.current.dateComponents([.hour], from: Date()))        // gets current time (hour)
//                print("CT: \(CurrentTime.hour)")
                if var currentHour = CurrentTime.hour {
                    currentHour = currentHour > 12 ? currentHour - 12 : currentHour
                    currentTime = currentHour
                }
                                   
            }
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct PrecipitationPopUpVC_Previews: PreviewProvider {
    static var previews: some View {
        PrecipitationPopUpVC()
    }
}

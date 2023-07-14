//
//  PrecipitationPopUpVC.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 7/14/23.
//

import SwiftUI

struct PrecipitationPopUpVC: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Precipitation")
                    .font(Font.custom("SpaceX", size: 24.0))
                    .padding()
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading) {
                        Text("Rain Chance: ")
                            .font(Font.custom("SpaceX", size: 24.0))
                            .padding(.leading)
                        Text("32%")
                            .font(Font.custom("SpaceX", size: 18.0))
                            .padding(.leading)
                    }
                    Spacer()
                }
                VStack {
                    Color(.clear)
                        .frame(height: UIScreen.main.bounds.height / 3)
//                        .foregroundColor(.blue)
                    /*
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
                     */
                    Spacer()
                }
            }
        }
    }
}

struct PrecipitationPopUpVC_Previews: PreviewProvider {
    static var previews: some View {
        PrecipitationPopUpVC()
    }
}

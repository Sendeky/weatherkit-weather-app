//
//  SunriseSunsetPopUpVC.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/12/22.
//

import SwiftUI
import Charts


struct Item: Identifiable{
    var id = UUID()
    var value1: Double
    var value2: Double
}

struct SunriseSunsetPopUpVC: View {
    
    //@State is used because "items" changes
    @State var items: [Item] = [
        Item(value1: 0.0, value2: 0.0),
        Item(value1: 24.0, value2: 0.0),
    ]

        
    var body: some View {
        
        ZStack {
            Color(UIColor(red: 125.0/255.0, green: 175.0/255.0, blue: 255.0/255.0, alpha: 1.0))
            VStack(spacing: 0){
                //Title
                Text("Sunrise & Sunset")
                    .font(Font.custom("JosefinSans-Regular", size: 32.0))
                    .padding()
                //Rounded Rectangle with Line Chart
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 300)
                        .padding(.top, 5)
                        .padding(.horizontal, 10)
                        .foregroundColor(.blue)
                        //Overlays Chart over Rounded Rectangle
                        .overlay(Chart(items) { item in
//                            BarMark(
//                                x: .value("department", item.type),
//                                y: .value("Profit", item.value)
//                            )
                            AreaMark(
                                x: .value("Department", item.value1),
                                y: .value("Profit", item.value2)
                            )
                            .interpolationMethod(.monotone)
                            .foregroundStyle(.yellow)
                            //Outline on Graph
                            LineMark(
                                x: .value("Department", item.value1),
                                y: .value("Profit", item.value2)
                            )
                            .foregroundStyle(.black)
                            .lineStyle(StrokeStyle(lineWidth: 3))
                            .interpolationMethod(.monotone)
                        }.padding(.all, 25))
                    
                }
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 40)
                        .padding(.top, 15)
                        .padding(.horizontal, 10)
                        .foregroundColor(.blue)
                        .overlay(Text("Solar Noon: \(WeatherKitData.AstronomicalDawn)"))
                }
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 40)
                        .padding(.top, 15)
                        .padding(.horizontal, 10)
                        .foregroundColor(.blue)
                        .overlay(Text("Astronomical Dawn: \(WeatherKitData.AstronomicalDawn)"))
                }
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 40)
                        .padding(.top, 15)
                        .padding(.horizontal, 10)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .overlay(Text("Astronomical Dusk: \(WeatherKitData.AstronomicalDawn)"))
                }
                Spacer()
            }
        }
        .onAppear {
            if sunEventHour.sunriseHour > 0 {
                items = [
                    Item(value1: 0.0, value2: 0.5),
                    Item(value1: Double(sunEventHour.sunriseHour), value2: 1.0),
                    Item(value1: (Double(sunEventHour.sunsetHour) - Double(sunEventHour.sunriseHour)), value2: 2.0),
                    Item(value1: Double(sunEventHour.sunsetHour), value2: 1.0),
                    Item(value1: 24.0, value2: 0.5),
                ]
            }
        }
    }
}

struct SunriseSunsetPopUpVC_Previews: PreviewProvider {
    static var previews: some View {
        SunriseSunsetPopUpVC()
    }
}

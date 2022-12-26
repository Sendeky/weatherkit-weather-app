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
                    .font(.largeTitle)
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
                            BarMark(x: .value("Department", item.value1),
                                     yStart: .value("Min", item.value2 - 2),
                                     yEnd: .value("Max", item.value2 + 2)
                            )
                            .opacity(0.5)
                            .foregroundStyle(.orange)
                            LineMark(
                                x: .value("Department", item.value1),
                                y: .value("Profit", item.value2)
                            )
                            .interpolationMethod(.monotone)
                            .foregroundStyle(.yellow)
                            .lineStyle(StrokeStyle(lineWidth: 3))
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
        }.ignoresSafeArea()
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

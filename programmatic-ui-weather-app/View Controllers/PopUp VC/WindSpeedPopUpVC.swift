//
//  WindSpeedPopUpVC.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/13/22.
//

import SwiftUI
import Charts

struct WindSpeedPopUpVC: View {
    
    //@State is used because "items" changes
    @State var items: [Item] = [
        Item(value1: 0.0, value2: 0.0),
        Item(value1: 24.0, value2: 0.0),
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 125.0/255.0, green: 175.0/255.0, blue: 255.0/255.0, alpha: 1.0))
            VStack {
                Text("Wind")
                    .font(.largeTitle)
                    .padding()
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 300)
                        .padding(.top, 5)
                        .padding(.horizontal, 10)
                        .foregroundColor(.blue)
                        .overlay(Chart(items) { item in
                            BarMark(x: .value("Department", item.value1),
                                     yStart: .value("Min", item.value2 - 3),
                                     yEnd: .value("Max", item.value2 + 3)
                            )
                        }
                        
                        )
                }
                Spacer()
            }
        }
        .onAppear {
            if WeatherKitData.WindSpeedForecast.isEmpty == false {
                for i in 0...9 {
                    
                    print("Wind speed forecast \(WeatherKitData.WindSpeedForecast[i])")
                    Item(value1: Double(i), value2: WeatherKitData.WindSpeedForecast[i])
                }
            }
        }
    }
}

struct WindSpeedPopUpVC_Previews: PreviewProvider {
    static var previews: some View {
        WindSpeedPopUpVC()
    }
}

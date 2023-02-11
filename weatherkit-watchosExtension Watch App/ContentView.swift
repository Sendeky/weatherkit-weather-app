//
//  ContentView.swift
//  weatherkit-watchosExtension Watch App
//
//  Created by Ruslan Spirkin on 2/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //        NavigationView {
        /*
         List {
         CurrentView(currentTemp: "12˚C")
         }
         .navigationTitle("Weather")
         .listStyle(DefaultListStyle())
         */
        //            List {
        //                CurrentView(currentTemp: "12˚C").frame(width: WKInterfaceDevice.current().screenBounds.width, alignment: .center)
        //                RangeView(minTemp: "7", maxTemp: "12").frame(width: WKInterfaceDevice.current().screenBounds.width, alignment: .center)
        //            }
        TabView {
            List {
                CurrentView(currentTemp: "12˚C")
                RangeView(minTemp: "7˚", maxTemp: "12˚")
                WindView(windSpeed: "12 MPH")
            }
            List {
                ForecastView(forecast: [Forecast(temp: "12 MPH"), Forecast(temp: "12 MPH"), Forecast(temp: "12 MPH")])
            }
        }
        .listStyle(CarouselListStyle())
        //            .navigationTitle("Weather")
        //            .background(LinearGradient(colors: [.black, .purple], startPoint: .top, endPoint: .bottom))
        //        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

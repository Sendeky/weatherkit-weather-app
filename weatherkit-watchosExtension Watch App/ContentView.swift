//
//  ContentView.swift
//  weatherkit-watchosExtension Watch App
//
//  Created by Ruslan Spirkin on 2/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            List {
                CurrentView(currentTemp: "12˚C")
                RangeView(minTemp: "7˚", maxTemp: "12˚")
                WindView(windSpeed: "12 MPH")
            }
            List {
                ForecastView(forecast: [Forecast(temp: "12 MPH"), Forecast(temp: "12 MPH"), Forecast(temp: "12 MPH"), Forecast(temp: "12 MPH"),Forecast(temp: "12 MPH")])
            }
        }
        .listStyle(CarouselListStyle())
        .onAppear {
            weatherCall()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

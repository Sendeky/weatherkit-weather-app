//
//  ContentView.swift
//  weatherkit-watchosExtension Watch App
//
//  Created by Ruslan Spirkin on 2/2/23.
//

import SwiftUI

struct ContentView: View {

    @State var curr: Double
    
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
            Task {
                do {
                    //TODO: Clean This Up
                
                    let formatter = MeasurementFormatter()
                    formatter.unitStyle = .short
                    formatter.unitOptions = .temperatureWithoutUnit
                    
                    let response = try await weatherCall()
                    
                    let temp = response.0.temperature
                    
                    curr = temp
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

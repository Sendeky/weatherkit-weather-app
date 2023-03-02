//
//  ContentView.swift
//  weatherkit-watchosExtension Watch App
//
//  Created by Ruslan Spirkin on 2/2/23.
//

import SwiftUI

struct ContentView: View {

    @State var curr: String
    
    var body: some View {
        TabView {
            List {
                CurrentView(currentTemp: "\(curr)˚C")
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
                    
                    let temp = response.curr
                    
                    curr = temp
                    print(curr)
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
        ContentView(curr: "0.0")
    }
}

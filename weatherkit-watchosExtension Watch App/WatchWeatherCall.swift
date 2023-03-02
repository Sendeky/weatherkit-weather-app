//
//  WatchWeatherCall.swift
//  weatherkit-watchosExtension Watch App
//
//  Created by Ruslan Spirkin on 2/17/23.
//

import CoreLocation
import Foundation
import WeatherKit


extension ContentView {
    func weatherCall() async throws -> WatchWeatherModel {
        
        
        var model = WatchWeatherModel(curr: "")
        let weatherService = WeatherService()
        let location = CLLocation(latitude: CLLocationDegrees(38.0), longitude: CLLocationDegrees(-122.0))
        
//        Task {
            do {
                let calendar = Calendar.current
                let endDate = calendar.date(byAdding: .hour, value: 12,to: Date.now)
                let result = try await weatherService.weather(for: location, including: .current, .hourly(startDate: Date.now, endDate: endDate!), .daily)
                
                let formatter = MeasurementFormatter()
                
                let temp = formatter.string(from: result.0.temperature)
                
                model.curr = temp
                //            await test.appendWeather(result: result.0.temperature.value)
                //            print("WeatherResult.curr: \(await test.weatherResult.curr)")
            }
            catch {
                print("WatchWeatherCall error: \(error.localizedDescription)")
            }
//        }
        return model
    }
    
    actor test {
        var weatherResult: WatchWeatherModel = WatchWeatherModel(curr: "0.0")
        
        func appendWeather(result: String) {
            weatherResult.curr = result
        }
    }
}

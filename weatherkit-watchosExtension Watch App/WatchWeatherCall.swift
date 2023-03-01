//
//  WatchWeatherCall.swift
//  weatherkit-watchosExtension Watch App
//
//  Created by Ruslan Spirkin on 2/17/23.
//

import CoreLocation
import Foundation
import WeatherKit

func weatherCall() async throws -> [WeatherData] {
    
    let test = test()
    let weatherService = WeatherService()
    let location = CLLocation(latitude: CLLocationDegrees(38.0), longitude: CLLocationDegrees(-122.0))
    
    Task {
        do {
            let calendar = Calendar.current
            let endDate = calendar.date(byAdding: .hour, value: 12,to: Date.now)
            let result = try await weatherService.weather(for: location, including: .current, .hourly(startDate: Date.now, endDate: endDate!), .daily)
            
            await test.appendWeather(result: result.0.temperature.value)
            print("WeatherResult.curr: \(await test.weatherResult.curr)") 
        }
        catch {
            print("WatchWeatherCall error: \(error.localizedDescription)")
        }
    }
}

actor test {
    var weatherResult: WatchWeatherModel = WatchWeatherModel(curr: 0.0)
    
    func appendWeather(result: Double) {
        weatherResult.curr = result
    }
}

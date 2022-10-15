//
//  DateConverter.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/15/22.
//

import Foundation


class DateConverter{
}

extension MainViewController {
    func convertEpochToDate() {
        let sunriseTime = Date(timeIntervalSince1970: RawWeatherData.sunriseResult)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeZone = .current
        let localSunrise = dateFormatter.string(from: sunriseTime)
        print("localDate: \(localSunrise)")
        WeatherData.localSunrise = localSunrise
        print("WeatherData.localDate: \(WeatherData.localSunrise)")
        
        let sunsetTime = Date(timeIntervalSince1970: RawWeatherData.sunsetResult)
        let localSunset = dateFormatter.string(from: sunsetTime)
        WeatherData.localSunset = localSunset
    }
}

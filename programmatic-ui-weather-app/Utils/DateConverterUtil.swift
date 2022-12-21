//
//  DateConverter.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/15/22.
//

import Foundation

struct sunEventHour {
    static var sunriseHour = 0
    static var sunsetHour = 0
}
struct timeArray {
    static var date = [String]()
}

class DateConverter{
    func convertDateToEpoch() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let sunriseHour = Calendar.current.component(.hour, from: WeatherKitData.SunriseDate)
        print("SunriseHour: \(sunriseHour)")
        sunEventHour.sunriseHour = sunriseHour
        let sunsetHour = Calendar.current.component(.hour, from: WeatherKitData.SunsetDate)
        print("SunsetHour: \(sunsetHour)")
        sunEventHour.sunsetHour = sunsetHour
    }
    
    func timeArrayMaker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh a" //"a" prints am or pm
        let startTime = Date.now
        for i in 0...10{
            let hour = (Calendar.current.date(byAdding: .hour, value: i, to: startTime)!)
            let h = dateFormatter.string(from: hour)
            timeArray.date.append(h)
        }
    }
}

/* MARK: DEPRECATED
extension MainViewController {
    func convertEpochToDate() {
        let sunriseTime = Date(timeIntervalSince1970: RawWeatherData.sunriseResult)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeZone = .current
        let localSunrise = dateFormatter.string(from: sunriseTime)
        print("localDate: \(localSunrise)")
        WeatherData.localSunrise = localSunrise DEPRECATED
        print("WeatherData.localDate: \(WeatherData.localSunrise)") DEPRECATED
        
        let sunsetTime = Date(timeIntervalSince1970: RawWeatherData.sunsetResult)
        let localSunset = dateFormatter.string(from: sunsetTime)
        WeatherData.localSunset = localSunset DEPRECATED
    }
}
*/

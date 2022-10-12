//
//  WeatherAPINetworkingUtil.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/12/22.
//

import Foundation
import SwiftyJSON

//let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(globalUserLatitude)&lon=\(globalUserLongitude)&appid=\(constants.API_KEY)"
let constants = Constants()
let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=51.5072&lon=0.1276&appid=\(constants.API_KEY)" //Testing for London

struct WeatherData {
    static var weatherTemp = ""
    static var weatherFeelsLike = ""
    static var weatherTempMin = ""
    static var weatherTempMax = ""
    static var weatherDesc = ""
    static var cityName = ""
    static var sunriseResult = Double()
    static var sunsetResult = Double()
    static var localSunrise = ""
    static var localSunset = ""
}

class WeatherAPINetworkingUtil{
}

extension MainViewController {
    func fetchWeather() {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let result = JSON(data)
                
                print(result)
                
                WeatherData.weatherTemp = result["main"]["temp"].stringValue
                WeatherData.weatherFeelsLike = result["main"]["feels_like"].stringValue
                WeatherData.weatherTempMin = result["main"]["temp_min"].stringValue
                WeatherData.weatherTempMax = result["main"]["temp_max"].stringValue
                WeatherData.weatherDesc = result["weather"][0]["description"].stringValue
                WeatherData.cityName = result["name"].stringValue
                WeatherData.sunriseResult = result["sys"]["sunrise"].doubleValue
                WeatherData.sunsetResult = result["sys"]["sunset"].doubleValue
            }
        }
    }
}

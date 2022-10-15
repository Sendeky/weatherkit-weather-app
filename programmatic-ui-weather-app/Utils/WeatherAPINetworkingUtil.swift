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
let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=38.138591&lon=-122.1885952&appid=\(constants.API_KEY)" //Testing for London

struct RawWeatherData {
    static var WeatherTempKelvin = ""
    static var weatherFeelsLikeKelvin = ""
    static var weatherTempMinKelvin = ""
    static var weatherTempMaxKelvin = ""
    static var weatherDesc = ""
    static var cityName = ""
    static var sunriseResult = Double()
    static var sunsetResult = Double()
    static var rainAmount = Double()
    static var windSpeed = Double()
    static var humidity = Int()
}

class WeatherAPINetworkingUtil{
}

extension MainViewController {
    func fetchWeather() {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let result = JSON(data)
                
                print(result)
                
                RawWeatherData.WeatherTempKelvin = result["main"]["temp"].stringValue
                RawWeatherData.weatherFeelsLikeKelvin = result["main"]["feels_like"].stringValue
                RawWeatherData.weatherTempMinKelvin = result["main"]["temp_min"].stringValue
                RawWeatherData.weatherTempMaxKelvin = result["main"]["temp_max"].stringValue
                RawWeatherData.weatherDesc = result["weather"][0]["description"].stringValue
                RawWeatherData.cityName = result["name"].stringValue
                RawWeatherData.sunriseResult = result["sys"]["sunrise"].doubleValue
                RawWeatherData.sunsetResult = result["sys"]["sunset"].doubleValue
                RawWeatherData.rainAmount = result["rain"]["1h"].doubleValue
                RawWeatherData.windSpeed = result["wind"]["speed"].doubleValue
                RawWeatherData.humidity = result["main"]["humidity"].intValue
            }
        }
    }
}

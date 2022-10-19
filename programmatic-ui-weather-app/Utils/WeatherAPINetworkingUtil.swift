//
//  WeatherAPINetworkingUtil.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/12/22.
//

import Foundation
import SwiftyJSON

struct urlString {
    static var urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\((UserLocation.userLatitude)!)&lon=\((UserLocation.userLongitude)!)&appid=\(constants.API_KEY)" //
}

//let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(globalUserLatitude)&lon=\(globalUserLongitude)&appid=\(constants.API_KEY)"
let constants = Constants()

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
    static var pressure = Double()
}

class WeatherAPINetworkingUtil{
}

extension MainViewController {
    func fetchWeather() {
        if let url = URL(string: urlString.urlString) {
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
                RawWeatherData.pressure = result["main"]["pressure"].doubleValue
                
                NotificationCenter.default.post(name: Notification.Name("apiCallFinished"), object: nil)
                
            }
        }
    }
}

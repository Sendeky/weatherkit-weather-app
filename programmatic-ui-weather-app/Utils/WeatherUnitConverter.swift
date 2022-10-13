//
//  WeatherUnitConverter.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/12/22.
//

import Foundation


struct WeatherData {
    static var WeatherTempCelsius = 0
    static var WeatherFeelsLikeCelsius = 0
    static var WeatherTempMinCelsius = 0
    static var WeatherTempMaxCelsius = 0
}

class WeatherUnitConverter {
}

extension MainViewController {
    func convertKelvinIntoCelsius() {
        WeatherData.WeatherTempCelsius = Int(round(Double(RawWeatherData.WeatherTempKelvin)! - 273.0))
        WeatherData.WeatherFeelsLikeCelsius = Int(round(Double(RawWeatherData.weatherFeelsLikeKelvin)! - 273.0))
        WeatherData.WeatherTempMinCelsius = Int(round(Double(RawWeatherData.weatherTempMinKelvin)! - 273.0))
        WeatherData.WeatherTempMaxCelsius = Int(round(Double(RawWeatherData.weatherTempMaxKelvin)! - 273.0))
    }
}

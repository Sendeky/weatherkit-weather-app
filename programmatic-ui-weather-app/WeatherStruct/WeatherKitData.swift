//
//  WeatherKitData.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 1/16/23.
//

import Foundation

struct WeatherKitData: Codable{
    //RAW values for other funcs
    static var SunriseDate = Date()
    static var SunsetDate = Date()
    
    //Normal, converted values
    static var Temp = ""
    static var TempMax = ""
    static var TempMaxForecast = [String]()
    static var TempMin = ""
    static var TempMinForecast = [String]()
    static var TempFeels = 0
    static var UV = 0
    static var WindSpeed = ""
    static var WindDirection = ""
    static var Symbol = ""
    static var forecastSymbol = [String]()
    static var Humidity = 0
    static var Sunrise = Date()
    static var Sunset = Date()
    static var localSunrise = ""
    static var localSunset = ""
    static var SolarNoon = ""
    static var AstronomicalDawn = ""
    static var AstronomicalDusk = ""
    static var Pressure = ""
    static var RainChance = 0
    static var WindSpeedForecast = [0.0]
    static var HourlyForecast = [0.0]
    static var HourlyForecastSymbol = [String]()
}

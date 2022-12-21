//
//  WidgetStruct.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/7/22.
//

import Foundation

//Struct for widgetData
struct WidgetData: Codable {
    var temp: String
    var tempMax: String
    var tempMin: String
    var symbolName: String
    var hourlyForecast: [Double]
    var forecastTimeArray: [String]
}

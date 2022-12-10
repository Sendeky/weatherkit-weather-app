//
//  WidgetStruct.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/7/22.
//

import Foundation

struct Car : Codable {
    var make : String
    var model : String
    var owner : String
}

struct WidgetData: Codable {
    var temp: String
    var tempMax: String
    var tempMin: String
}

//
//  ConvertPressureUtil.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/17/22.
//

import Foundation

class convertPressureUtil{
}

extension MainViewController {
    func convertHPAtoInHg() {
        WeatherData.pressureInHg = RawWeatherData.pressure * 0.029529
        WeatherData.pressureInHg = round(WeatherData.pressureInHg * 100) / 100.0
    }
}

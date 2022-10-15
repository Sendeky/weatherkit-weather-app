//
//  CheckTimeUtil.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/15/22.
//

import Foundation

class CheckTimeUtil{
}

extension MainViewController {
    func checkTime() -> Bool {
        
        let currentTime = Date().timeIntervalSince1970
        print(currentTime)
        print(RawWeatherData.sunsetResult)
        
        if (currentTime >= RawWeatherData.sunsetResult) {
            print("Sunset has happened")
            return true
        } else {
            print("Sunset hasn't happened")
            return false
        }
    }
}

//
//  PrimaryData.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/10/22.
//

import SwiftUI
import WidgetKit

struct PrimaryData {
    //APP GROUP NAME IS IMPORTANT!! ("widgetData")
    @AppStorage("widgetData", store: UserDefaults(suiteName: "group.com.ES.weatherkit-programmatic-app")) var primaryData : Data = Data()
    let widgetData : WidgetData
    
    func encode() {
        guard let data = try? JSONEncoder().encode(widgetData) else {
            return
        }
        primaryData = data
        WidgetCenter.shared.reloadAllTimelines()
    }
}

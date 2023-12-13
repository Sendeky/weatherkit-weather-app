//
//  File.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 12/13/23.
//

import Foundation
import UIKit

extension iPadMainViewController {
    func createSunsetView() {
        sunsetView.translatesAutoresizingMaskIntoConstraints = false
        sunsetView.layer.cornerRadius = 15
        sunsetView.axis = .vertical
        sunsetView.backgroundColor = cyanColor
        sunsetView.isLayoutMarginsRelativeArrangement = true
        sunsetView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        
        
        let sunsetViewTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Sunset & Sunrise"
            label.textAlignment = .center
            return label
        }()
        let sunriseLabel: UILabel = {
            let label = UILabel()
            label.text = "Sunrise: --"
            label.textAlignment = .center
            return label
        }()
        let sunsetLabel: UILabel = {
            let label = UILabel()
            label.text = "Sunset: --"
            label.textAlignment = .center
            return label
        }()
        let AMPMFormatter = DateFormatter()
        AMPMFormatter.dateFormat = "hh:mm a"
        
        sunriseLabel.text = "Sunrise: \(AMPMFormatter.string(from: WeatherKitData.Sunrise))"
        sunsetLabel.text = "Sunset: \(AMPMFormatter.string(from: WeatherKitData.Sunset))"
        
        sunsetView.addArrangedSubview(sunsetViewTitleLabel)
        sunsetView.addArrangedSubview(sunriseLabel)
        sunsetView.addArrangedSubview(sunsetLabel)
    }
}

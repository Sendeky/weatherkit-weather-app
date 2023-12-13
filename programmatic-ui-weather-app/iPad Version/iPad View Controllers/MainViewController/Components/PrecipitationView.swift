//
//  PrecipitationView.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/14/23.
//

import Foundation
import UIKit

extension iPadMainViewController {
    func createPrecipitationView() {
        precipitationView.translatesAutoresizingMaskIntoConstraints = false
        precipitationView.layer.cornerRadius = 15
        precipitationView.axis = .vertical
        precipitationView.backgroundColor = cyanColor
        precipitationView.isLayoutMarginsRelativeArrangement = true
        precipitationView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        precipitationView.spacing = 20
        
        let PrecipitationViewTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Precipitation"
            label.textAlignment = .center
            return label
        }()
        
        let PrecipitationChanceLabel: UILabel = {
            let label = UILabel()
            label.text = "--"
            label.textAlignment = .center
            return label
        }()
        
        PrecipitationChanceLabel.text = "\(WeatherKitData.PrecipitationChance)% Chance"
        
        precipitationView.addArrangedSubview(PrecipitationViewTitleLabel)
        precipitationView.addArrangedSubview(PrecipitationChanceLabel)
    }
}

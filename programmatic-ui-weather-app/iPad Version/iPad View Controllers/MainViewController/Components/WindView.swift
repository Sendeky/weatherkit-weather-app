//
//  WindView.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/14/23.
//

import Foundation
import UIKit

extension iPadMainViewController {
    func createWindView() {
        windView.translatesAutoresizingMaskIntoConstraints = false
        windView.layer.cornerRadius = 15
        windView.axis = .vertical
        windView.backgroundColor = cyanColor
        windView.isLayoutMarginsRelativeArrangement = true
        windView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        windView.spacing = 20
        
        let WindViewTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Wind"
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 18.0)
            return label
        }()
        
        let WindSpeedLabel: UILabel = {
            let label = UILabel()
            label.text = "--"
            label.textAlignment = .center
            return label
        }()
        
        WindSpeedLabel.text = "\(WeatherKitData.WindSpeed)"
        windView.addArrangedSubview(WindViewTitleLabel)
        windView.addArrangedSubview(WindSpeedLabel)
    }
}

//
//  iPadHumidityStack.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/5/23.
//

import UIKit

extension iPadMainViewController {
    func createHumidityView() {
        humidityView.translatesAutoresizingMaskIntoConstraints = false
        humidityView.axis = .vertical
        humidityView.spacing = 15
        humidityView.backgroundColor = cyanColor
        humidityView.layer.cornerRadius = 15
        humidityView.isLayoutMarginsRelativeArrangement = true
        humidityView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        
        
        let humidityTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Humidity"
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .boldSystemFont(ofSize: 18.0)
            return label
        }()
        
        let humidityLabel: UILabel = {
            let label = UILabel()
            label.text = "humidity"
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let dewPointLabel: UILabel = {
            let label = UILabel()
            label.text = "dew point"
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        humidityLabel.text = "\(WeatherKitData.Humidity)%"
        humidityView.addArrangedSubview(humidityTitleLabel)
        humidityView.addArrangedSubview(humidityLabel)
//        humidityView.addArrangedSubview(dewPointLabel)
    }
}

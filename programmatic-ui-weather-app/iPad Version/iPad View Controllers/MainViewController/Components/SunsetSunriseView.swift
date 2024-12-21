//
//  File.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 12/13/23.
//

import Foundation
import UIKit

//extension iPadMainViewController {
//    func createSunsetView() {
//        sunsetView.translatesAutoresizingMaskIntoConstraints = false
//        sunsetView.layer.cornerRadius = 15
//        sunsetView.axis = .vertical
//        sunsetView.spacing = 10
//        sunsetView.backgroundColor = cyanColor
//        sunsetView.isLayoutMarginsRelativeArrangement = true
//        sunsetView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//
//
//        let sunsetViewTitleLabel: UILabel = {
//            let label = UILabel()
//            label.text = "Sunset & Sunrise"
//            label.textAlignment = .center
//            label.font = .boldSystemFont(ofSize: 18.0)
//            return label
//        }()
//        let sunriseLabel: UILabel = {
//            let label = UILabel()
//            label.text = "Sunrise: --"
//            label.textAlignment = .center
//            return label
//        }()
//        let sunsetLabel: UILabel = {
//            let label = UILabel()
//            label.text = "Sunset: --"
//            label.textAlignment = .center
//            return label
//        }()
//        let AMPMFormatter = DateFormatter()
//        AMPMFormatter.dateFormat = "hh:mm a"
//
//        sunriseLabel.text = "Sunrise: \(AMPMFormatter.string(from: WeatherKitData.Sunrise))"
//        sunsetLabel.text = "Sunset: \(AMPMFormatter.string(from: WeatherKitData.Sunset))"
//
//        sunsetView.addArrangedSubview(sunsetViewTitleLabel)
//        sunsetView.addArrangedSubview(sunriseLabel)
//        sunsetView.addArrangedSubview(sunsetLabel)
//    }
//}

class iPadSunsetView: UIView {
    // MARK: - Properties
    private let AMPMFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()
    
    let sunsetView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = 15
        stack.axis = .vertical
        stack.spacing = 10
        stack.backgroundColor = cyanColor
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return stack
    }()
    
    let sunsetViewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunset & Sunrise"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18.0)
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
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Setup
    func setupUI() {
        // Add subviews to stack
        sunsetView.addArrangedSubview(sunsetViewTitleLabel)
        sunsetView.addArrangedSubview(sunriseLabel)
        sunsetView.addArrangedSubview(sunsetLabel)
        
        // Add stack to view
        addSubview(sunsetView)
        
        // Setup constraints for sunsetView to fill SunsetView
        NSLayoutConstraint.activate([
            sunsetView.topAnchor.constraint(equalTo: topAnchor),
            sunsetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sunsetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sunsetView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        updateSunsetLabels(WeatherKitData.Sunrise, WeatherKitData.Sunset)
    }
    
    // MARK: - Public Methods
    func updateSunsetLabels(_ value1: Date, _ value2: Date) {
        sunriseLabel.text = "Sunrise: \(AMPMFormatter.string(from: value1))"
        sunsetLabel.text = "Sunset: \(AMPMFormatter.string(from: value2))"
    }
}

//
//  PressureView.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/14/23.
//

import Foundation
import UIKit

extension iPadMainViewController {
    func createPressureView() {
        pressureView.translatesAutoresizingMaskIntoConstraints = false
        pressureView.layer.cornerRadius = 15
        pressureView.axis = .vertical
        pressureView.backgroundColor = cyanColor
        pressureView.isLayoutMarginsRelativeArrangement = true
        pressureView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        pressureView.spacing = 20
        
        let PressureViewTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Pressure"
            label.textAlignment = .center
            return label
        }()
        
        let PressureLabel: UILabel = {
            let label = UILabel()
            label.text = "--"
            label.textAlignment = .center
            return label
        }()
        
        pressureView.addArrangedSubview(PressureViewTitleLabel)
        pressureView.addArrangedSubview(PressureLabel)
    }
}

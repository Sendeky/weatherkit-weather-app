//
//  testExt.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/13/23.
//

import Foundation
import UIKit

extension iPadMainViewController {
    func createUVView() {
        UVView.translatesAutoresizingMaskIntoConstraints = false
        UVView.layer.cornerRadius = 15
        UVView.axis = .vertical
        UVView.backgroundColor = cyanColor
        
        let UVViewTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "UV Index"
            label.textAlignment = .center
            return label
        }()
        
        let UVLabel: UILabel = {
            let label = UILabel()
            label.text = "--"
            label.textAlignment = .center
            return label
        }()
        
        UVView.addArrangedSubview(UVViewTitleLabel)
        UVView.addArrangedSubview(UVLabel)
    }
}

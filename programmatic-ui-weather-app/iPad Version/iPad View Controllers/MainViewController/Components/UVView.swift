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
//        UVView.isLayoutMarginsRelativeArrangement = true
        UVView.isLayoutMarginsRelativeArrangement = true
        UVView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        UVView.spacing = 20
        
        let UVViewTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "UV Index"
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 18.0)
            return label
        }()
        
        let UVLabel: UILabel = {
            let label = UILabel()
            label.text = "--"
            label.textAlignment = .center
            return label
        }()
        
        uvProgressView.layer.addSublayer(uvGradientLayer)
        NSLayoutConstraint.activate([
            uvProgressView.heightAnchor.constraint(equalToConstant: 6),
//            uvProgressView.leadingAnchor.constraint(equalTo: UVView.leadingAnchor, constant: 10),
//            uvProgressView.trailingAnchor.constraint(equalTo: UVView.trailingAnchor, constant: -10)
        ])
        
        UVLabel.text = "\(WeatherKitData.UV)"
        UVView.addArrangedSubview(UVViewTitleLabel)
        UVView.addArrangedSubview(UVLabel)
        UVView.addArrangedSubview(uvProgressView)
    }
    
    // Stuff so that uvGradientLayer frame works
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update gradient layer frame
        uvGradientLayer.frame = uvProgressView.bounds
    }
    
    // Function to update the UVIndex
    func updateUVIndex(_ value: Int) {
        // Create a mask layer to achieve the progress bar effect
        let maskLayer = CALayer()
        let clampedValue = min(max(value, 0), 11)
        let percentage = CGFloat(clampedValue) / 11.0
        
        // The gradient layer should always be full width
        uvGradientLayer.frame = uvProgressView.bounds
        
        // Create a mask that only shows a portion of the gradient
        maskLayer.frame = CGRect(x: 0, y: 0,
                               width: uvProgressView.bounds.width * percentage,
                               height: uvProgressView.bounds.height)
        maskLayer.backgroundColor = UIColor.white.cgColor
        
        // Apply the mask to the gradient layer
        uvGradientLayer.mask = maskLayer
    }
}

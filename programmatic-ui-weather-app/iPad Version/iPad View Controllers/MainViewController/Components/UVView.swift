//
//  testExt.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/13/23.
//

import Foundation
import UIKit

//extension iPadMainViewController {
//
//    func createUVView() {
//        UVView.translatesAutoresizingMaskIntoConstraints = false
//        UVView.layer.cornerRadius = 15
//        UVView.axis = .vertical
//        UVView.backgroundColor = cyanColor
////        UVView.isLayoutMarginsRelativeArrangement = true
//        UVView.isLayoutMarginsRelativeArrangement = true
//        UVView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        UVView.spacing = 20
//
//        let UVViewTitleLabel: UILabel = {
//            let label = UILabel()
//            label.text = "UV Index"
//            label.textAlignment = .center
//            label.font = .boldSystemFont(ofSize: 18.0)
//            return label
//        }()
//
//        let UVLabel: UILabel = {
//            let label = UILabel()
//            label.text = "--"
//            label.textAlignment = .center
//            return label
//        }()
//
//        uvProgressView.layer.addSublayer(uvGradientLayer)
//        NSLayoutConstraint.activate([
//            uvProgressView.heightAnchor.constraint(equalToConstant: 6),
////            uvProgressView.leadingAnchor.constraint(equalTo: UVView.leadingAnchor, constant: 10),
////            uvProgressView.trailingAnchor.constraint(equalTo: UVView.trailingAnchor, constant: -10)
//        ])
//
//        UVLabel.text = "\(WeatherKitData.UV)"
//        UVView.addArrangedSubview(UVViewTitleLabel)
//        UVView.addArrangedSubview(UVLabel)
//        UVView.addArrangedSubview(uvProgressView)
//    }
//
//    // Stuff so that uvGradientLayer frame works
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        // Update gradient layer frame
//        uvGradientLayer.frame = uvProgressView.bounds
//    }
//
//    // Function to update the UVIndex
//    func updateUVIndex(_ value: Int) {
//        // Create a mask layer to achieve the progress bar effect
//        let maskLayer = CALayer()
//        let clampedValue = min(max(value, 0), 11)
//        let percentage = CGFloat(clampedValue) / 11.0
//
//        // The gradient layer should always be full width
//        uvGradientLayer.frame = uvProgressView.bounds
//
//        // Create a mask that only shows a portion of the gradient
//        maskLayer.frame = CGRect(x: 0, y: 0,
//                               width: uvProgressView.bounds.width * percentage,
//                               height: uvProgressView.bounds.height)
//        maskLayer.backgroundColor = UIColor.white.cgColor
//
//        // Apply the mask to the gradient layer
//        uvGradientLayer.mask = maskLayer
//    }
//}

class iPadUVView: UIView {
   // MARK: - Properties
   private let uvStackView: UIStackView = {
       let stack = UIStackView()
       stack.translatesAutoresizingMaskIntoConstraints = false
       stack.layer.cornerRadius = 15
       stack.axis = .vertical
       stack.backgroundColor = cyanColor
       stack.isLayoutMarginsRelativeArrangement = true
       stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       stack.spacing = 20
       return stack
   }()
   
   private let UVViewTitleLabel: UILabel = {
       let label = UILabel()
       label.text = "UV Index"
       label.textAlignment = .center
       label.font = .boldSystemFont(ofSize: 18.0)
       return label
   }()
   
   private let UVLabel: UILabel = {
       let label = UILabel()
       label.text = "--"
       label.textAlignment = .center
       return label
   }()
   
   private let uvProgressView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.layer.cornerRadius = 4
       view.clipsToBounds = true
       view.backgroundColor = UIColor.systemGray2.withAlphaComponent(0.3)
       return view
   }()
   
   private let uvGradientLayer: CAGradientLayer = {
       let layer = CAGradientLayer()
       layer.colors = [
           UIColor.systemGreen.cgColor,
           UIColor.systemYellow.cgColor,
           UIColor.systemOrange.cgColor,
           UIColor.systemRed.cgColor,
           UIColor.systemPurple.cgColor
       ]
       layer.startPoint = CGPoint(x: 0, y: 0.5)
       layer.endPoint = CGPoint(x: 1, y: 0.5)
       layer.cornerRadius = 2
       return layer
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
   private func setupUI() {
       // Add gradient layer to progress view
       uvProgressView.layer.addSublayer(uvGradientLayer)
       
       // Add subviews to stack
       uvStackView.addArrangedSubview(UVViewTitleLabel)
       uvStackView.addArrangedSubview(UVLabel)
       uvStackView.addArrangedSubview(uvProgressView)
       
       // Add stack to view
       addSubview(uvStackView)
       
       // Setup constraints
       NSLayoutConstraint.activate([
           uvStackView.topAnchor.constraint(equalTo: topAnchor),
           uvStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
           uvStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
           uvStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
           
           uvProgressView.heightAnchor.constraint(equalToConstant: 6)
       ])
       
       updateUVIndex(WeatherKitData.UV)
   }
   
   override func layoutSubviews() {
       super.layoutSubviews()
       uvGradientLayer.frame = uvProgressView.bounds
   }
   
   // MARK: - Public Methods
   func updateUVIndex(_ value: Int) {
       UVLabel.text = "\(value)"
       
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

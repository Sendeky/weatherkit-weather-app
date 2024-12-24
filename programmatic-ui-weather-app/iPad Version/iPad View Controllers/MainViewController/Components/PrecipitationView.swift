//
//  PrecipitationView.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/14/23.
//

import Foundation
import UIKit

//extension iPadMainViewController {
//    func createPrecipitationView() {
//        precipitationView.translatesAutoresizingMaskIntoConstraints = false
//        precipitationView.layer.cornerRadius = 15
//        precipitationView.axis = .vertical
//        precipitationView.backgroundColor = cyanColor
//        precipitationView.isLayoutMarginsRelativeArrangement = true
//        precipitationView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
//        precipitationView.spacing = 20
//
//        let PrecipitationViewTitleLabel: UILabel = {
//            let label = UILabel()
//            label.text = "Precipitation"
//            label.textAlignment = .center
//            label.font = .boldSystemFont(ofSize: 18.0)
//            return label
//        }()
//
//        let PrecipitationChanceLabel: UILabel = {
//            let label = UILabel()
//            label.text = "--"
//            label.textAlignment = .center
//            return label
//        }()
//
//        PrecipitationChanceLabel.text = "\(WeatherKitData.PrecipitationChance)% Chance"
//
//        precipitationView.addArrangedSubview(PrecipitationViewTitleLabel)
//        precipitationView.addArrangedSubview(PrecipitationChanceLabel)
//    }
//}


class iPadPrecipitationView: UIView {
   // MARK: - Properties
   private let precipitationStackView: UIStackView = {
       let stack = UIStackView()
       stack.translatesAutoresizingMaskIntoConstraints = false
       stack.layer.cornerRadius = 15
       stack.axis = .vertical
       stack.backgroundColor = cyanColor
       stack.isLayoutMarginsRelativeArrangement = true
       stack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
       stack.spacing = 20
       return stack
   }()
   
   private let PrecipitationViewTitleLabel: UILabel = {
       let label = UILabel()
       label.text = "Precipitation"
       label.textAlignment = .center
       label.font = .boldSystemFont(ofSize: 18.0)
       return label
   }()
   
   private let PrecipitationChanceLabel: UILabel = {
       let label = UILabel()
       label.text = "--"
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
   private func setupUI() {
       // Add labels to stack
       precipitationStackView.addArrangedSubview(PrecipitationViewTitleLabel)
       precipitationStackView.addArrangedSubview(PrecipitationChanceLabel)
       
       // Add stack to view
       addSubview(precipitationStackView)
       
       // Setup constraints
       NSLayoutConstraint.activate([
           precipitationStackView.topAnchor.constraint(equalTo: topAnchor),
           precipitationStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
           precipitationStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
           precipitationStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
       ])
       
       updatePrecipitationLabel(WeatherKitData.PrecipitationChance)
   }
   
   // MARK: - Public Methods
    func updatePrecipitationLabel(_ value: Int) {
       PrecipitationChanceLabel.text = "\(value)% Chance"
   }
}

//
//  WindView.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/14/23.
//

import Foundation
import UIKit

//extension iPadMainViewController {
//    func createWindView() {
//        windView.translatesAutoresizingMaskIntoConstraints = false
//        windView.layer.cornerRadius = 15
//        windView.axis = .vertical
//        windView.backgroundColor = cyanColor
//        windView.isLayoutMarginsRelativeArrangement = true
//        windView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
//        windView.spacing = 20
//
//        let WindViewTitleLabel: UILabel = {
//            let label = UILabel()
//            label.text = "Wind"
//            label.textAlignment = .center
//            label.font = .boldSystemFont(ofSize: 18.0)
//            return label
//        }()
//
//        let WindSpeedLabel: UILabel = {
//            let label = UILabel()
//            label.text = "--"
//            label.textAlignment = .center
//            return label
//        }()
//
//        WindSpeedLabel.text = "\(WeatherKitData.WindSpeed)"
//        windView.addArrangedSubview(WindViewTitleLabel)
//        windView.addArrangedSubview(WindSpeedLabel)
//    }
//}

class iPadWindView: UIView {
   // MARK: - Properties
   private let windStackView: UIStackView = {
       let stack = UIStackView()
       stack.translatesAutoresizingMaskIntoConstraints = false
       stack.layer.cornerRadius = 15
       stack.axis = .vertical
       stack.backgroundColor = cyanColor
       stack.isLayoutMarginsRelativeArrangement = true
       stack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
       stack.spacing = 20
       return stack
   }()
   
   private let WindViewTitleLabel: UILabel = {
       let label = UILabel()
       label.text = "Wind"
       label.textAlignment = .center
       label.font = .boldSystemFont(ofSize: 18.0)
       return label
   }()
   
   private let WindSpeedLabel: UILabel = {
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
       windStackView.addArrangedSubview(WindViewTitleLabel)
       windStackView.addArrangedSubview(WindSpeedLabel)
       
       // Add stack to view
       addSubview(windStackView)
       
       // Setup constraints
       NSLayoutConstraint.activate([
           windStackView.topAnchor.constraint(equalTo: topAnchor),
           windStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
           windStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
           windStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
       ])
       
       updateWindLabel(WeatherKitData.WindSpeed)
   }
   
   // MARK: - Public Methods
    func updateWindLabel(_ value: String) {
       WindSpeedLabel.text = "\(value)"
   }
}

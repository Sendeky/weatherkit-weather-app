///
//  iPadHumidityStack.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/5/23.
//

import UIKit


class iPadHumidityStack: UIView {
    // MARK: START: stuff needed for UIView
    override init(frame: CGRect) {
        super.init(frame: frame)
//        createHumidityView()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: END
    
    
    // Topmost stack
    let humidityView: UIStackView = {
        let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.spacing = 15
            stack.backgroundColor = cyanColor
            stack.layer.cornerRadius = 15
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 40, right: 0)
            return stack
    }()
    
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
    
    // setsup the UI for the humidityStack
    func setupUI() {
        
        humidityLabel.text = "\(WeatherKitData.Humidity)%"
        humidityView.addArrangedSubview(humidityTitleLabel)
        humidityView.addArrangedSubview(humidityLabel)
        
        addSubview(humidityView)
        
        // Setup constraints for humidityView to fill iPadHumidityStack
        NSLayoutConstraint.activate([
            humidityView.topAnchor.constraint(equalTo: topAnchor),
            humidityView.leadingAnchor.constraint(equalTo: leadingAnchor),
            humidityView.trailingAnchor.constraint(equalTo: trailingAnchor),
            humidityView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func updateHumidityLabels(_ value: Int) {
        humidityLabel.text = "\(value)%"
    }
}

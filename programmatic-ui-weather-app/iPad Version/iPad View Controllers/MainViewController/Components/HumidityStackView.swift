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

/*
class iPadHumidityStack: UIStackView {
    // MARK: START: stuff needed for UIView
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder acoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: acoder)
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    // MARK: END
    
    
    // Topmost stack
    let topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
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
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.axis = .vertical
        topStack.spacing = 15
        topStack.backgroundColor = cyanColor    // uses global cyanColor
        topStack.layer.cornerRadius = 15
        topStack.isLayoutMarginsRelativeArrangement = true
        topStack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        
        humidityLabel.text = "\(WeatherKitData.Humidity)%"
        topStack.addArrangedSubview(humidityTitleLabel)
        topStack.addArrangedSubview(humidityLabel)
    }
    func updateHumiditLabels() {
        humidityLabel.text = "\(WeatherKitData.Humidity)%"
    }
}
*/

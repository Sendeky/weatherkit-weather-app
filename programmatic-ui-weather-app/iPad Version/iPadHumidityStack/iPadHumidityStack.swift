//
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
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: END

    // mainStack
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        return stack
    }()
    
    // topStack (with humidity)
    let topStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .horizontal
        return stack
    }()
    
    // bottomStack (with dew point)
    let bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .horizontal
        return stack
    }()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "humidity"
        return label
    }()
    
    let dewPointLabel: UILabel = {
        let label = UILabel()
        label.text = "dew point"
        return label
    }()
    
    // func to setup UI
    func setupUI() {
        // add humidity and dew point stacks
        mainStack.addArrangedSubview(topStack)
        mainStack.addArrangedSubview(bottomStack)
        
        topStack.addArrangedSubview(humidityLabel)
        
        bottomStack.addArrangedSubview(dewPointLabel)
        
        addSubview(topStack)
        
        // Really important
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        dewPointLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

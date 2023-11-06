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
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // topStack (with humidity)
    let topStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // bottomStack (with dew point)
    let bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    // func to setup UI
    func setupUI() {
        // add humidity and dew point stacks
        mainStack.addArrangedSubview(humidityLabel)
        mainStack.addArrangedSubview(dewPointLabel)
        
//        topStack.addArrangedSubview(humidityLabel)
        
//        bottomStack.addArrangedSubview(dewPointLabel)
        
        // adds the main stack to the view
        addSubview(mainStack)
    }
}

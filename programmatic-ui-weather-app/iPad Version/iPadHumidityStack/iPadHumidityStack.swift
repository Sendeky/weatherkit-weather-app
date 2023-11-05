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

    
    let MainStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        return stack
    }()
    
    let topStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .horizontal
        return stack
    }()
    
    let bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .horizontal
        return stack
    }()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let dewPointLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func setupUI() {
        MainStack.addArrangedSubview(topStack)
        MainStack.addArrangedSubview(bottomStack)
        
        topStack.addArrangedSubview(humidityLabel)
        
        bottomStack.addArrangedSubview(dewPointLabel)
        
        addSubview(topStack)
        
        // Really important
        MainStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        dewPointLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

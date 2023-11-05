//
//  iPadMainTopCurrentStack.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/1/23.
//

import UIKit

class iPadMainTopCurrentStack: UIView {
    
//    var SpaceXFont: UIFont

    // MARK: START: stuff needed for UIView
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: END
    
    
    // Topmost stack
    let topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    // Current City Label
    let currentCityLabel: UILabel = {
        let label = UILabel()
        label.text = "No Location!"
        label.textAlignment = .center
        return label
    }()
    
    // Top Info Stack
    let topInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .equalCentering
        return stack
    }()
    
    // Min Temperature Label
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Min Temp"
        label.textAlignment = .center
        return label
    }()
    
    // Current Temp Label
    let currentTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Temp"
        label.textAlignment = .center
        return label
    }()
    
    // Max Temperature Label
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Max Temp"
        return label
    }()


    private func setupUI() {
        var customFont: UIFont
        customFont = setupFont()
        
        topInfoStack.addArrangedSubview(minTempLabel)
        topInfoStack.addArrangedSubview(currentTempLabel)
        topInfoStack.addArrangedSubview(maxTempLabel)
        
        topStack.addArrangedSubview(currentCityLabel)
        topStack.addArrangedSubview(topInfoStack)
        
        addSubview(topStack)
        
        // Really important
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        currentCityLabel.translatesAutoresizingMaskIntoConstraints = false
        topInfoStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Set font for the labels
        currentCityLabel.font = customFont
    }
    
    func setupFont() -> UIFont {
        guard let customFont = UIFont(name: "SpaceX", size: 24.0) else {
            fatalError("""
                Failed to load the "SpaceX" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }

}

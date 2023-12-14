//
//  iPadDailyCollectionViewCell.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/19/23.
//

import UIKit

class iPadDailyCollectionViewCell: UICollectionViewCell {
    // Add UI elements as needed
    // topStack is needed so that stackview doesn't slide around
    var topStack: UIStackView!
//    var stackView: UIStackView!
    var minMaxStack: UIStackView!
    var dayOfWeek: UILabel!
    var weatherIcon: UIImageView!
    var maxTempLabel: UILabel!
    var minTempLabel: UILabel!
    var TTT: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // cyanColor for views in mainview
        let cyanColor = UIColor(red: 95.0/255.0, green: 135.0/255.0, blue: 255.0/255.0, alpha: 0.93)
        
        topStack = UIStackView()
        minMaxStack = UIStackView()
        maxTempLabel = UILabel()
        minTempLabel = UILabel()
        dayOfWeek = UILabel()
        weatherIcon = UIImageView()
        
        topStack.translatesAutoresizingMaskIntoConstraints = false
//        topStack.backgroundColor = .orange
        topStack.backgroundColor = cyanColor
        topStack.applyBlurEffect(cornerRadius: 10)
//        topStack.layer.opacity = 0.5
//        topStack.isOpaque = true
        topStack.axis = .vertical
        topStack.layer.cornerRadius = 15
        
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.image = UIImage(systemName: "sun.max.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0))?.withRenderingMode(.alwaysOriginal)
        weatherIcon.contentMode = .scaleAspectFit
        
        minMaxStack.translatesAutoresizingMaskIntoConstraints = false
        minMaxStack.axis = .horizontal
        minMaxStack.spacing = 1
        
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.text = "Max"
        
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.text = "Min"
        
        dayOfWeek = UILabel()
        dayOfWeek.translatesAutoresizingMaskIntoConstraints = false
        dayOfWeek.text = "WeekDay"
        dayOfWeek.textAlignment = .center
        
        topStack.addArrangedSubview(weatherIcon)
        topStack.addArrangedSubview(minMaxStack)
        topStack.addArrangedSubview(dayOfWeek)
        minMaxStack.addArrangedSubview(minTempLabel)
        minMaxStack.addArrangedSubview(maxTempLabel)
        contentView.addSubview(topStack)
        
        // we set up the font for the labels
        let customFont: UIFont
        customFont = setupFont()
        
        minTempLabel.font = customFont
        maxTempLabel.font = customFont
        minTempLabel.adjustsFontSizeToFitWidth = true
        maxTempLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
//            contentView.heightAnchor.constraint(equalToConstant: 200),
            topStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            topStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            topStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            topStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            // minMaxStack constraints
//            weatherIcon.heightAnchor.constraint(equalToConstant: 60),
//            weatherIcon.widthAnchor.constraint(equalToConstant: 10),
            minMaxStack.heightAnchor.constraint(equalToConstant: 60),
            dayOfWeek.heightAnchor.constraint(equalToConstant: 40),
//            minMaxStack.topAnchor.constraint(equalTo: topStack.topAnchor),
//            minMaxStack.bottomAnchor.constraint(equalTo: topStack.bottomAnchor),
//            minMaxStack.leadingAnchor.constraint(equalTo: topStack.leadingAnchor),
//            minMaxStack.trailingAnchor.constraint(equalTo: topStack.trailingAnchor),
        ])
    }
    
    func setupFont() -> UIFont {
        guard let customFont = UIFont(name: "SpaceX", size: 20.0) else {
            fatalError("""
                Failed to load the "SpaceX" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
}

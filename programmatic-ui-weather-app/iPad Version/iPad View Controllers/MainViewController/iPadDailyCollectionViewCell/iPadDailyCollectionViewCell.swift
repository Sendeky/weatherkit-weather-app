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
        topStack = UIStackView()
        minMaxStack = UIStackView()
        maxTempLabel = UILabel()
        minTempLabel = UILabel()
        dayOfWeek = UILabel()
        weatherIcon = UIImageView()
        
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.backgroundColor = .orange
        topStack.axis = .vertical
        topStack.layer.cornerRadius = 15
        
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.image = UIImage(systemName: "sun.max", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))?.withRenderingMode(.alwaysOriginal)
        weatherIcon.contentMode = .scaleAspectFill
        
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
        minMaxStack.addArrangedSubview(maxTempLabel)
        minMaxStack.addArrangedSubview(minTempLabel)
        contentView.addSubview(topStack)
        
        NSLayoutConstraint.activate([
//            contentView.heightAnchor.constraint(equalToConstant: 200),
            topStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            topStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            topStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            topStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            // minMaxStack constraints
            minMaxStack.heightAnchor.constraint(equalToConstant: 60),
            dayOfWeek.heightAnchor.constraint(equalToConstant: 40),
//            minMaxStack.topAnchor.constraint(equalTo: topStack.topAnchor),
//            minMaxStack.bottomAnchor.constraint(equalTo: topStack.bottomAnchor),
//            minMaxStack.leadingAnchor.constraint(equalTo: topStack.leadingAnchor),
//            minMaxStack.trailingAnchor.constraint(equalTo: topStack.trailingAnchor),
        ])
    }
}

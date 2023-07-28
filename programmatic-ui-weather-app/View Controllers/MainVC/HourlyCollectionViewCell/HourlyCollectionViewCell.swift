//
//  HourlyCollectionViewCell.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 7/28/23.
//

import UIKit

class CustomCell: UICollectionViewCell {
    // Add UI elements as needed
    // topStack is needed so that stackview doesn't slide around
    var topStack: UIStackView!
    var stackView: UIStackView!
    var weatherIcon: UIImageView!
    var tempLabel: UILabel!
    var titleLabel: UILabel!
    
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
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0
        
        weatherIcon = UIImageView()
        weatherIcon.image = UIImage(systemName: "sun.max", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))?.withRenderingMode(.alwaysOriginal)
        weatherIcon.contentMode = .scaleAspectFill
        
        tempLabel = UILabel()
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont.systemFont(ofSize: 20.0)
        tempLabel.text = "20°"
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20.0)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        stackView.addArrangedSubview(weatherIcon)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(titleLabel)
        
        topStack.addArrangedSubview(stackView)
        
        contentView.addSubview(topStack)
        
        // Add constraints or adjust frames
        topStack.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -15),
            topStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topStack.heightAnchor.constraint(equalToConstant: 90),
            
//            tempLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 15),
//            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            tempLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),
            
//            titleLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5),
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15)
        ])
    }
}

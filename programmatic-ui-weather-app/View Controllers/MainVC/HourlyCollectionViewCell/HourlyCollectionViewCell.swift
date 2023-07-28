//
//  HourlyCollectionViewCell.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 7/28/23.
//

import UIKit

class CustomCell: UICollectionViewCell {
    // Add UI elements as needed
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
        weatherIcon = UIImageView()
//        weatherIcon.image = UIImage(systemName: "sun.fill")
        weatherIcon.image = UIImage(systemName: "sun.max", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))?.withRenderingMode(.alwaysOriginal)
        weatherIcon.contentMode = .scaleAspectFit
        
        tempLabel = UILabel()
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont.systemFont(ofSize: 16.0)
        tempLabel.text = "20°"
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
        
        contentView.addSubview(weatherIcon)
        contentView.addSubview(tempLabel)
        contentView.addSubview(titleLabel)
        
        // Add constraints or adjust frames
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
//            weatherIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            weatherIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            weatherIcon.widthAnchor.constraint(greaterThanOrEqualToConstant: 15),
//            weatherIcon.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),
            
            tempLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tempLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),
            
            titleLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15)
        ])
    }
}

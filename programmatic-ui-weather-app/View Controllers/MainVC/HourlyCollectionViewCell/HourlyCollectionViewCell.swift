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
    var timeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // bigger top stackview
        topStack = UIStackView()
        
        // individual stackview
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0
        
        // hourly weather icon
        weatherIcon = UIImageView()
        weatherIcon.image = UIImage(systemName: "sun.max", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))?.withRenderingMode(.alwaysOriginal)
        weatherIcon.contentMode = .scaleAspectFill
        
        // hourly temp label
        tempLabel = UILabel()
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont.systemFont(ofSize: 20.0)
        tempLabel.text = "20°"
        
        // hour label
        timeLabel = UILabel()
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont.systemFont(ofSize: 20.0)
        timeLabel.adjustsFontSizeToFitWidth = true
        
        // add labels, icon to individual stackview
        stackView.addArrangedSubview(weatherIcon)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(timeLabel)
        
        // add individual stackview to bigger stackview
        topStack.addArrangedSubview(stackView)
        
        // add bigger stackview to main contentview
        contentView.addSubview(topStack)
        
        // Add constraints or adjust frames
        topStack.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -15),
            topStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topStack.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
}

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
    var someStack: UIStackView!
//    var stackView: UIStackView!
//    var weatherIcon: UIImageView!
//    var tempLabel: UILabel!
//    var timeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        someStack = UIStackView()
        
        someStack.translatesAutoresizingMaskIntoConstraints = false
        someStack.backgroundColor = .orange
        someStack.layer.cornerRadius = 15
        
        contentView.addSubview(someStack)
        
        NSLayoutConstraint.activate([
            someStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            someStack.heightAnchor.constraint(equalToConstant: 175),
//            someStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            someStack.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}

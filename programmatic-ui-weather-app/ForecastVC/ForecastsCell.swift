//
//  ForecastsCell.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 11/19/22.
//

import UIKit

class ForecastsCell: UITableViewCell {
    
    var forecastImageView = UIImageView()
    var forecastMaxTemp = UILabel()
    var forecastMinTemp = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(forecastImageView)
        addSubview(forecastMaxTemp)
        addSubview(forecastMinTemp)
        
        configureImageView()
        configureMaxTemp()
        configureMinTemp()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(forecasts: Forecasts) {
        forecastImageView.image = forecasts.image
        forecastMaxTemp.text = forecasts.maxTemp
        forecastMinTemp.text = forecasts.minTemp
    }
    
    func configureImageView() {
        forecastImageView.clipsToBounds = true
    }
    func configureMaxTemp() {
        forecastMaxTemp.numberOfLines = 1
        forecastMaxTemp.adjustsFontSizeToFitWidth = true
    }
    func configureMinTemp() {
        forecastMinTemp.numberOfLines = 1
        forecastMinTemp.adjustsFontSizeToFitWidth = true
        forecastMinTemp.text = "something"
    }
    
    func layout() {
        forecastImageView.translatesAutoresizingMaskIntoConstraints = false
        forecastMaxTemp.translatesAutoresizingMaskIntoConstraints = false
        forecastMinTemp.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //forecastImageView constraints
            forecastImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            forecastImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            forecastImageView.heightAnchor.constraint(equalToConstant: 32),
            forecastImageView.widthAnchor.constraint(equalToConstant: 32),
            //forecastMaxTemp constraints
            forecastMaxTemp.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            forecastMaxTemp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            //forecastMinTemp constraints
            forecastMinTemp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            forecastMinTemp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}

extension ForecastListVC {
    
    func makeForecastCells() -> [Forecasts] {
        let forecasts1 = Forecasts(image: UIImage(systemName: "sun.min.fill")!, maxTemp: "20", minTemp: "5")
        let forecasts2 = Forecasts(image: UIImage(systemName: "sun.min.fill")!, maxTemp: "20", minTemp: "5")
        let forecasts3 = Forecasts(image: UIImage(systemName: "sun.min.fill")!, maxTemp: "20", minTemp: "5")
        let forecasts4 = Forecasts(image: UIImage(systemName: "sun.min.fill")!, maxTemp: "20", minTemp: "5")
        
        return [forecasts1, forecasts2, forecasts3, forecasts4]
    }
    
}


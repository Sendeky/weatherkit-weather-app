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
        forecastImageView.sizeToFit()
        forecastImageView.contentMode = .scaleAspectFill
        forecastImageView.clipsToBounds = true
        forecastImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(paletteColors: [.white, .yellow, .gray])
        forecastMaxTemp.translatesAutoresizingMaskIntoConstraints = false
        forecastMaxTemp.font = .preferredFont(forTextStyle: .title2)
        forecastMinTemp.translatesAutoresizingMaskIntoConstraints = false
        forecastMinTemp.font = .preferredFont(forTextStyle: .title2)
        
        NSLayoutConstraint.activate([
            //forecastImageView constraints
            forecastImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            forecastImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            //forecastMaxTemp constraints
            forecastMaxTemp.centerYAnchor.constraint(equalTo: centerYAnchor),
            forecastMaxTemp.leadingAnchor.constraint(equalTo: forecastMinTemp.trailingAnchor),
            //forecastMinTemp constraints
            forecastMinTemp.centerYAnchor.constraint(equalTo: centerYAnchor),
            forecastMinTemp.leadingAnchor.constraint(equalTo: forecastImageView.trailingAnchor, constant: 15),
        ])
    }
}

extension ForecastListVC {
    
    func makeForecastCells() -> [Forecasts] {
        
        if WeatherKitData.TempMaxForecast.isEmpty == false {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 36, weight: .bold, scale: .large)      //size config for symbols
            var forecasts = [Forecasts]()
            
            for i in 0...6 {
                forecasts.append(Forecasts(image: UIImage(systemName: "\(WeatherKitData.forecastSymbol[i]).fill", withConfiguration: largeConfig)!.withRenderingMode(.alwaysOriginal), maxTemp: "to \(WeatherKitData.TempMaxForecast[i])", minTemp: "From \(WeatherKitData.TempMinForecast[i]) "))
            }
            return forecasts
        }
        return []
    }
    
}


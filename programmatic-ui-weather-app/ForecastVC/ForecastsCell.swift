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
        
        var forecasts1 = Forecasts(image: UIImage(systemName: "questionmark")!, maxTemp: "error", minTemp: "error")
        var forecasts2 = Forecasts(image: UIImage(systemName: "questionmark")!, maxTemp: "error", minTemp: "error")
        var forecasts3 = Forecasts(image: UIImage(systemName: "sun.min.fill")!, maxTemp: "20", minTemp: "5")
        var forecasts4 = Forecasts(image: UIImage(systemName: "sun.min.fill")!, maxTemp: "20", minTemp: "5")
        
        if WeatherKitData.TempMaxForecast.isEmpty == false {
            forecasts1 = Forecasts(image: UIImage(systemName: "\(WeatherKitData.forecastSymbol[0])", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0, weight: .bold))!.withRenderingMode(.alwaysOriginal), maxTemp: "\(WeatherKitData.TempMaxForecast[0])", minTemp: "0.0")
            forecasts2 = Forecasts(image: UIImage(systemName: "\(WeatherKitData.forecastSymbol[1])", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0, weight: .bold))!, maxTemp: "\(WeatherKitData.TempMaxForecast[1])", minTemp: "0.0")
            forecasts3 = Forecasts(image: UIImage(systemName: "\(WeatherKitData.forecastSymbol[2])", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0, weight: .bold))!, maxTemp: "\(WeatherKitData.TempMaxForecast[2])", minTemp: "0.0")
            forecasts4 = Forecasts(image: UIImage(systemName: "\(WeatherKitData.forecastSymbol[3])", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0, weight: .bold))!, maxTemp: "\(WeatherKitData.TempMaxForecast[3])", minTemp: "0.0")
        }
//        let forecasts1 = Forecasts(image: UIImage(systemName: "sun.min.fill")!, maxTemp: "20", minTemp: "5")
        return [forecasts1, forecasts2, forecasts3, forecasts4]
        
    }
    
}


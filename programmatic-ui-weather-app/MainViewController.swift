//
//  MainViewController.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/11/22.
//

import UIKit

class MainViewController: UIViewController {

    //Intializes all the elements
    let topStackview = UIStackView()
    let topSubStackview = UIStackView()
    let topRainChanceLabel = UILabel()
    let topWeatherIconView = UIImageView()
    let topCurrentTempLabel = UILabel()
    let topUVIndexLabel = UILabel()
    let topCityNameLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        style()
        layout()
        fetchWeather()
        print(WeatherData.cityName)
        print(WeatherData.weatherTemp)
    }

    
    private func style() {
        //Sets settings for topStackView
        topStackview.translatesAutoresizingMaskIntoConstraints = false
        topStackview.axis = .vertical
        topStackview.spacing = 30
        
        //Sets settings for topSubStackview
        topSubStackview.translatesAutoresizingMaskIntoConstraints = false
        topSubStackview.axis = .horizontal
        topSubStackview.spacing = 40
        topSubStackview.tintColor = .systemYellow
        
        //Sets settings for topRainChanceLabel
        topRainChanceLabel.translatesAutoresizingMaskIntoConstraints = false
        topRainChanceLabel.text = "Rain Chance"
        topRainChanceLabel.font = .preferredFont(forTextStyle: .title3)
        
        //Sets settings for topCurrentTempLabel
        topWeatherIconView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "sun.max.fill")!.withTintColor(.yellow)
        topWeatherIconView.image = image
        
        //Sets settings for topCurrentTempLabel
        topCurrentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        topCurrentTempLabel.text = "23°"
        topCurrentTempLabel.font = .preferredFont(forTextStyle: .title3)
        
        //Sets settings for topUVIndexLabel
        topUVIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        topUVIndexLabel.text = "UV Index: "
        topUVIndexLabel.font = .preferredFont(forTextStyle: .title3)
        
        //Sets settings for topCityNameLabel
        topCityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        topCityNameLabel.text = "City Name"
        topCityNameLabel.font = .preferredFont(forTextStyle: .title3)
    }
    
    private func layout(){
        //Adds rain chance label, weather icon view, and current temp label into the topSubStackview
        topSubStackview.addArrangedSubview(topRainChanceLabel)
        topSubStackview.addArrangedSubview(topWeatherIconView)
        topSubStackview.addArrangedSubview(topCurrentTempLabel)
        
        topStackview.addSubview(topSubStackview)
        topStackview.addSubview(topUVIndexLabel)
        topStackview.addSubview(topCityNameLabel)
        
        view.addSubview(topStackview)
        
        NSLayoutConstraint.activate([
            topStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topStackview.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            topSubStackview.centerXAnchor.constraint(equalTo: topStackview.centerXAnchor),
            topSubStackview.centerYAnchor.constraint(equalTo: topStackview.centerYAnchor),
            topUVIndexLabel.centerXAnchor.constraint(equalTo: topStackview.centerXAnchor),
            topUVIndexLabel.centerYAnchor.constraint(equalTo: topSubStackview.bottomAnchor, constant: 20),
            topCityNameLabel.centerXAnchor.constraint(equalTo: topStackview.centerXAnchor),
            topCityNameLabel.centerYAnchor.constraint(equalTo: topUVIndexLabel.bottomAnchor, constant: 20),
            topWeatherIconView.heightAnchor.constraint(equalToConstant: 24),
            topWeatherIconView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }

}


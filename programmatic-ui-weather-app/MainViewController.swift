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
    let topRainAmountLabel = UILabel()
    let topWeatherIconView = UIImageView()
    let topCurrentTempLabel = UILabel()
    let topUVIndexLabel = UILabel()
    let topCityNameLabel = UILabel()
    let topMinMaxTempView = UIStackView()
    let topTempMinLabel = UILabel()
    let topTempMaxLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        style()
        layout()
        
        DispatchQueue.global().async {
            self.fetchWeather()
            print(RawWeatherData.WeatherTempKelvin)
            self.convertKelvinIntoCelsius()
            print(WeatherData.WeatherTempCelsius)
            
            DispatchQueue.main.async {
                self.topCurrentTempLabel.text = "Temp: \(Int(WeatherData.WeatherTempCelsius))˚"
                self.topRainAmountLabel.text = "Precipitation: \(RawWeatherData.rainAmount)mm"
                self.topCityNameLabel.text = "\(RawWeatherData.cityName)"
                self.topTempMinLabel.text = "Min Temp: \(WeatherData.WeatherTempMinCelsius)"
                self.topTempMaxLabel.text = "Max Temp: \(WeatherData.WeatherTempMaxCelsius)"
            }
        }
    }

    
    private func style() {
        //Sets settings for topStackView
        topStackview.translatesAutoresizingMaskIntoConstraints = false
        topStackview.axis = .vertical
        topStackview.spacing = 30
        
        //Sets settings for topSubStackview
        topSubStackview.translatesAutoresizingMaskIntoConstraints = false
        topSubStackview.axis = .horizontal
        topSubStackview.spacing = 30
        topSubStackview.tintColor = .systemYellow
        
        //Sets settings for topRainChanceLabel
        topRainAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        topRainAmountLabel.text = "Rain Amount"
        topRainAmountLabel.adjustsFontSizeToFitWidth = true
        
        //Sets settings for topCurrentTempLabel
        topWeatherIconView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "sun.max.fill")!.withTintColor(.yellow)
        topWeatherIconView.image = image
        
        //Sets settings for topCurrentTempLabel
        topCurrentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        topCurrentTempLabel.text = "23°"
        topCurrentTempLabel.adjustsFontSizeToFitWidth = true
        
        //Sets settings for topUVIndexLabel
        topUVIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        topUVIndexLabel.text = "UV Index: "
        topUVIndexLabel.font = .preferredFont(forTextStyle: .title2)
        
        //Sets settings for topCityNameLabel
        topCityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        topCityNameLabel.text = "City Name"
        topCityNameLabel.font = .preferredFont(forTextStyle: .title2)
        
        //Sets settings for topMinMaxTempView
        topMinMaxTempView.translatesAutoresizingMaskIntoConstraints = false
        topMinMaxTempView.axis = .horizontal
        topMinMaxTempView.spacing = 30
        
        //Sets settings for topTempMinLabel
        topTempMinLabel.translatesAutoresizingMaskIntoConstraints = false
        topTempMinLabel.text = "Min Temp"
        topTempMinLabel.font = .preferredFont(forTextStyle: .title3)
        
        //Sets settings for top tempMaxLabel
        topTempMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        topTempMaxLabel.text = "Max Temp"
        topTempMaxLabel.font = .preferredFont(forTextStyle: .title3)
    }
    
    private func layout(){
        //Adds rain chance label, weather icon view, and current temp label into the topSubStackview
        topSubStackview.addArrangedSubview(topRainAmountLabel)
        topSubStackview.addArrangedSubview(topWeatherIconView)
        topSubStackview.addArrangedSubview(topCurrentTempLabel)
        
        topStackview.addSubview(topSubStackview)
        topStackview.addSubview(topUVIndexLabel)
        topStackview.addSubview(topCityNameLabel)
        topStackview.addSubview(topMinMaxTempView)
        
        topMinMaxTempView.addArrangedSubview(topTempMinLabel)
        topMinMaxTempView.addArrangedSubview(topTempMaxLabel)
        
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
            topWeatherIconView.widthAnchor.constraint(equalToConstant: 24),
            topMinMaxTempView.centerXAnchor.constraint(equalTo: topStackview.centerXAnchor),
            topMinMaxTempView.centerYAnchor.constraint(equalTo: topCityNameLabel.bottomAnchor, constant: 20)
        ])
    }

}


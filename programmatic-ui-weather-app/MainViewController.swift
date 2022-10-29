//
//  MainViewController.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/11/22.
//

import UIKit
import CoreLocation

struct UserLocation {
    static var userLatitude: Double? = 0.0
    static var userLongitude: Double? = 0.0
}

class MainViewController: UIViewController, CLLocationManagerDelegate {

    //Intializes all the elements
    let topStackview = UIStackView()
    let topSubStackview = UIStackView()
    let topWeatherIconStackView = UIStackView()
    let topRainAmountLabel = UILabel()
    let topWeatherIconView = UIImageView()
    let topCurrentTempLabel = UILabel()
    let topUVIndexLabel = UILabel()
    let topCityNameLabel = UILabel()
    let topMinMaxTempView = UIStackView()
    let topTempMinLabel = UILabel()
    let topTempMaxLabel = UILabel()
    let bottomScrollview = UIScrollView()
    let bottomScrollStackview = UIStackView()
    
    //Sunrise view & labels
    let sunriseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 75.0/255.0, green: 205.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        view.layer.cornerRadius = 40
        view.isUserInteractionEnabled = true
        return view
    }()
    let sunriseTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunrise"
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunrise happened at: "
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    let sunriseIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        let sunriseIcon = UIImage(systemName: "sunrise")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        imageview.image = sunriseIcon
        return imageview
    }()
    
    //Sunset view & labels
    let sunsetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 75.0/255.0, green: 205.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        view.layer.cornerRadius = 40
        return view
    }()
    let sunsetTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunset"
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunset happened at: "
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    let sunsetIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        let sunsetIcon = UIImage(systemName: "sunset")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        imageview.image = sunsetIcon
        return imageview
    }()
    
    //feelsLike view & labels
    let feelsLikeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 75.0/255.0, green: 205.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        view.layer.cornerRadius = 40
        return view
    }()
    let feelsLikeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Feels"
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    let feelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "It feels like: "
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    let feelsLikeIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        let humidityIcon = UIImage(systemName: "thermometer.medium", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))!.withTintColor(.red, renderingMode: .alwaysOriginal)
        imageview.image = humidityIcon
        return imageview
    }()
    
    //Wind Speed view & labels
    let windSpeedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 75.0/255.0, green: 205.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        view.layer.cornerRadius = 40
        return view
    }()
    let windSpeedTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wind"
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wind speed is: "
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    let windSpeedIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        let windIcon = UIImage(systemName: "wind", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))!.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageview.image = windIcon
        return imageview
    }()
    
    //Humidity view & labels
    let humidityView: UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = UIColor(red: 75.0/255.0, green: 205.0/255.0, blue: 255.0/255.0, alpha: 1.0)
         view.layer.cornerRadius = 40
         return view
    }()
    let humidityTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Humidity"
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Humidity is"
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    let humidityIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        let humidityIcon = UIImage(systemName: "humidity.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))!.withTintColor(UIColor(red: 0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), renderingMode: .alwaysOriginal)
        imageview.image = humidityIcon
        return imageview
    }()
    
    //Pressure view & labels
    let pressureView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 75.0/255.0, green: 205.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        view.layer.cornerRadius = 40
        return view
    }()
    let pressureTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pressure"
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    let pressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pressure is "
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    let pressureIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        let humidityIcon = UIImage(systemName: "barometer", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))!.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        imageview.image = humidityIcon
        return imageview
    }()
    
    //sunrisePopUp
    let sunrisePopUpViewController: UIViewController = {
        let vc = UIViewController()
//        vc.isModalInPresentation = true
        vc.view.backgroundColor = .systemOrange
        vc.view.alpha = 0.8
        return vc
    }()
    
    //Creates a refresh control for the scrollview
    var refreshControl = UIRefreshControl()
    //Creates the location manager
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
                
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        //Initalizes settings for UI elements and layout for UI elements
        style()
        layout()
        //initializes location services
        initializeLocationServices()
        
        
        DispatchQueue.global().async {
            //Calls all the functions (most are from the Utils folder)
            self.fetchWeather()
            print(RawWeatherData.WeatherTempKelvin)
            self.convertKelvinIntoCelsius()
            print(WeatherData.WeatherTempCelsius)
            self.convertEpochToDate()
            self.convertWindSpeedMPH()
            self.convertWindSpeedKPH()
            self.convertHPAtoInHg()
            self.viewDidLoadRefresh()

            
            //Updates all the labels asynchronously
            DispatchQueue.main.async {
                self.topCurrentTempLabel.text = "Temp: \(Int(WeatherData.WeatherTempCelsius))˚"
                self.topRainAmountLabel.text = "Precipitation: \(RawWeatherData.rainAmount)mm"
                self.topCityNameLabel.text = "\(RawWeatherData.cityName)"
                self.topTempMinLabel.text = "Min Temp: \(WeatherData.WeatherTempMinCelsius)"
                self.topTempMaxLabel.text = "Max Temp: \(WeatherData.WeatherTempMaxCelsius)"
                //Checks if the current time is greater than the sunset time (text changes depending on it)
                if self.compareSunsetTime() == true {
                    self.sunsetTimeLabel.text = "Happened at: \(WeatherData.localSunset)"
                    self.sunsetIcon.image = UIImage(systemName: "sunset.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
                } else {
                    self.sunsetTimeLabel.text = "Will be at: \(WeatherData.localSunset)"
                    self.sunsetIcon.image = UIImage(systemName: "sunset")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
                }
                if self.compareSunriseTime() == true {
                    self.sunriseTimeLabel.text = "Happened at: \(WeatherData.localSunrise)"
                    self.sunriseIcon.image = UIImage(systemName: "sunrise.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
                } else {
                    self.sunriseTimeLabel.text = "Will be at: \(WeatherData.localSunrise)"
                    self.sunriseIcon.image = UIImage(systemName: "sunrise")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
                }
                self.feelsLikeTempLabel.text = "It feels like: \(WeatherData.WeatherFeelsLikeCelsius)˚"
                self.windSpeedLabel.text = "Wind speed is \(WeatherData.windSpeedMPH) MPH"
                self.humidityLabel.text = "Humidity is \(RawWeatherData.humidity)%"
                self.pressureLabel.text = "Pressure is \(WeatherData.pressureInHg) InHg"
                
                if RawWeatherData.cityName != "Globe" {
                    print("RawWeatherData.cityName != Globe")
                } else {
                    self.updateLabels()
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground() //Function that sets the view to a gradient background
        viewDidLoadRefresh()
        super.viewWillAppear(true)
    }
    
    
    private func initializeLocationServices() {
        locationManager.delegate = self

        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        locationManager.requestAlwaysAuthorization() //Requests always authorization for locationServices
    }

    
    private func style() {
        //Sets settings for topStackView
        topStackview.translatesAutoresizingMaskIntoConstraints = false
        topStackview.axis = .vertical
        topStackview.spacing = 30
        
        //Sets settings for topSubStackview
        topSubStackview.translatesAutoresizingMaskIntoConstraints = false
        topSubStackview.axis = .vertical
        topSubStackview.spacing = 15
        
        //Sets settings for topWeatherIconStackView
        topWeatherIconStackView.translatesAutoresizingMaskIntoConstraints = false
        topWeatherIconStackView.axis = .horizontal
        
        //Sets settings for topRainChanceLabel
        topRainAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        topRainAmountLabel.text = "Rain Amount"
        topRainAmountLabel.adjustsFontSizeToFitWidth = true
        
        //Sets settings for topCurrentTempLabel
        topWeatherIconView.translatesAutoresizingMaskIntoConstraints = false
        let weatherIcon = UIImage(systemName: "sun.max.fill")!.withTintColor(.yellow)
        topWeatherIconView.image = weatherIcon
        
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
        
        //Sets settings for topTempMaxLabel
        topTempMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        topTempMaxLabel.text = "Max Temp"
        topTempMaxLabel.font = .preferredFont(forTextStyle: .title3)
        
        //Sets settings for bottomScrollview
        bottomScrollview.translatesAutoresizingMaskIntoConstraints = false
        bottomScrollview.alwaysBounceVertical = true
        bottomScrollview.isScrollEnabled = true
        
        //Sets settings for bottomScrollStackview
        bottomScrollStackview.translatesAutoresizingMaskIntoConstraints = false
        bottomScrollStackview.axis = .vertical
        bottomScrollStackview.spacing = 30
        
        //Sets settings for refreshControl
        refreshControl.attributedTitle = NSAttributedString("Fetching Weather")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        
        //sunriseTapGesture
        var sunriseTapGesture: UITapGestureRecognizer {
            let t = UITapGestureRecognizer(target: self, action: #selector(sunriseTapped))
            return t
        }
        sunriseView.addGestureRecognizer(sunriseTapGesture)
        
    }
    
    private func layout(){
        //Adds rain chance label, weather icon view, and current temp label into the topSubStackview
        topSubStackview.addArrangedSubview(topTempMaxLabel)
        topSubStackview.addArrangedSubview(topTempMinLabel)
        
        //Adds weatherIconView to topWeatherIconStackView
        topWeatherIconStackView.addArrangedSubview(topWeatherIconView)
        
        //Adds topSubStackview, uv index, city name labels, and topMinMaxTempView into topStackView
        topStackview.addSubview(topSubStackview)
        topStackview.addSubview(topWeatherIconStackView)
        topStackview.addSubview(topUVIndexLabel)
        topStackview.addSubview(topCityNameLabel)
        topStackview.addSubview(topMinMaxTempView)
        
        //Adds min and max temp labels into topMinMaxTempView
//        topMinMaxTempView.addArrangedSubview(topTempMinLabel)
//        topMinMaxTempView.addArrangedSubview(topTempMaxLabel)
        
        //Adds sunset, feels like, wind speed, humidity labels into bottomScrollStackview
        bottomScrollStackview.addSubview(sunsetTimeLabel)
        bottomScrollStackview.addSubview(feelsLikeTempLabel)
        bottomScrollStackview.addSubview(windSpeedLabel)
        bottomScrollStackview.addSubview(humidityLabel)
        bottomScrollStackview.addSubview(pressureLabel)
        bottomScrollStackview.addSubview(sunriseTimeLabel)
        
        //Adds bottomScrollStackview into bottomScrollview
        bottomScrollview.addSubview(bottomScrollStackview)
        bottomScrollview.addSubview(refreshControl)
        bottomScrollview.addSubview(sunriseView)
        bottomScrollview.addSubview(sunsetView)
        bottomScrollview.addSubview(feelsLikeView)
        bottomScrollview.addSubview(windSpeedView)
        bottomScrollview.addSubview(humidityView)
        bottomScrollview.addSubview(pressureView)
        
        //Adds labels to sunriseView
        sunriseView.addSubview(sunriseTitleLabel)
        sunriseView.addSubview(sunriseTimeLabel)
        sunriseView.addSubview(sunriseIcon)
        
        //Adds labels to sunsetView
        sunsetView.addSubview(sunsetTitleLabel)
        sunsetView.addSubview(sunsetTimeLabel)
        sunsetView.addSubview(sunsetIcon)
        
        //Adds labels to feelsLikeView
        feelsLikeView.addSubview(feelsLikeTitleLabel)
        feelsLikeView.addSubview(feelsLikeTempLabel)
        feelsLikeView.addSubview(feelsLikeIcon)
        
        //Adds labels to windSpeedView
        windSpeedView.addSubview(windSpeedTitleLabel)
        windSpeedView.addSubview(windSpeedLabel)
        windSpeedView.addSubview(windSpeedIcon)
        
        //Adds labels to humidityView
        humidityView.addSubview(humidityTitleLabel)
        humidityView.addSubview(humidityLabel)
        humidityView.addSubview(humidityIcon)
        
        //Adds labels to pressureView
        pressureView.addSubview(pressureTitleLabel)
        pressureView.addSubview(pressureLabel)
        pressureView.addSubview(pressureIcon)
        
        //Adds the main stacks into the view
        view.addSubview(topStackview)
        view.addSubview(bottomScrollview)
        
        //Sets the constraints for everything
        NSLayoutConstraint.activate([
            //topStackView constraints
            topStackview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topStackview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topStackview.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            //topWeatherIconStackView constraints
            topWeatherIconStackView.topAnchor.constraint(equalTo: topStackview.topAnchor),
            topWeatherIconStackView.widthAnchor.constraint(equalToConstant: 60),
            topWeatherIconStackView.trailingAnchor.constraint(equalTo: topStackview.centerXAnchor, constant: -30),
            //topSubStackView constraints
            topSubStackview.topAnchor.constraint(equalTo: topStackview.topAnchor),
            topSubStackview.leadingAnchor.constraint(equalTo: topStackview.centerXAnchor),
            topSubStackview.trailingAnchor.constraint(equalTo: topStackview.trailingAnchor),
            //topUVIndexLabel constraints
            topUVIndexLabel.centerXAnchor.constraint(equalTo: topStackview.centerXAnchor),
            topUVIndexLabel.centerYAnchor.constraint(equalTo: topSubStackview.bottomAnchor, constant: 20),
            //topCityNameLabel constraints
            topCityNameLabel.centerXAnchor.constraint(equalTo: topStackview.centerXAnchor),
            topCityNameLabel.centerYAnchor.constraint(equalTo: topUVIndexLabel.bottomAnchor, constant: 20),
            //topWeatherIconView constraints
            topWeatherIconView.heightAnchor.constraint(equalToConstant: 60),
            topWeatherIconView.widthAnchor.constraint(equalToConstant: 60),
            //topMinMaxTempView constraints
            topMinMaxTempView.centerXAnchor.constraint(equalTo: topStackview.centerXAnchor),
            topMinMaxTempView.centerYAnchor.constraint(equalTo: topCityNameLabel.bottomAnchor, constant: 20),
            //bottomScrollView constraints
            bottomScrollview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomScrollview.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            bottomScrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomScrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomScrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //sunriseView constraints
            sunriseView.leadingAnchor.constraint(equalTo: bottomScrollview.leadingAnchor, constant: 10),
            sunriseView.trailingAnchor.constraint(equalToSystemSpacingAfter: bottomScrollview.centerXAnchor, multiplier: 0.5),
            sunriseView.topAnchor.constraint(equalTo: bottomScrollview.topAnchor, constant: 10),
            sunriseView.heightAnchor.constraint(equalToConstant: 100),
            //sunriseTitleLabel constraints
            sunriseTitleLabel.topAnchor.constraint(equalTo: sunriseView.topAnchor, constant: 5),
            sunriseTitleLabel.centerXAnchor.constraint(equalTo: sunriseView.centerXAnchor, constant: -30),
            //sunriseIcon constraints
            sunriseIcon.centerYAnchor.constraint(equalTo: sunriseTitleLabel.centerYAnchor),
            sunriseIcon.leadingAnchor.constraint(equalTo: sunriseTitleLabel.trailingAnchor, constant: 5),
            //sunriseTimeLabel constraints
            sunriseTimeLabel.topAnchor.constraint(equalTo: sunriseTitleLabel.bottomAnchor, constant: 10),
            sunriseTimeLabel.leadingAnchor.constraint(equalTo: sunriseView.leadingAnchor, constant: 10),
            sunriseTimeLabel.trailingAnchor.constraint(equalTo: sunriseView.trailingAnchor, constant: -10),
            //sunsetView constraints
            sunsetView.leadingAnchor.constraint(equalToSystemSpacingAfter: bottomScrollview.centerXAnchor, multiplier: 0.5),
            sunsetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sunsetView.topAnchor.constraint(equalTo: bottomScrollview.topAnchor, constant: 10),
            sunsetView.heightAnchor.constraint(equalToConstant: 100),
            //sunsetTitlelabel constraints
            sunsetTitleLabel.topAnchor.constraint(equalTo: sunsetView.topAnchor, constant: 5),
            sunsetTitleLabel.centerXAnchor.constraint(equalTo: sunsetView.centerXAnchor, constant: -30),
            //sunsetIcon constraints
            sunsetIcon.centerYAnchor.constraint(equalTo: sunsetTitleLabel.centerYAnchor),
            sunsetIcon.leadingAnchor.constraint(equalTo: sunsetTitleLabel.trailingAnchor, constant: 5),
            //sunsetTimeLabel constraints
            sunsetTimeLabel.topAnchor.constraint(equalTo: sunsetTitleLabel.bottomAnchor, constant: 10),
            sunsetTimeLabel.leadingAnchor.constraint(equalTo: sunsetView.leadingAnchor, constant: 10),
            sunsetTimeLabel.trailingAnchor.constraint(equalTo: sunsetView.trailingAnchor, constant: -10),
            //feelsLikeView constraints
            feelsLikeView.topAnchor.constraint(equalTo: sunriseView.bottomAnchor, constant: 15),
            feelsLikeView.leadingAnchor.constraint(equalTo: sunriseView.leadingAnchor),
            feelsLikeView.trailingAnchor.constraint(equalTo: sunriseView.trailingAnchor),
            feelsLikeView.heightAnchor.constraint(equalToConstant: 100),
            //feelsLikeTitleLabel constraints
            feelsLikeTitleLabel.topAnchor.constraint(equalTo: feelsLikeView.topAnchor, constant: 5),
            feelsLikeTitleLabel.leadingAnchor.constraint(equalTo: sunriseTitleLabel.leadingAnchor),
            //feelsLikeIcon
            feelsLikeIcon.centerYAnchor.constraint(equalTo: feelsLikeTitleLabel.centerYAnchor),
            feelsLikeIcon.leadingAnchor.constraint(equalTo: feelsLikeTitleLabel.trailingAnchor, constant: 5),
            //feelsLikeTempLabel constraints
            feelsLikeTempLabel.topAnchor.constraint(equalTo: feelsLikeTitleLabel.bottomAnchor, constant: 10),
            feelsLikeTempLabel.leadingAnchor.constraint(equalTo: feelsLikeView.leadingAnchor, constant: 10),
            feelsLikeTempLabel.trailingAnchor.constraint(equalTo: feelsLikeView.trailingAnchor, constant: -10),
            //windSpeedView constraints
            windSpeedView.topAnchor.constraint(equalTo: sunsetView.bottomAnchor, constant: 15),
            windSpeedView.leadingAnchor.constraint(equalTo: sunsetView.leadingAnchor),
            windSpeedView.trailingAnchor.constraint(equalTo: sunsetView.trailingAnchor),
            windSpeedView.heightAnchor.constraint(equalToConstant: 100),
            //windSpeedTitleLabel constaints
            windSpeedTitleLabel.topAnchor.constraint(equalTo: windSpeedView.topAnchor, constant: 5),
            windSpeedTitleLabel.leadingAnchor.constraint(equalTo: sunsetTitleLabel.leadingAnchor),
            //windSpeedIcon
            windSpeedIcon.centerYAnchor.constraint(equalTo: windSpeedTitleLabel.centerYAnchor),
            windSpeedIcon.leadingAnchor.constraint(equalTo: windSpeedTitleLabel.trailingAnchor, constant: 5),
            //windSpeedLabel constraints
            windSpeedLabel.topAnchor.constraint(equalTo: windSpeedTitleLabel.bottomAnchor, constant: 10),
            windSpeedLabel.leadingAnchor.constraint(equalTo: windSpeedView.leadingAnchor, constant: 10),
            windSpeedLabel.trailingAnchor.constraint(equalTo: windSpeedView.trailingAnchor, constant: -10),
            //humidityView constraints
            humidityView.topAnchor.constraint(equalTo: feelsLikeView.bottomAnchor, constant: 15),
            humidityView.leadingAnchor.constraint(equalTo: feelsLikeView.leadingAnchor),
            humidityView.trailingAnchor.constraint(equalTo: feelsLikeView.trailingAnchor),
            humidityView.heightAnchor.constraint(equalToConstant: 100),
            //humidityTitleLabel constraints
            humidityTitleLabel.topAnchor.constraint(equalTo: humidityView.topAnchor, constant: 5),
            humidityTitleLabel.leadingAnchor.constraint(equalTo: sunriseTitleLabel.leadingAnchor),
            //humidityIcon constraints
            humidityIcon.centerYAnchor.constraint(equalTo: humidityTitleLabel.centerYAnchor),
            humidityIcon.leadingAnchor.constraint(equalTo: humidityTitleLabel.trailingAnchor, constant: 5),
            //humidityLabel constraints
            humidityLabel.topAnchor.constraint(equalTo: humidityTitleLabel.bottomAnchor, constant: 10),
            humidityLabel.leadingAnchor.constraint(equalTo: humidityView.leadingAnchor, constant: 10),
            humidityLabel.trailingAnchor.constraint(equalTo: humidityView.trailingAnchor, constant: -10),
            //pressureView constraints
            pressureView.topAnchor.constraint(equalTo: windSpeedView.bottomAnchor, constant: 15),
            pressureView.leadingAnchor.constraint(equalTo: windSpeedView.leadingAnchor),
            pressureView.trailingAnchor.constraint(equalTo: windSpeedView.trailingAnchor),
            pressureView.heightAnchor.constraint(equalToConstant: 100),
            //pressureTitleLabel constraints
            pressureTitleLabel.topAnchor.constraint(equalTo: pressureView.topAnchor, constant: 5),
            pressureTitleLabel.leadingAnchor.constraint(equalTo: sunsetTitleLabel.leadingAnchor),
            //pressureIcon
            pressureIcon.centerYAnchor.constraint(equalTo: pressureTitleLabel.centerYAnchor),
            pressureIcon.leadingAnchor.constraint(equalTo: pressureTitleLabel.trailingAnchor, constant: 5),
            //pressureLabel constraints
            pressureLabel.topAnchor.constraint(equalTo: pressureTitleLabel.bottomAnchor, constant: 10),
            pressureLabel.leadingAnchor.constraint(equalTo: pressureView.leadingAnchor, constant: 10),
            pressureLabel.trailingAnchor.constraint(equalTo: pressureView.trailingAnchor, constant: -10),
        ])
        
    }
    
}

extension MainViewController {
    
    //MARK: - A function that makes a gradient background and sets it as the sublayer of the view
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0/255.0, green: 235.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 100.0/255.0, green: 50.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    //MARK: - Function to refresh all of the labels
    func updateLabels() {
        self.topCurrentTempLabel.text = "Temp: \(Int(WeatherData.WeatherTempCelsius))˚"
        self.topRainAmountLabel.text = "Precipitation: \(RawWeatherData.rainAmount)mm"
        self.topCityNameLabel.text = "\(RawWeatherData.cityName)"
        self.topTempMinLabel.text = "Min Temp: \(WeatherData.WeatherTempMinCelsius)"
        self.topTempMaxLabel.text = "Max Temp: \(WeatherData.WeatherTempMaxCelsius)"
        //Checks if the current time is greater than the sunset time (text changes depending on it)
        if self.compareSunsetTime() == true {
            self.sunsetTimeLabel.text = "Sunset was at: \(WeatherData.localSunset)"
            self.sunsetIcon.image = UIImage(systemName: "sunset.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        } else {
            self.sunsetTimeLabel.text = "Sunset will be at: \(WeatherData.localSunset)"
            self.sunsetIcon.image = UIImage(systemName: "sunset")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        }
        if self.compareSunriseTime() == true {
            self.sunriseTimeLabel.text = "Sunrise was at: \(WeatherData.localSunrise)"
            self.sunriseIcon.image = UIImage(systemName: "sunrise.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        } else {
            self.sunriseTimeLabel.text = "Sunrise will be at: \(WeatherData.localSunrise)"
            self.sunriseIcon.image = UIImage(systemName: "sunrise")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        }
        self.feelsLikeTempLabel.text = "It feels like: \(WeatherData.WeatherFeelsLikeCelsius)˚"
        self.windSpeedLabel.text = "Wind speed is \(WeatherData.windSpeedMPH) MPH"
        self.humidityLabel.text = "Humidity is \(RawWeatherData.humidity)%"
        self.pressureLabel.text = "Pressure is \(WeatherData.pressureInHg) InHg"
    }
    
    //MARK: - Function for the pull to refresh on the scrollview
    @objc func refresh(sender:AnyObject) {
            // Code to refresh table view
        DispatchQueue.main.async {
            self.updateLabels()
        }
        urlString.urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\((UserLocation.userLatitude)!)&lon=\((UserLocation.userLongitude)!)&appid=\(constants.API_KEY)"
        print("urlString.urlString: \(urlString.urlString)")
        print("userLatitude: \((UserLocation.userLatitude)!)")
        print("userLongitude: \((UserLocation.userLongitude)!)")
        print("weatherTempCelsius: \(WeatherData.WeatherTempCelsius)")
        print("City Name: \(RawWeatherData.cityName)")
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.fetchFromReload()
        }
    }
    
    //Same as refresh but not objc and is used only when viewDidLoad
    func viewDidLoadRefresh() {
            // Code to refresh table view
        DispatchQueue.main.async {
            self.updateLabels()
        }
        urlString.urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\((UserLocation.userLatitude)!)&lon=\((UserLocation.userLongitude)!)&appid=\(constants.API_KEY)"
        print("urlString.urlString: \(urlString.urlString)")
        print("userLatitude: \((UserLocation.userLatitude)!)")
        print("userLongitude: \((UserLocation.userLongitude)!)")
        print("weatherTempCelsius: \(WeatherData.WeatherTempCelsius)")
        print("City Name: \(RawWeatherData.cityName)")
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
        fetchFromReload()
    }
    
    //Creates a function for running fetchWeather from reload func
    func fetchFromReload() {
        DispatchQueue.main.async {
            self.fetchWeather()
            self.convertKelvinIntoCelsius()
            self.convertEpochToDate()
            self.convertHPAtoInHg()
            self.convertWindSpeedKPH()
            self.convertWindSpeedMPH()
            self.reloadSunriseTime()
            self.reloadSunsetTime()
            self.updateLabels()
        }
    }
   
    //Function for checing location manager status (starts getting the location if allowed)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
        case .notDetermined:
            print("status: notDetermined")
        case .denied:
            print("status: denied")
        case .restricted:
            print("status: restricted")
        case .authorizedAlways:
            print("status: authorizedAlways")
            locationManager.startUpdatingLocation()
            viewDidLoadRefresh()
        case .authorizedWhenInUse:
            print("status: authorizedWhenInUse")
            locationManager.startUpdatingLocation()
            viewDidLoadRefresh()
        default:
            print("unknown ")
        }
    }
    
    func reloadSunriseTime() {
        if self.compareSunriseTime() == true {
            self.sunriseTimeLabel.text = "Sunrise was at: \(WeatherData.localSunrise)"
        } else {
            self.sunriseTimeLabel.text = "Sunrise will be at: \(WeatherData.localSunrise)"
        }
    }
    
    func reloadSunsetTime() {
        if self.compareSunsetTime() == true {
            self.sunsetTimeLabel.text = "Sunrise was at: \(WeatherData.localSunset)"
        } else {
            self.sunsetTimeLabel.text = "Sunrise will be at: \(WeatherData.localSunset)"
        }
    }
    
    //Function for actually getting the location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        UserLocation.userLatitude = locValue.latitude
        UserLocation.userLongitude = locValue.longitude
        print("UserLocation.userLatitude = \((UserLocation.userLatitude)!)")
        print("UserLocation.userLongitude = \((UserLocation.userLongitude)!)")
    }
    
    @objc func sunriseTapped() {
        print("sunrise Tapped")
        present(sunrisePopUpViewController, animated: true)
    }

    /*  Can't get this to work, might implement later
    func drawPressureAnimation() {
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32)
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: 2)
        let trackShape = CAShapeLayer()
        trackShape.path = roundedRect.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 5
        trackShape.strokeColor = UIColor.lightGray.cgColor
        bottomScrollStackview.layer.addSublayer(trackShape)
    }
     */
}

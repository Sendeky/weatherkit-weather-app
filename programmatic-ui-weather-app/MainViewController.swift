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
    let topRainAmountLabel = UILabel()
    let topWeatherIconView = UIImageView()
    let topCurrentTempLabel = UILabel()
    let topUVIndexLabel = UILabel()
    let topCityNameLabel = UILabel()
    let topMinMaxTempView = UIStackView()
    let topTempMinLabel = UILabel()
    let topTempMaxLabel = UILabel()
    let bottomScrollview = UIScrollView()
    let topScrollStackview = UIStackView()
    let sunsetTimeLabel = UILabel()
    let feelsLikeTempLabel = UILabel()
    let windSpeedLabel = UILabel()
    let humidityLabel = UILabel()
    let sunriseTimeLabel = UILabel()
    let pressureLabel = UILabel()
    
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
                    self.sunsetTimeLabel.text = "Sunset was at: \(WeatherData.localSunset)"
                } else {
                    self.sunsetTimeLabel.text = "Sunset will be at: \(WeatherData.localSunset)"
                }
                if self.compareSunriseTime() == true {
                    self.sunriseTimeLabel.text = "Sunrise was at: \(WeatherData.localSunrise)"
                } else {
                    self.sunriseTimeLabel.text = "Sunrise will be at: \(WeatherData.localSunrise)"
                }
                self.feelsLikeTempLabel.text = "Feels like: \(WeatherData.WeatherFeelsLikeCelsius)˚"
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
        topSubStackview.axis = .horizontal
        topSubStackview.spacing = 30
        topSubStackview.tintColor = .systemYellow
        
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
        
        //Sets settings for topScrollStackview
        topScrollStackview.translatesAutoresizingMaskIntoConstraints = false
        topScrollStackview.axis = .vertical
        topScrollStackview.spacing = 30
        
        //Sets settings for sunsetTimeLabel
        sunsetTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        sunsetTimeLabel.text = "Sunset happened at: "
        sunsetTimeLabel.font = .preferredFont(forTextStyle: .title2)
        sunsetTimeLabel.adjustsFontSizeToFitWidth = true
        
        //Sets settings for feelsLikeTempLabel
        feelsLikeTempLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeTempLabel.text = "Feels like: "
        feelsLikeTempLabel.font = .preferredFont(forTextStyle: .title2)
        feelsLikeTempLabel.adjustsFontSizeToFitWidth = true
        
        //Sets settings for windSpeedLabel
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.text = "Wind Speed is"
        windSpeedLabel.font = .preferredFont(forTextStyle: .title2)
        windSpeedLabel.adjustsFontSizeToFitWidth = false
        
        //Sets settings for humidityLabel
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.text = "Humidity is"
        humidityLabel.font = .preferredFont(forTextStyle: .title2)
        humidityLabel.adjustsFontSizeToFitWidth = false
        
        //Sets settings for sunriseTimeLabel
        sunriseTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        sunriseTimeLabel.text = "Sunrise happened at: "
        sunriseTimeLabel.font = .preferredFont(forTextStyle: .title2)
        sunriseTimeLabel.adjustsFontSizeToFitWidth = true
        
        //Seets settings for pressureLabel
        pressureLabel.translatesAutoresizingMaskIntoConstraints  = false
        pressureLabel.text = "Pressure is: "
        pressureLabel.font = .preferredFont(forTextStyle: .title2)
        pressureLabel.adjustsFontSizeToFitWidth = false
        
        //Sets settings for refreshControl
        refreshControl.attributedTitle = NSAttributedString("Fetching Weather")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        
    }
    
    private func layout(){
        //Adds rain chance label, weather icon view, and current temp label into the topSubStackview
        topSubStackview.addArrangedSubview(topRainAmountLabel)
        topSubStackview.addArrangedSubview(topWeatherIconView)
        topSubStackview.addArrangedSubview(topCurrentTempLabel)
        
        //Adds topSubStackview, uv index, city name labels, and topMinMaxTempView into topStackView
        topStackview.addSubview(topSubStackview)
        topStackview.addSubview(topUVIndexLabel)
        topStackview.addSubview(topCityNameLabel)
        topStackview.addSubview(topMinMaxTempView)
        
        //Adds min and max temp labels into topMinMaxTempView
        topMinMaxTempView.addArrangedSubview(topTempMinLabel)
        topMinMaxTempView.addArrangedSubview(topTempMaxLabel)
        
        //Adds sunset, feels like, wind speed, humidity labels into topScrollStackview
        topScrollStackview.addSubview(sunsetTimeLabel)
        topScrollStackview.addSubview(feelsLikeTempLabel)
        topScrollStackview.addSubview(windSpeedLabel)
        topScrollStackview.addSubview(humidityLabel)
        topScrollStackview.addSubview(pressureLabel)
        topScrollStackview.addSubview(sunriseTimeLabel)
        
        //Adds topScrollStackview into bottomScrollview
        bottomScrollview.addSubview(topScrollStackview)
        bottomScrollview.addSubview(refreshControl)
        
        //Adds the main stacks into the view
        view.addSubview(topStackview)
        view.addSubview(bottomScrollview)
        
        //Sets the constraints for everything
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
            topMinMaxTempView.centerYAnchor.constraint(equalTo: topCityNameLabel.bottomAnchor, constant: 20),
            bottomScrollview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomScrollview.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            bottomScrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomScrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomScrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sunsetTimeLabel.centerXAnchor.constraint(equalTo: bottomScrollview.centerXAnchor),
            feelsLikeTempLabel.centerXAnchor.constraint(equalTo: bottomScrollview.centerXAnchor),
            feelsLikeTempLabel.topAnchor.constraint(equalTo: sunsetTimeLabel.bottomAnchor, constant: 15),
            windSpeedLabel.centerXAnchor.constraint(equalTo: bottomScrollview.centerXAnchor),
            windSpeedLabel.topAnchor.constraint(equalTo: feelsLikeTempLabel.bottomAnchor, constant: 15),
            humidityLabel.centerXAnchor.constraint(equalTo: bottomScrollview.centerXAnchor),
            humidityLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 15),
            pressureLabel.centerXAnchor.constraint(equalTo: bottomScrollview.centerXAnchor),
            pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 15),
            sunriseTimeLabel.centerXAnchor.constraint(equalTo: bottomScrollview.centerXAnchor),
            sunriseTimeLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 15)
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
        } else {
            self.sunsetTimeLabel.text = "Sunset will be at: \(WeatherData.localSunset)"
        }
        if self.compareSunriseTime() == true {
            self.sunriseTimeLabel.text = "Sunrise was at: \(WeatherData.localSunrise)"
        } else {
            self.sunriseTimeLabel.text = "Sunrise will be at: \(WeatherData.localSunrise)"
        }
        self.feelsLikeTempLabel.text = "Feels like: \(WeatherData.WeatherFeelsLikeCelsius)˚"
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
        }
        fetchFromReload()
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
        fetchWeather()
        convertKelvinIntoCelsius()
        convertEpochToDate()
        convertHPAtoInHg()
        convertWindSpeedKPH()
        convertWindSpeedMPH()
        DispatchQueue.main.async {
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

    /*  Can't get this to work, might implement later
    func drawPressureAnimation() {
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32)
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: 2)
        let trackShape = CAShapeLayer()
        trackShape.path = roundedRect.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 5
        trackShape.strokeColor = UIColor.lightGray.cgColor
        topScrollStackview.layer.addSublayer(trackShape)
    }
     */
}

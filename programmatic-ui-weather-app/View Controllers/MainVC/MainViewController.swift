//
//  MainViewController.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/11/22.
//

import UIKit
import CoreLocation
import WeatherKit
//import SwiftUI

struct UserLocation {
    static var userLatitude: Double? = 0.0
    static var userLongitude: Double? = 0.0
    static var userCLLocation: CLLocation?
}

class MainViewController: UIViewController, CLLocationManagerDelegate, UIScrollViewDelegate {
    
    //cyanColor constant (used in precipitationView, hourlyForecastView, etc.)
    let cyanColor = UIColor(red: 95.0/255.0, green: 195.0/255.0, blue: 255.0/255.0, alpha: 0.93)
    
    let iconView = UIImageView()
    let tempStackView = UIStackView()
    let cityLabel = UILabel()
    let currentTempLabel = UILabel()
    let todayTempLabel = UILabel()
    let rocketText = UILabel()
    let rocketView = UIImageView()
    let scrollView = UIScrollView()
    let precipitationView = UIView()
    let precipitationTitleLabel = UILabel()
    let precipitationLabel = UILabel()
    let hourlyForecastView = UIView()
    let hourlyForecastTitleLabel = UILabel()
    //MARK: - HourlyForecastView Interior stuff
    let scrollview = UIScrollView()
    let horizontalStack = UIStackView()
    let stackview1 = UIStackView()
    let topLabel1 = UILabel()
    let iconView1 = UIImageView()
    let bottomLabel1 = UILabel()
    
    
    let stackview2 = UIStackView()
    let topLabel2 = UILabel()
    let iconView2 = UIImageView()
    let bottomLabel2 = UILabel()
    
    
    let stackview3 = UIStackView()
    let topLabel3 = UILabel()
    let iconView3 = UIImageView()
    let bottomLabel3 = UILabel()
    
    
    let stackview4 = UIStackView()
    let topLabel4 = UILabel()
    let iconView4 = UIImageView()
    let bottomLabel4 = UILabel()
    
    
    let stackview5 = UIStackView()
    let topLabel5 = UILabel()
    let iconView5 = UIImageView()
    let bottomLabel5 = UILabel()
    
    
    //windView settings
    let windView = UIView()
    let windTitleLabel = UILabel()
    let windLabel = UILabel()
    
    //Creates a refresh control for the scrollview
    var refreshControl = UIRefreshControl()
    //Creates the location manager
    let locationManager = CLLocationManager()
    //Creates view for cloud at top
    let uiView = UIView()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setBackground() //Function that sets the view to a background
        view.backgroundColor = .orange
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        //Initalizes settings for UI elements and layout for UI elements
        style()
        layout()
        //initializes location services
        initializeLocationServices()
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]) { success, error in
        }
        
        DispatchQueue.global().async {
            self.viewDidLoadRefresh()

            //Updates all the labels asynchronously
            DispatchQueue.main.async {
                self.iconView.image = UIImage(systemName: WeatherKitData.Symbol + ".fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64.0))?.withRenderingMode(.alwaysOriginal)
                self.currentTempLabel.text = "\(WeatherKitData.Temp)"
                self.todayTempLabel.text = "H:\(WeatherKitData.TempMax) L:\(WeatherKitData.TempMin)"
                self.windLabel.text = "\(WeatherKitData.WindSpeed)"
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //Animates the cloud at the top
        UIView.animate(withDuration: 20.0, delay: 0.5, options: [.repeat, .curveLinear] ,animations: {
            self.uiView.center.x = self.view.bounds.maxX + 200
            self.uiView.center.x = self.view.bounds.minX - 200
        })
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
        
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.image = UIImage(systemName: "questionmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64.0))?.withRenderingMode(.alwaysOriginal)
        //tempStackView settings
        tempStackView.axis = .vertical
        tempStackView.translatesAutoresizingMaskIntoConstraints = false
        tempStackView.spacing = 15
        tempStackView.alignment = .center
        
        //cityLabel settings
        cityLabel.font = .preferredFont(forTextStyle: .largeTitle)
        cityLabel.text = "City"
        
        //currentTempLabel settings
        currentTempLabel.font = .preferredFont(forTextStyle: .largeTitle)
        currentTempLabel.text = "--˚"
        
        //todayTempLabel settings
        todayTempLabel.font = .preferredFont(forTextStyle: .title1)
        todayTempLabel.text = "H:--˚ L:--˚"
        
        //rocketText settings
        rocketText.text = "--"
        rocketText.font = .preferredFont(forTextStyle: .body)
        rocketText.translatesAutoresizingMaskIntoConstraints = false
        
        //rocketView settings
        let rocketTapGesture = UITapGestureRecognizer(target: self, action: #selector(launchRocket))
        rocketTapGesture.isEnabled = false
        rocketView.translatesAutoresizingMaskIntoConstraints = false
        rocketView.contentMode = .scaleAspectFit
        rocketView.clipsToBounds = true
        rocketView.image = UIImage(named: "Falcon-Heavy.svg")
        rocketView.layer.shadowColor = UIColor.black.cgColor
        rocketView.layer.shadowRadius = 15.0
        rocketView.layer.shadowOpacity = 0.7
        rocketView.layer.shadowOffset = CGSize(width: -4, height: 4)
        rocketView.layer.masksToBounds = false
        rocketView.isUserInteractionEnabled = true
        rocketView.addGestureRecognizer(rocketTapGesture)
        
        //scrollView settings
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: 200, height: 300)
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceHorizontal = false
        
        //precipitationView settings
        precipitationView.translatesAutoresizingMaskIntoConstraints = false
        precipitationView.layer.cornerRadius = 20
        precipitationView.backgroundColor = cyanColor
    //        precipitationView.applyBlurEffect(.systemUltraThinMaterialDark, cornerRadius: 20)
        
        //precupitationTitleLabel settings
        precipitationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        precipitationTitleLabel.text = "Precipitation"
        precipitationTitleLabel.font = .preferredFont(forTextStyle: .body)
        
        //precipitationLabel settings
        precipitationLabel.translatesAutoresizingMaskIntoConstraints = false
        precipitationLabel.text = "--% Chance"
        precipitationLabel.font = .preferredFont(forTextStyle: .title2)
        
        //hourlyForecastView settings
        hourlyForecastView.translatesAutoresizingMaskIntoConstraints = false
        hourlyForecastView.layer.cornerRadius = 20
        hourlyForecastView.backgroundColor = cyanColor
    //        hourlyForecastView.applyBlurEffect(.systemUltraThinMaterial, cornerRadius: 20)
        
        //hourlyForecastTitleLabel
        hourlyForecastTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        hourlyForecastTitleLabel.text = "Hourly Forecast"
        hourlyForecastTitleLabel.font = .preferredFont(forTextStyle: .body)
        
        //MARK: - hourlyForecastView interior stuff
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.alwaysBounceHorizontal = true
        scrollview.contentSize = CGSize(width: 500, height: 100)
        scrollview.showsHorizontalScrollIndicator = false
        
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.spacing = 20
        
        stackview1.translatesAutoresizingMaskIntoConstraints = false
        stackview1.axis = .vertical
        stackview1.alignment = .center
        
        topLabel1.translatesAutoresizingMaskIntoConstraints = false
        topLabel1.text = "--˚"
        topLabel1.font = .preferredFont(forTextStyle: .title2)
        
        iconView1.translatesAutoresizingMaskIntoConstraints = false
        iconView1.image = UIImage(systemName: "sun.max.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))!
        iconView1.contentMode = .scaleAspectFit
        
        bottomLabel1.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel1.text = "--"
        bottomLabel1.font = .preferredFont(forTextStyle: .body)
        
        stackview2.translatesAutoresizingMaskIntoConstraints = false
        stackview2.axis = .vertical
        stackview2.alignment = .center
        
        topLabel2.translatesAutoresizingMaskIntoConstraints = false
        topLabel2.text = "--˚"
        topLabel2.font = .preferredFont(forTextStyle: .title2)
        
        iconView2.translatesAutoresizingMaskIntoConstraints = false
        iconView2.image = UIImage(systemName: "sun.max.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))!
        iconView2.contentMode = .scaleAspectFit
        
        bottomLabel2.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel2.text = "--"
        bottomLabel2.font = .preferredFont(forTextStyle: .body)
        
        stackview3.translatesAutoresizingMaskIntoConstraints = false
        stackview3.axis = .vertical
        stackview3.alignment = .center
        
        topLabel3.translatesAutoresizingMaskIntoConstraints = false
        topLabel3.text = "--˚"
        topLabel3.font = .preferredFont(forTextStyle: .title2)
        
        iconView3.translatesAutoresizingMaskIntoConstraints = false
        iconView3.image = UIImage(systemName: "sun.max.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))!
        iconView3.contentMode = .scaleAspectFit
        
        bottomLabel3.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel3.text = "--"
        bottomLabel3.font = .preferredFont(forTextStyle: .body)
        
        stackview4.translatesAutoresizingMaskIntoConstraints = false
        stackview4.axis = .vertical
        stackview4.alignment = .center
        
        topLabel4.translatesAutoresizingMaskIntoConstraints = false
        topLabel4.text = "--˚"
        topLabel4.font = .preferredFont(forTextStyle: .title2)
        
        iconView4.translatesAutoresizingMaskIntoConstraints = false
        iconView4.image = UIImage(systemName: "sun.max.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))!
        iconView4.contentMode = .scaleAspectFit
        
        bottomLabel4.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel4.text = "--"
        bottomLabel4.font = .preferredFont(forTextStyle: .body)
        
        stackview5.translatesAutoresizingMaskIntoConstraints = false
        stackview5.axis = .vertical
        stackview5.alignment = .center
        
        topLabel5.translatesAutoresizingMaskIntoConstraints = false
        topLabel5.text = "--˚"
        topLabel5.font = .preferredFont(forTextStyle: .title2)
        
        windView.translatesAutoresizingMaskIntoConstraints = false
        windView.backgroundColor = cyanColor
        windView.layer.cornerRadius = 20
    //        windView.applyBlurEffect(.systemUltraThinMaterialLight, cornerRadius: 20)
        
        iconView5.translatesAutoresizingMaskIntoConstraints = false
        iconView5.image = UIImage(systemName: "sun.max.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))!
        iconView5.contentMode = .scaleAspectFit
        
        bottomLabel5.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel5.text = "--"
        bottomLabel5.font = .preferredFont(forTextStyle: .body)
        
        windTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        windTitleLabel.text = "Wind"
        windTitleLabel.font = .preferredFont(forTextStyle: .body)
        
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.text = "--MPH"
        windLabel.font = .preferredFont(forTextStyle: .title1)
        
        //Sets settings for refreshControl
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.attributedTitle = NSAttributedString("Fetching Weather")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
    }
    
    private func layout(){
        stackview1.addArrangedSubview(iconView1)
        stackview1.addArrangedSubview(topLabel1)
        stackview1.addArrangedSubview(bottomLabel1)
        
        stackview2.addArrangedSubview(iconView2)
        stackview2.addArrangedSubview(topLabel2)
        stackview2.addArrangedSubview(bottomLabel2)
        
        stackview3.addArrangedSubview(iconView3)
        stackview3.addArrangedSubview(topLabel3)
        stackview3.addArrangedSubview(bottomLabel3)
        
        stackview4.addArrangedSubview(iconView4)
        stackview4.addArrangedSubview(topLabel4)
        stackview4.addArrangedSubview(bottomLabel4)
        
        stackview5.addArrangedSubview(iconView5)
        stackview5.addArrangedSubview(topLabel5)
        stackview5.addArrangedSubview(bottomLabel5)
        
        horizontalStack.addArrangedSubview(stackview1)
        horizontalStack.addArrangedSubview(stackview2)
        horizontalStack.addArrangedSubview(stackview3)
        horizontalStack.addArrangedSubview(stackview4)
        horizontalStack.addArrangedSubview(stackview5)
        
        scrollview.addSubview(horizontalStack)
        
        tempStackView.addArrangedSubview(cityLabel)
        tempStackView.addArrangedSubview(currentTempLabel)
        tempStackView.addArrangedSubview(todayTempLabel)
        
        //Adds views into scrollview
        scrollView.addSubview(precipitationView)
        scrollView.addSubview(hourlyForecastView)
        scrollView.addSubview(windView)
        scrollView.addSubview(refreshControl)
        
        //Adds elements into precipitationView
        precipitationView.addSubview(precipitationTitleLabel)
        precipitationView.addSubview(precipitationLabel)
        
        //Adds elements into windView
        windView.addSubview(windTitleLabel)
        windView.addSubview(windLabel)
        
        //Adds elements into hourlyForecastView
        hourlyForecastView.addSubview(hourlyForecastTitleLabel)
        hourlyForecastView.addSubview(scrollview)
        
        
        //Adds Views into main view
        view.addSubview(rocketText)
        view.addSubview(iconView)
        view.addSubview(scrollView)
        view.addSubview(rocketView)
        view.addSubview(tempStackView)
        
        
        NSLayoutConstraint.activate([
            //iconView constraints
            iconView.centerYAnchor.constraint(equalTo: currentTempLabel.centerYAnchor),
            iconView.centerXAnchor.constraint(equalTo: rocketView.centerXAnchor),
//            iconView.widthAnchor.constraint(equalToConstant: ),
            //rocketText constraints
            rocketText.centerXAnchor.constraint(equalTo: rocketView.centerXAnchor),
            rocketText.bottomAnchor.constraint(equalTo: rocketView.topAnchor),
            //rocketView constraints
            rocketView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rocketView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            rocketView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            rocketView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            //tempStackView constraints
            tempStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tempStackView.leadingAnchor.constraint(equalTo: rocketView.trailingAnchor),
            tempStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //scrollView constraints
            scrollView.topAnchor.constraint(equalTo: tempStackView.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: rocketView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //precipitationView constraints
            precipitationView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            precipitationView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
//            precipitationView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            precipitationView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            precipitationView.heightAnchor.constraint(equalToConstant: 100),
            //precipitationTitleLabel constraints
            precipitationTitleLabel.topAnchor.constraint(equalTo: precipitationView.topAnchor, constant: 10),
            precipitationTitleLabel.leadingAnchor.constraint(equalTo: precipitationView.leadingAnchor, constant: 10),
            //precipitationLabel constraints
            precipitationLabel.centerYAnchor.constraint(equalTo: precipitationView.centerYAnchor),
            precipitationLabel.centerXAnchor.constraint(equalTo: precipitationView.centerXAnchor),
            //hourlyForecastView constraints
            hourlyForecastView.topAnchor.constraint(equalTo: precipitationView.bottomAnchor, constant: 20),
            hourlyForecastView.leadingAnchor.constraint(equalTo: precipitationView.leadingAnchor),
            hourlyForecastView.centerXAnchor.constraint(equalTo: precipitationView.centerXAnchor),
            hourlyForecastView.heightAnchor.constraint(equalToConstant: 150),
            //hourlyForecastTitleLable constraints
            hourlyForecastTitleLabel.topAnchor.constraint(equalTo: hourlyForecastView.topAnchor, constant: 10),
            hourlyForecastTitleLabel.leadingAnchor.constraint(equalTo: hourlyForecastView.leadingAnchor, constant: 10),
            //scrollview constraints
            scrollview.topAnchor.constraint(equalTo: hourlyForecastTitleLabel.bottomAnchor, constant: 10),
            scrollview.leadingAnchor.constraint(equalTo: hourlyForecastView.leadingAnchor, constant: 10),
            scrollview.trailingAnchor.constraint(equalTo: hourlyForecastView.trailingAnchor, constant: -10),
            scrollview.bottomAnchor.constraint(equalTo: hourlyForecastView.bottomAnchor, constant: -10),
            //horizontalStack constrains
            horizontalStack.topAnchor.constraint(equalTo: scrollview.topAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            //windView constraints
            windView.topAnchor.constraint(equalTo: hourlyForecastView.bottomAnchor, constant: 20),
            windView.leadingAnchor.constraint(equalTo: hourlyForecastView.leadingAnchor),
            windView.centerXAnchor.constraint(equalTo: hourlyForecastView.centerXAnchor),
            windView.heightAnchor.constraint(equalToConstant: 100),
            //windTitleLabel constraints
            windTitleLabel.topAnchor.constraint(equalTo: windView.topAnchor, constant: 10),
            windTitleLabel.leadingAnchor.constraint(equalTo: windView.leadingAnchor, constant: 10),
            //windLabel constraints
            windLabel.centerYAnchor.constraint(equalTo: windView.centerYAnchor),
            windLabel.centerXAnchor.constraint(equalTo: windView.centerXAnchor),
        ])
    }//Layout func
}//MainViewController class

extension MainViewController {
    
    //MARK: - A function that makes a background and sets it as the sublayer of the view
    func setBackground() {
        
        //Creates cloud at top of the screen
        uiView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 4)
        let cloud = UIImage(named: "Cloud.svg")
        let cloudView : UIImageView!
        cloudView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 4))
        cloudView.contentMode =  .scaleAspectFit
        cloudView.layer.opacity = 0.6
        cloudView.clipsToBounds = true
        cloudView.image = cloud
        cloudView.center = view.center
        cloudView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 4)
        uiView.addSubview(cloudView)
        view.addSubview(uiView)
        view.sendSubviewToBack(uiView)
        
        
        let background = UIImage(named: "Background.svg")
        let imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.frame = CGRect(x: -5, y: -5, width: view.bounds.width + 25, height: view.bounds.height + 25)
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -20
        horizontalMotionEffect.maximumRelativeValue = 20
        
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -20
        verticalMotionEffect.maximumRelativeValue = 20
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        imageView.addMotionEffect(motionEffectGroup)
    }
    
    //MARK: - Function to refresh all of the labels
    func updateLabels() {
        self.iconView.image = UIImage(systemName: WeatherKitData.Symbol + ".fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64.0))?.withRenderingMode(.alwaysOriginal)
        self.currentTempLabel.text = "\(WeatherKitData.Temp)"
        self.todayTempLabel.text = "H:\(WeatherKitData.TempMax) L:\(WeatherKitData.TempMin)"
        self.windLabel.text = "\(WeatherKitData.WindSpeed)"
        self.precipitationLabel.text = "\(WeatherKitData.RainChance)% Chance"
        DateConverter().timeArrayMaker()
//        getWeather(location: UserLocation.userCLLocation!)
        
        if WeatherKitData.HourlyForecast.count < 5 {
            print("whoops")
        } else {
            self.topLabel1.text = "\(Int((round(WeatherKitData.HourlyForecast[1])*100)/100))˚"
            self.topLabel2.text = "\(Int((round(WeatherKitData.HourlyForecast[2])*100)/100))˚"
            self.topLabel3.text = "\(Int((round(WeatherKitData.HourlyForecast[3])*100)/100))˚"
            self.topLabel4.text = "\(Int((round(WeatherKitData.HourlyForecast[4])*100)/100))˚"
            self.topLabel5.text = "\(Int((round(WeatherKitData.HourlyForecast[5])*100)/100))˚"

        }
        
        self.bottomLabel1.text = "\(timeArray.formattedHours[0])"
        self.bottomLabel2.text = "\(timeArray.formattedHours[1])"
        self.bottomLabel3.text = "\(timeArray.formattedHours[2])"
        self.bottomLabel4.text = "\(timeArray.formattedHours[3])"
        self.bottomLabel5.text = "\(timeArray.formattedHours[4])"
        
    }
    
    //MARK: - Function for the pull to refresh on the scrollview
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        print("userLatitude: \((UserLocation.userLatitude)!)")
        print("userLongitude: \((UserLocation.userLongitude)!)")
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
        print("userLatitude: \((UserLocation.userLatitude)!)")
        print("userLongitude: \((UserLocation.userLongitude)!)")
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
        fetchFromReload()
    }
    
    //Creates a function for running fetchWeather from reload func
    func fetchFromReload() {
        DispatchQueue.main.async {
            if UserLocation.userCLLocation != nil {
                self.getWeather(location: UserLocation.userCLLocation!)
            } else {
            }
            self.updateLabels()
        }
    }
    
    func getWeatherLabelUpdate() {
        DispatchQueue.main.async {
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
            cityLabel.text = "No Location!"
            print("status: denied")
        case .restricted:
            cityLabel.text = "No Location!"
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
    
    //Function for actually getting the location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
        UserLocation.userLatitude = locValue.latitude
        UserLocation.userLongitude = locValue.longitude
        UserLocation.userCLLocation = locations[0]
        getWeather(location: locations[0])
//        print(UserLocation.userCLLocation)
//        self.locationManager.delegate = nil
    }
    
    @objc func launchRocket() {
//        rocketView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIImageView.animate(withDuration: 4.4, animations: {
            [weak self] in
            self!.rocketView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self!.rocketView.frame.origin.y -= 1000
        }) { (done) in
            UIImageView.animate(withDuration: 2.0, delay: 8.0, options: [.curveEaseOut], animations: {
              [weak self] in
                self!.rocketView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self!.rocketView.frame.origin.y += 1000
            })
        }
    }
    
    /* MARK: TODO
    //func for sunrise view tapped
    @objc func sunriseTapped() {
        print("sunrise Tapped")
        let sunriseSunsetPop = UIHostingController(rootView: SunriseSunsetPopUpVC())
        
        //Uses animation from Animations.swift
        self.sunriseView.showAnimation {
            self.present(sunriseSunsetPop, animated: true)
        }
    }
    
    //func for sunset view tapped
    @objc func sunsetTapped() {
        let sunriseSunsetPop = UIHostingController(rootView: SunriseSunsetPopUpVC())
        
        //Uses animation from Animations.swift
        self.sunsetView.showAnimation {
            self.present(sunriseSunsetPop, animated: true)
        }
    }
    
    //func for windSpeed view tapped
    @objc func windSpeedTapped() {
        print("windSpeedView tapped")
        let windSpeedPopUp = UIHostingController(rootView: WindSpeedPopUpVC())
    
        //Uses animation from Animations.swift
        self.windSpeedView.showAnimation {
            self.present(windSpeedPopUp, animated: true)
        }
    }
     */
}

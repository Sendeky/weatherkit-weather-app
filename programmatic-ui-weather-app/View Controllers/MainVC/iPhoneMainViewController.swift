//
//  MainViewController.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/11/22.
//

import UIKit
import CoreLocation
import WeatherKit
import SwiftUI

struct UserLocation {
    static var userLatitude: Double? = 0.0
    static var userLongitude: Double? = 0.0
    static var userCLLocation: CLLocation?
}

class MainViewController: UIViewController, CLLocationManagerDelegate, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    //windView variables
    let windView = UIView()
    let windTitleLabel = UILabel()
    let windLabel = UILabel()
    
    // collection view for hourly forecast
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())      // need to have frame and layout for UICollectionView
    
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
        
        // hourly collection view stuff
        configureCollectionView()
        // Register the custom cell class for reuse
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        
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
    
    //Starts animating cloud before view loads
    override func viewWillAppear(_ animated: Bool) {
        //Animates the cloud at the top
        UIView.animate(withDuration: 20.0, delay: 0.5, options: [.repeat, .curveLinear] ,animations: {
            self.uiView.center.x = self.view.bounds.maxX + 200
            self.uiView.center.x = self.view.bounds.minX - 200
        })
        viewDidLoadRefresh()
        super.viewWillAppear(true)
    }
    
    //func to initialize location services
    private func initializeLocationServices() {
        locationManager.delegate = self
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        locationManager.requestAlwaysAuthorization() //Requests always authorization for locationServices
    }
    
    //func to set settings for elements
    private func style() {
        //iconView settings
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.image = UIImage(systemName: "questionmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64.0))?.withRenderingMode(.alwaysOriginal)
        //tempStackView settings
        tempStackView.axis = .vertical
        tempStackView.translatesAutoresizingMaskIntoConstraints = false
        tempStackView.spacing = 15
        tempStackView.alignment = .center
        
        //cityLabel settings
        guard let customFont = UIFont(name: "SpaceX", size: 24.0) else {
            fatalError("""
                Failed to load the "SpaceX" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        cityLabel.font = customFont
//        cityLabel.font = .preferredFont(forTextStyle: .largeTitle)
        cityLabel.text = "City"
        cityLabel.adjustsFontSizeToFitWidth = true
        
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
        let precipitationTapGesture = UITapGestureRecognizer(target: self, action: #selector(precipitationTapped))
        precipitationView.translatesAutoresizingMaskIntoConstraints = false
        precipitationView.layer.cornerRadius = 20
        precipitationView.backgroundColor = cyanColor
        precipitationView.addGestureRecognizer(precipitationTapGesture)
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
        
        //CollectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        let windTapGesture = UITapGestureRecognizer(target: self, action: #selector(windSpeedTapped))
        windView.translatesAutoresizingMaskIntoConstraints = false
        windView.backgroundColor = cyanColor
        windView.layer.cornerRadius = 20
        windView.isUserInteractionEnabled = true
        windView.addGestureRecognizer(windTapGesture)
//            windView.applyBlurEffect(.systemUltraThinMaterialLight, cornerRadius: 20)
        
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
    
    //func to set layout for elements
    private func layout(){
        
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
        hourlyForecastView.addSubview(collectionView)
        
        
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
            //HourlyCollectionView constraints
            collectionView.topAnchor.constraint(equalTo: hourlyForecastTitleLabel.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: hourlyForecastView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: hourlyForecastView.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: hourlyForecastView.bottomAnchor, constant: -10),
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
        ])//Constraint Array
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
        
        
        var background = UIImage(named: "Background.svg")
        var imageView : UIImageView!
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
        //Checks if weatherkit returned symbol is "wind"
        //This is because "wind" (SF Symbol) has no fill option
        if WeatherKitData.Symbol != "wind" {
            self.iconView.image = UIImage(systemName: WeatherKitData.Symbol + ".fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64.0))?.withRenderingMode(.alwaysOriginal)
        } else {
            self.iconView.image = UIImage(systemName: WeatherKitData.Symbol, withConfiguration: UIImage.SymbolConfiguration(pointSize: 64.0))?.withRenderingMode(.alwaysOriginal)
        }
        self.currentTempLabel.text = "\(WeatherKitData.Temp)"
        self.todayTempLabel.text = "H:\(WeatherKitData.TempMax) L:\(WeatherKitData.TempMin)"
        self.windLabel.text = "\(WeatherKitData.WindSpeed)"
        self.precipitationLabel.text = "\(WeatherKitData.PrecipitationChance)% Chance"
        DateConverter().timeArrayMaker()
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
                WeatherKitData.HourlyForecast.removeAll()
                WeatherKitData.TempMaxForecast.removeAll()
                WeatherKitData.TempMinForecast.removeAll()
                self.getWeather(location: UserLocation.userCLLocation!)
            } else {
            }
            self.updateLabels()
            self.collectionView.reloadData()
        }
    }
    
    func getWeatherLabelUpdate() {
        DispatchQueue.main.async {
            self.updateLabels()
            self.collectionView.reloadData()
        }
    }
   
    //Function for checking location manager status (starts getting the location if allowed)
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
            if UserLocation.userCLLocation != nil {
                getWeather(location: UserLocation.userCLLocation!)
            }
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
        
        for i in 0...3 {
            getWeather(location: locations[0])
        }
        locationManager.stopUpdatingLocation()
//        print(UserLocation.userCLLocation)
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
     */
    
    //func for Precipitation view tapped
    @objc func precipitationTapped() {
        print("precipitationView tapped")
        let precipitationPopUp = UIHostingController(rootView: PrecipitationPopUpVC())
    
        //Uses animation from Animations.swift
        self.precipitationView.showAnimation {
            self.present(precipitationPopUp, animated: true)
        }
    }
    
    //func for windSpeed view tapped
    @objc func windSpeedTapped() {
        print("windSpeedView tapped")
        let windSpeedPopUp = UIHostingController(rootView: WindSpeedPopUpVC())
    
        //Uses animation from Animations.swift
        self.windView.showAnimation {
            self.present(windSpeedPopUp, animated: true)
        }
    }
    
    //MARK: Hourly Forecast Collection View
    private func configureCollectionView() {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            // Register your custom cell class
            collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
            
            // Set the collection view's layout to horizontal scroll
            if let layout2 = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout2.scrollDirection = .horizontal
            }
        }
    
    // number of hourly cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        // checks if there is enough data to show
        if WeatherKitData.HourlyForecastSymbol.count > 6 {
            //simple check for when icon is "wind" (doesn't have "fill" option)
            if WeatherKitData.HourlyForecastSymbol[indexPath.row] != "wind" {
                cell.weatherIcon.image = UIImage(systemName: "\(WeatherKitData.HourlyForecastSymbol[indexPath.row]).fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))?.withRenderingMode(.alwaysOriginal)
            } else {
                cell.weatherIcon.image = UIImage(systemName: "\(WeatherKitData.HourlyForecastSymbol[indexPath.row])", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32.0))?.withRenderingMode(.alwaysOriginal)
            }
        } else { cell.weatherIcon.image = UIImage(systemName: "questionmark")}
        
        if WeatherKitData.HourlyForecast.count > 6 {
            cell.tempLabel.text = "\(Int((round(WeatherKitData.HourlyForecast[indexPath.row])*100)/100))˚"
        } else { cell.tempLabel.text = "--" }
        
        if timeArray.formattedHours.count > 6 {
            cell.timeLabel.text = "\(timeArray.formattedHours[indexPath.row])"
        } else { cell.timeLabel.text = "--"}
        
        return cell
    }
}

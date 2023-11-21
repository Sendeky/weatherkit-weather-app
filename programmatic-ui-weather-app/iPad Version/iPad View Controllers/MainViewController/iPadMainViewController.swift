//
//  iPadMainViewController.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 10/31/23.
//

import Foundation
import UIKit

class iPadMainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    // Contents will be components
    
    // MARK: Top Current Stack Component
    let customView = iPadMainTopCurrentStack()
    let humidityView = iPadHumidityStack()
    let rocketView = UIImageView()
    let sunsetView = UIStackView()
    let UVView = UIStackView()
    let windView = UIStackView()
    let precipitationView = UIStackView()
    let pressureView = UIStackView()
    //Creates view for cloud at top
    let cloudViewHolder = UIView()
    
    // collection view for hourly forecast
    let hourlyForecastView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())      // need to have frame and layout for UICollectionView
    
    // collection view for daily forecast
    let dailyForecastView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    // cyanColor for views in mainview
    let cyanColor = UIColor(red: 95.0/255.0, green: 195.0/255.0, blue: 255.0/255.0, alpha: 0.93)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets SVG background
        setBackground()
        setupRocketView()
        // create sunsetView
        createSunsetView()
        // create UVView
        createUVView()
        // create precipitationView
        createPrecipitationView()
        // create windView
        createWindView()
        // create pressureView
        createPressureView()
        // sets up the UI
        setupUI()
        // configure the hourly forecast view
        configureCollectionView()
    }
    
    // sets up the RocketView to the right
    private func setupRocketView() {
        //rocketView settings
        let rocketTapGesture = UITapGestureRecognizer(target: self, action: #selector(launchRocket))
        rocketTapGesture.isEnabled = true
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
    }
    
    private func setupUI() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        humidityView.translatesAutoresizingMaskIntoConstraints = false
        rocketView.translatesAutoresizingMaskIntoConstraints = false
        hourlyForecastView.translatesAutoresizingMaskIntoConstraints = false
        dailyForecastView.translatesAutoresizingMaskIntoConstraints = false
        
        humidityView.backgroundColor = cyanColor
        humidityView.layer.cornerRadius = 15
        view.backgroundColor = .orange
        view.addSubview(customView)
        view.addSubview(humidityView)
        view.addSubview(rocketView)
        view.addSubview(hourlyForecastView)
        view.addSubview(dailyForecastView)
        view.addSubview(sunsetView)
        view.addSubview(UVView)
        view.addSubview(precipitationView)
        view.addSubview(windView)
        
        
        // activates constraints
        NSLayoutConstraint.activate([
            //customView constraints
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.heightAnchor.constraint(equalToConstant: 100),
//            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //topStack constraints
            customView.topStack.topAnchor.constraint(equalTo: customView.topAnchor, constant: 20),
            customView.topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customView.topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 250),
            //humidityView constraints
            humidityView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 15),
            humidityView.heightAnchor.constraint(equalToConstant: 100),
            humidityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 250),
            humidityView.widthAnchor.constraint(equalToConstant: 150),
            //rocketView constraints
            rocketView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rocketView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            rocketView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rocketView.trailingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 250),
            // hourly forecast view constraints
            hourlyForecastView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 15),
            hourlyForecastView.leadingAnchor.constraint(equalTo: humidityView.trailingAnchor, constant: 15),
            hourlyForecastView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hourlyForecastView.heightAnchor.constraint(equalToConstant: 100),
            // daily forecast view constraints
            dailyForecastView.topAnchor.constraint(equalTo: hourlyForecastView.bottomAnchor, constant: 15),
            dailyForecastView.leadingAnchor.constraint(equalTo: hourlyForecastView.leadingAnchor),
            dailyForecastView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyForecastView.bottomAnchor.constraint(equalTo: precipitationView.bottomAnchor),
//            dailyForecastView.heightAnchor.constraint(equalToConstant: 200),
            // sunsetView constraints
            sunsetView.topAnchor.constraint(equalTo: humidityView.bottomAnchor, constant: 15),
            sunsetView.leadingAnchor.constraint(equalTo: humidityView.leadingAnchor),
            sunsetView.trailingAnchor.constraint(equalTo: humidityView.trailingAnchor),
            sunsetView.heightAnchor.constraint(equalToConstant: 100),
            // UVView constraints
//            UVView.topAnchor.constraint(equalTo: hourlyForecastView.bottomAnchor, constant: 15),
//            UVView.leadingAnchor.constraint(equalTo: hourlyForecastView.leadingAnchor),
//            UVView.widthAnchor.constraint(equalToConstant: 100),
//            UVView.heightAnchor.constraint(equalToConstant: 120),
            // precipitationView constraints
            precipitationView.topAnchor.constraint(equalTo: sunsetView.bottomAnchor, constant: 15),
            precipitationView.leadingAnchor.constraint(equalTo: sunsetView.leadingAnchor),
            precipitationView.trailingAnchor.constraint(equalTo: sunsetView.trailingAnchor),
            precipitationView.heightAnchor.constraint(equalToConstant: 100),
            // windView constraints
            windView.topAnchor.constraint(equalTo: dailyForecastView.bottomAnchor, constant: 15),
            windView.leadingAnchor.constraint(equalTo: precipitationView.leadingAnchor),
            windView.widthAnchor.constraint(equalToConstant: 150),
            windView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    
    func setBackground() {
        //Creates cloud at top of the screen
        cloudViewHolder.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 4)
        let cloud = UIImage(named: "Cloud.svg")
        let cloudView : UIImageView!
        cloudView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 4))
        cloudView.contentMode =  .scaleAspectFit
        cloudView.layer.opacity = 0.6
        cloudView.clipsToBounds = true
        cloudView.image = cloud
        cloudView.center = view.center
        cloudView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 4)
        cloudViewHolder.addSubview(cloudView)
        view.sendSubviewToBack(cloudViewHolder)

        
        let background = UIImage(named: "Background.svg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        
        // add subview here so that layout anchors have view to constrain to
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view.topAnchor, multiplier: 1.05),
            imageView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 1.05),
            imageView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: -1.05),
            imageView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1.05)
        ])
        view.sendSubviewToBack(imageView)
        
        // horizontal parallax effects
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -20
        horizontalMotionEffect.maximumRelativeValue = 20
        
        // vertical parallax effects
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -20
        verticalMotionEffect.maximumRelativeValue = 20
        
        // adds horizontal and vertical to "motionEffectGroup" which is then added to imageview
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        imageView.addMotionEffect(motionEffectGroup)
    }
    
    private func createSunsetView() {
        sunsetView.translatesAutoresizingMaskIntoConstraints = false
        sunsetView.layer.cornerRadius = 15
        sunsetView.axis = .vertical
        sunsetView.backgroundColor = cyanColor
        sunsetView.isLayoutMarginsRelativeArrangement = true
        sunsetView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        
        
        let sunsetViewTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Sunset & Sunrise"
            label.textAlignment = .center
            return label
        }()
        let sunriseLabel: UILabel = {
            let label = UILabel()
            label.text = "Sunrise: --"
            label.textAlignment = .center
            return label
        }()
        let sunsetLabel: UILabel = {
            let label = UILabel()
            label.text = "Sunset: --"
            label.textAlignment = .center
            return label
        }()
        sunsetView.addArrangedSubview(sunsetViewTitleLabel)
        sunsetView.addArrangedSubview(sunriseLabel)
        sunsetView.addArrangedSubview(sunsetLabel)
    }
    
    //MARK: Hourly Forecast Collection View
    private func configureCollectionView() {
        hourlyForecastView.delegate = self
        hourlyForecastView.dataSource = self
        dailyForecastView.delegate = self
        dailyForecastView.dataSource = self
        
        // stylistic options for hourly view
        hourlyForecastView.layer.cornerRadius = 15
        hourlyForecastView.backgroundColor = cyanColor
        hourlyForecastView.showsHorizontalScrollIndicator = false
        
        // stylistic options for daily view
        dailyForecastView.layer.cornerRadius = 15
        dailyForecastView.backgroundColor = cyanColor
        dailyForecastView.showsVerticalScrollIndicator = false
            
        // Register your custom cell class
        hourlyForecastView.register(CustomCell.self, forCellWithReuseIdentifier: "CustomCell")
        // Set the collection view's layout to horizontal scroll
        if let layout2 = hourlyForecastView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout2.scrollDirection = .horizontal
        }
        
        dailyForecastView.register(iPadDailyCollectionViewCell.self, forCellWithReuseIdentifier: "iPadDailyCollectionViewCell")
        if let layout3 = dailyForecastView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout3.scrollDirection = .vertical
        }
    }
    
    // number of hourly cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // if hourlyForecastView, then we have 16 cells, otherwise 10
        if collectionView == self.hourlyForecastView {
            return 16
        }
        else { return 10 }
    }
        
    // populates hourly cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // use hourly cell if hourlyForecastView
        if collectionView == self.hourlyForecastView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
            
            cell.weatherIcon.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal)
            cell.timeLabel.text = "PM"
            cell.tempLabel.text = "--"
            
            return cell
        }
        // else use daily cell (for dailyForecastView)
        else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "iPadDailyCollectionViewCell", for: indexPath) as! iPadDailyCollectionViewCell
            
            cell2.weatherIcon.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal)
            cell2.timeLabel.text = "SATURDAY"
            cell2.tempLabel.text = "----"
            
            return cell2
        }
    }
}

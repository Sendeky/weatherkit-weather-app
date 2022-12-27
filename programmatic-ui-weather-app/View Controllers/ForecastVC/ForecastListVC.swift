//
//  ForecastVC.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 11/19/22.
//

import UIKit

class ForecastListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var forecastTableView = UITableView()
    var forecasts: [Forecasts] = []
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        forecastTableView.backgroundColor = .clear
        makeForecasts()
        configureTableView()
        setBackground()
        forecastTableView.reloadData()
    }
    
    func makeForecasts(){
        forecasts = makeForecastCells()
    }
    
    func configureTableView() {
        view.addSubview(forecastTableView)
        forecastTableView.addSubview(refreshControl)
        
        //refreshControl settings
        refreshControl.attributedTitle = NSAttributedString("Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        setTableViewDelegates()
        //cell row height
        forecastTableView.rowHeight = 100
        //register cells
        forecastTableView.register(ForecastsCell.self, forCellReuseIdentifier: "forecastsCell")
        //set constraints
        forecastTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forecastTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),        //top constraint set to top safe margin
            forecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forecastTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: "forecastsCell") as! ForecastsCell       //Casts as SettingsCell because we want the funcs inside
//        cell.alpha = 0.5
        cell.backgroundColor = .clear
        
        let forecast = forecasts[indexPath.row]           //indexPath will have 3
        cell.set(forecasts: forecast)
        
        return cell
    }
    
    func setTableViewDelegates() {
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
    }
    
//    private func setGradientBackground() {
//        let colorTop =  UIColor(red: 0/255.0, green: 235.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 100.0/255.0, green: 50.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.frame = self.view.bounds
//
//        self.view.layer.insertSublayer(gradientLayer, at:0)
//    }
    
    private func setBackground() {

        /*
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
         */
        
        
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
    
    @objc func refresh() {
        makeForecasts()
        configureTableView()
//        setGradientBackground()
        forecastTableView.reloadData()
        refreshControl.endRefreshing()
    }
}

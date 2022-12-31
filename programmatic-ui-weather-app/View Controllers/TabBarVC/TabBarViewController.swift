//
//  TabBarViewController.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 11/11/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Create instance of view controllers
        let mainVC = MainViewController()
        let forecastVC = ForecastListVC()
//        let settingsVC = SettingsListVC()
        
        //Set title
        mainVC.title = "Current"
        forecastVC.title = "Forecast"
//        settingsVC.title = "Settings"
        
        //Assign controllers to tab bar
        self.setViewControllers([mainVC, forecastVC], animated: false)
//        tabBar.backgroundColor = UIColor(red: 100.0/255.0, green: 50.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        tabBar.isOpaque = true
        tabBar.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tabBar.bounds
        blurEffectView.clipsToBounds = true
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.addSubview(blurEffectView)
        
        //Array of TabBar icons
        guard let items = self.tabBar.items else { return }
        let images = ["cloud.sun.rain.fill", "chart.bar.xaxis"]
        
        for x in 0...1 {
            items[x].image = UIImage(systemName: images[x])
        }

    }
}


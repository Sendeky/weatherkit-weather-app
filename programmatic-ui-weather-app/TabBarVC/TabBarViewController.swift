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
        let forecastVC = ForecastVC()
        let settingsVC = SettingsViewController()
        
        //Set title
        mainVC.title = "Current"
        forecastVC.title = "Forecast"
        settingsVC.title = "Settings"
        
        //Assign controllers to tab bar
        self.setViewControllers([mainVC, forecastVC, settingsVC], animated: false)
        tabBar.backgroundColor = UIColor(red: 100.0/255.0, green: 50.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        tabBar.alpha = 0.8
        
        //Array of TabBar icons
        guard let items = self.tabBar.items else { return }
        let images = ["cloud.sun.rain", "chart.bar.xaxis", "gear.circle"]
        
        for x in 0...2 {
            items[x].image = UIImage(systemName: images[x])
        }

    }
}
class ForecastVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
}


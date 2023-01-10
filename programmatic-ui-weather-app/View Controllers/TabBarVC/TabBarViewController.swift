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

        var swipeGetsure = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeGetsure.numberOfTouchesRequired = 1
        swipeGetsure.direction = .right
        view.addGestureRecognizer(swipeGetsure)
        
        swipeGetsure = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeGetsure.numberOfTouchesRequired = 1
        swipeGetsure.direction = .left
        view.addGestureRecognizer(swipeGetsure)
        
        
        //Create instance of view controllers
        let mainVC = MainViewController()
        let forecastVC = ForecastListVC()
        let infoVC = InfoVC()
        
        //Set title
        mainVC.title = "Current"
        forecastVC.title = "Forecast"
        infoVC.title = "Info"
        
        //Assign controllers to tab bar
        self.setViewControllers([mainVC, forecastVC, infoVC], animated: false)
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
        let images = ["cloud.sun.rain.fill", "chart.bar.xaxis", "info.circle"]
        
        for x in 0...2 { items[x].image = UIImage(systemName: images[x]) }
    }
    
    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if (self.selectedIndex) < 2 { // set your total tabs here
                self.selectedIndex += 1
            }
        } else if gesture.direction == .right {
            if (self.selectedIndex) > 0 {
                self.selectedIndex -= 1
            }
        }
    }
}


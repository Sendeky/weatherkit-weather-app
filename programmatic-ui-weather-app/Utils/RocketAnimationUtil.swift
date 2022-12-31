//
//  RocketAnimationUtil.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/28/22.
//

import Foundation
import UIKit


extension MainViewController {
    @objc func AnimateRocket() {
        //Animate rocket
        print("AnimateRocket called")
        view.backgroundColor = UIColor(red: 50.0/225.0, green: 40.0/255.0, blue: 105.0/255.0, alpha: 1.0)
//        view.backgroundColor = .black
        rocketText.text = "Rocket Ready!"
        for gesture in rocketView.gestureRecognizers! {
            gesture.isEnabled = true
        }
    }
}

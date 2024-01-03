//
//  LaunchRocket.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/4/23.
//
import UIKit
import Foundation


extension iPadMainViewController {
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
}

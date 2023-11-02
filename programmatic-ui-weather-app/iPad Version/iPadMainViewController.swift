//
//  iPadMainViewController.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 10/31/23.
//

import Foundation
import UIKit

class iPadMainViewController: UIViewController {
    // Contents will be components
    
    // MARK: Top Current Stack Component
    let customView = iPadMainTopCurrentStack()
    let rocketView = RocketView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets SVG background
        setBackground()
        // sets up the UI
        setupUI()
    }
    
    private func setupUI() {
        rocketView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.addSubview(customView)
        view.addSubview(rocketView)
        
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.topStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            customView.topStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customView.topStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 250),
            rocketView.topAnchor.constraint(equalTo: view.topAnchor),
            rocketView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rocketView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            rocketView.widthAnchor.constraint(equalToConstant: 10)
            rocketView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    private func setBackground() {
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
            imageView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: -1.0),
            imageView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1.05)
        ])
        view.sendSubviewToBack(imageView)
    }

}

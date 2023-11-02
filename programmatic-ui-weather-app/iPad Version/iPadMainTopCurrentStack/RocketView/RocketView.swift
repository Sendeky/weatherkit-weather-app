//
//  RocketView.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/1/23.
//

import UIKit


class RocketView: UIView {

    let rocketView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Falcon-Heavy.svg")
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 15.0
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowOffset = CGSize(width: -4, height: 4)
        imageView.layer.masksToBounds = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(rocketView)

        let rocketTapGesture = UITapGestureRecognizer(target: self, action: #selector(launchRocket))
        rocketTapGesture.isEnabled = false
        rocketView.addGestureRecognizer(rocketTapGesture)

        // Set constraints for rocketView here.
        // Example: rocketView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func launchRocket() {
        print("Rocket Launched")
    }
}


//class RocketView: UIView {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//    let rocketView: UIView = {
//        // creates rocketView UIView variable
//        let rocketView = UIImageView()
//
//        //rocketView settings
////        let rocketTapGesture = UITapGestureRecognizer(target: RocketView.self, action: #selector(launchRocket))
////        rocketTapGesture.isEnabled = false
//        rocketView.translatesAutoresizingMaskIntoConstraints = false
//        rocketView.contentMode = .scaleAspectFit
//        rocketView.clipsToBounds = true
//        rocketView.image = UIImage(named: "Falcon-Heavy.svg")
//        rocketView.layer.shadowColor = UIColor.black.cgColor
//        rocketView.layer.shadowRadius = 15.0
//        rocketView.layer.shadowOpacity = 0.7
//        rocketView.layer.shadowOffset = CGSize(width: -4, height: 4)
//        rocketView.layer.masksToBounds = false
//        rocketView.isUserInteractionEnabled = true
////        rocketView.addGestureRecognizer(rocketTapGesture)
//    }()
//
//    func setUpRocketView() -> UIView() {
//        let rocketView = rocketView()
//
//        let rocketTapGesture = UITapGestureRecognizer(target: RocketView.self, action: #selector(launchRocket))
//        rocketTapGesture.isEnabled = false
//        rocketView.addGestureRecognizer(rocketTapGesture)
//
//
//        // func for launching rocket
//        @objc func launchRocket() {
//            print("Rocket Launched")
//        }
//
//        return rocketView
//    }
//
//}

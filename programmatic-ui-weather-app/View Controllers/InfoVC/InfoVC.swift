//
//  InfoVC.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 1/2/23.
//

import UIKit

class InfoVC: UIViewController, UITextViewDelegate {
    
    let topLabel = UILabel()
    let sourcesStackView = UIStackView()
    
    let appleWeatherLabel = UILabel()
    let otherSourcesLabel = UITextView()
    
    let fontGetLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .orange
        
        otherSourcesLabel.delegate = self
        setBackground()
        
        style()
        layout()
    }
    
    func style() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.text = "Attribution"
        topLabel.font = .preferredFont(forTextStyle: .largeTitle)
        
        sourcesStackView.translatesAutoresizingMaskIntoConstraints = false
        sourcesStackView.axis = .vertical
        sourcesStackView.spacing = 20
        
        appleWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        appleWeatherLabel.text = " Weather (Apple Weather)"
        appleWeatherLabel.font = .preferredFont(forTextStyle: .title2)
        
//        otherSourcesLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: "Weatherkit - Data Sources")
        attributedString.addAttribute(.link, value: "https://weatherkit.apple.com/legal-attribution.html", range: NSRange(location: 0, length: 25))
        otherSourcesLabel.attributedText = attributedString
        otherSourcesLabel.frame = CGRect(x: view.bounds.minX + 18, y: 200, width: view.bounds.width, height: 100)
        otherSourcesLabel.font = .preferredFont(forTextStyle: .title3)
        otherSourcesLabel.textAlignment = .left
        otherSourcesLabel.isEditable = false
        otherSourcesLabel.backgroundColor = .clear
        
        // fontGetLabel (SpaceX Font is from FontGet)
        fontGetLabel.translatesAutoresizingMaskIntoConstraints = false
        fontGetLabel.text = "Fonts from FontGet"
        fontGetLabel.font = .preferredFont(forTextStyle: .title2)
    }
    
    func layout() {
        view.addSubview(topLabel)
        view.addSubview(sourcesStackView)
        view.addSubview(appleWeatherLabel)
        view.addSubview(otherSourcesLabel)
        view.addSubview(fontGetLabel)
        
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
//            sourcesStackView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
//            sourcesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            sourcesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            appleWeatherLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10),
            appleWeatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            otherSourcesLabel.topAnchor.constraint(equalTo: appleWeatherLabel.bottomAnchor),
            otherSourcesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            otherSourcesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            fontGetLabel.topAnchor.constraint(equalTo: otherSourcesLabel.bottomAnchor),
            fontGetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fontGetLabel.leadingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    func setBackground() {
        
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
}

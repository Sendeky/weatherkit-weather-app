//
//  WindView.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 11/14/23.
//

import Foundation
import UIKit


class WindCompassView: UIView {
    private let windSpeed: Double
    private let windDirection: Double // in degrees
    
    init(frame: CGRect, windSpeed: Double, windDirection: Double) {
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        self.windSpeed = 0
        self.windDirection = 0
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) * 0.3
        
        // Draw circle
        context.setStrokeColor(UIColor.white.withAlphaComponent(0.3).cgColor)
        context.setLineWidth(1)
        context.addArc(center: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)
        context.strokePath()
        
        // Draw tick marks
        for i in 0..<360 {
            if i % 30 == 0 {
                let angle = CGFloat(i) * .pi / 180
                let startPoint = CGPoint(
                    x: center.x + (radius - 5) * cos(angle),
                    y: center.y + (radius - 5) * sin(angle)
                )
                let endPoint = CGPoint(
                    x: center.x + radius * cos(angle),
                    y: center.y + radius * sin(angle)
                )
                
                context.move(to: startPoint)
                context.addLine(to: endPoint)
                context.strokePath()
            }
        }
        
        let directions = ["N", "E", "S", "W"]
        let textMargin: CGFloat = 12  // Reduced from 20
        let positions = [
            CGPoint(x: center.x, y: center.y - radius - textMargin),
            CGPoint(x: center.x + radius + textMargin, y: center.y),
            CGPoint(x: center.x, y: center.y + radius + textMargin),
            CGPoint(x: center.x - radius - textMargin, y: center.y)
        ]
        // Adjust font size based on view size
        let fontSize = min(bounds.width, bounds.height) * 0.15  // Makes font size relative to view size
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: UIColor.white
        ]
        
        // Adjust text positioning to account for font size
        for (direction, position) in zip(directions, positions) {
            let textSize = (direction as NSString).size(withAttributes: attrs)
            let x = position.x - textSize.width / 2
            let y = position.y - textSize.height / 2
            (direction as NSString).draw(at: CGPoint(x: x, y: y), withAttributes: attrs)
        }
        
        // Adjust center text size
        let speedText = "\(Int(windSpeed))\nmph"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let centerFontSize = min(bounds.width, bounds.height) * 0.2  // Makes center text size relative to view size
        let centerAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: centerFontSize, weight: .medium),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]
        
        let textRect = CGRect(x: center.x - radius/2, y: center.y - radius/4,
                              width: radius, height: radius/2)
        (speedText as NSString).draw(in: textRect, withAttributes: centerAttrs)
        
        // Draw arrow
        context.saveGState()
        context.translateBy(x: center.x, y: center.y)
        context.rotate(by: CGFloat(windDirection) * .pi / 180)
        
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(2)
        
        // Arrow body
        //        context.move(to: CGPoint(x: -radius + 10, y: 0))
        //        context.addLine(to: CGPoint(x: radius - 10, y: 0))
        context.strokePath()
        
        // Instead of CGPath(polygonIn:), we'll draw the arrow head manually
        // Arrow head
        let arrowHeadLength: CGFloat = 16
        let arrowHeadWidth: CGFloat = 8
        
        context.move(to: CGPoint(x: radius - 10, y: 0))
        context.addLine(to: CGPoint(x: radius - 10 - arrowHeadLength, y: -arrowHeadWidth))
        context.addLine(to: CGPoint(x: radius - 10 - arrowHeadLength, y: arrowHeadWidth))
        context.closePath()
        context.fillPath()
        
        context.restoreGState()
    }
}


class iPadWindView: UIView {
    // MARK: - Properties
    private let windStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.cornerRadius = 15
        stack.axis = .vertical
        stack.backgroundColor = cyanColor
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stack.spacing = 20
        return stack
    }()
    
    private let WindViewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wind"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private let WindSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // create compass view
    private var compassView: WindCompassView!
    
    // MARK: - Setup
    private func setupUI() {
        // Setup compass view
        compassView = WindCompassView(frame: .zero,
                                      windSpeed: Double(WeatherKitData.WindSpeed) ?? 0,
                                      windDirection: (WeatherKitData.WindDirectionAngle - 90))      // true north is measured at 0 degrees, graphic starts at 90 though
        compassView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add labels to stack
        windStackView.addArrangedSubview(WindViewTitleLabel)
        
        // Create a container view for the compass to control its size
        let compassContainer = UIView()
        compassContainer.translatesAutoresizingMaskIntoConstraints = false
        compassContainer.addSubview(compassView)
        
        // Add compass container to stack
        windStackView.addArrangedSubview(compassContainer)
        //        windStackView.addArrangedSubview(WindSpeedLabel)
        //        windStackView.addArrangedSubview(compassView)
        
        // Add stack to view
        addSubview(windStackView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            windStackView.topAnchor.constraint(equalTo: topAnchor),
            windStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            windStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            windStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            // Compass container constraints
            compassContainer.heightAnchor.constraint(equalToConstant: 150), // Adjust this value
            
            // Compass view constraints
            compassView.centerXAnchor.constraint(equalTo: compassContainer.centerXAnchor),
            compassView.centerYAnchor.constraint(equalTo: compassContainer.centerYAnchor),
            compassView.widthAnchor.constraint(equalToConstant: 120),  // Adjust this value
            compassView.heightAnchor.constraint(equalToConstant: 120)  // Adjust this value
        ])
        
        updateWindLabel(WeatherKitData.WindSpeed)
    }
    
    // MARK: - Public Methods
    func updateWindLabel(_ value: String) {
        WindSpeedLabel.text = "\(value)"
    }
}

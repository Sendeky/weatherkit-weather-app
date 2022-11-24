//
//  SettingsCell.swift
//  programmatic-uitableview
//
//  Created by RuslanS on 11/19/22.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    var cellImageView = UIImageView()
    var cellTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellImageView)
        addSubview(cellTitleLabel)
        
        configureImageView()
        configureTitleLabel()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(settings: Settings) {
        cellImageView.image = settings.image
        cellTitleLabel.text = settings.title
    }
    
    func configureImageView() {
        cellImageView.layer.cornerRadius = 10
        cellImageView.clipsToBounds = true
    }
    
    func configureTitleLabel() {
        cellTitleLabel.numberOfLines = 0
        cellTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func layout() {
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cellImageView.heightAnchor.constraint(equalToConstant: 80),
            cellImageView.widthAnchor.constraint(equalToConstant: 80),
            
            cellTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellTitleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 20),
            cellTitleLabel.heightAnchor.constraint(equalToConstant: 80),
            cellTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])

    }
}

extension SettingsListVC {
    
    func makeSettingsCells() -> [Settings] {
        let settings1 = Settings(image: UIImage(systemName: "bell.circle.fill", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.white, .red]))!, title: "Notifications")
        let settings2 = Settings(image: UIImage(systemName: "thermometer.sun.circle.fill", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.white, .orange]))!, title: "Metric Units")
        let settings3 = Settings(image: UIImage(systemName: "map.circle.fill", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.white, .systemMint]))!, title: "Earthquake Map")
        let settings4 = Settings(image: UIImage(systemName: "clock.circle.fill", withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.white, .systemYellow]))!, title: "Alarm")
        
        return [settings1, settings2, settings3, settings4]
    }
    
}

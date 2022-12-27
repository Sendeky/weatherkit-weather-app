//
//  VideoListVC.swift
//  programmatic-uitableview
//
//  Created by RuslanS on 11/19/22.
//

import UIKit

class SettingsListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tableView = UITableView()
    var settings: [Settings] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        title = "Settings"
        settings = makeSettingsCells()
        configureTableView()
//        setGradientBackground()
        setBackground()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        setTableViewDelegates()
        //cell row height
        tableView.rowHeight = 100
        //register cells
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "settingsCell")
        //set constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),      //top constraint set to top safe margin
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    //which cell was clicked
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as! SettingsCell       //Casts as SettingsCell because we want the funcs inside SettingsCell
        
        //adds switch to cell
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        cell.backgroundColor = .clear
        
        let setting = settings[indexPath.row]           //indexPath will have 3
        cell.set(settings: setting)
        
        return cell
    }
    
    @objc func switchChanged(_ sender : UISwitch!){

        switch sender.tag {
        case 0:
            if sender.isOn == true {
                print("sender.tag = 0 and sender is ON")
            } else if sender.isOn == false {
                print("sender.tag = 0 and sender is OFF")
            }
        case 1:
            if sender.isOn == true {
                print("sender.tag = 1 and sender is ON")
                //metric Units func
                UserDefaults.standard.set(true, forKey: "METRIC_UNITS")             //True value is set for "METRIC_UNITS" UserDefault key
                print(UserDefaults.standard.bool(forKey: "METRIC_UNITS"))
            } else if sender.isOn == false {
                print("sender.tag = 1 and sender is OFF")
                UserDefaults.standard.set(false, forKey: "METRIC_UNITS")             //False value is set for "METRIC_UNITS" UserDefault key
                print(UserDefaults.standard.bool(forKey: "METRIC_UNITS"))
            }
        case 2:
            if sender.isOn == true {
                print("sender.tag = 2 and sender is ON")
            } else if sender.isOn == false {
                print("sender.tag = 2 and sender is OFF")
            }
        default:
            print("test")
        }
    }
    
    
    func setTableViewDelegates() {
        tableView.delegate = self       //signs up videoListVC to be delegate and datasource
        tableView.dataSource = self
    }
    
    private func setBackground() {
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

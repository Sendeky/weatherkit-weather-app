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
        setGradientBackground()
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
    
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 0/255.0, green: 235.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 100.0/255.0, green: 50.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

}

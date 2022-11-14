//
//  SunriseSunsetPopUpVC.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 11/12/22.
//

import UIKit
import Charts

class SunriseSunsetPopUpVC: UIViewController, ChartViewDelegate {
    
    //Creates topTitleLabel & settings
    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunrise & Sunset"
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    let topSunriseSunsetTimeStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.layer.cornerRadius = 30
        stackview.backgroundColor = .systemBlue
        return stackview
    }()
    //Sunrise & sunset time labels in Stackview
    let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunrise: \(WeatherKitData.localSunrise)"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunset: \(WeatherKitData.localSunset)"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    //Creates Chart
    lazy var sunTimeChartView: LineChartView = {
        let chartView = LineChartView()
        
        chartView.backgroundColor = .systemBlue
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.isUserInteractionEnabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.drawTopYLabelEntryEnabled = false
        yAxis.labelPosition = .outsideChart
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom

        return chartView
    }()
    
    //Creates stackview for bottom 3 labels
    let bottomTimeStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 15
        return stackview
    }()
    
    //solarNoonView & label
    let solarNoonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemBlue
        return view
    }()
    let solarNoonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Solar Noon: \(WeatherKitData.SolarNoon)"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    //astronomicalDawnView and label
    let astronomicalDawnView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemBlue
        return view
    }()
    let astronomicalDawnLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Astronomical Dawn: \(WeatherKitData.AstronomicalDawn)"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    //astronomicalDuskView and label
    let astronomicalDuskView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemBlue
        return view
    }()
    let astronomicalDuskLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Astronomical Dusk: \(WeatherKitData.AstronomicalDusk)"
    label.font = .preferredFont(forTextStyle: .title3)
    return label
}()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemCyan
        view.alpha = 0.9
        layout()
        setData()

        DateConverter().convertDateToEpoch()
    }
  
    //MARK: TODO
//    override func viewWillAppear(_ animated: Bool) {
//        layout()
//    }
    
    
    func layout() {
        //Adds stackviews and topLabel to view
        view.addSubview(topTitleLabel)
        view.addSubview(topSunriseSunsetTimeStackview)
        view.addSubview(bottomTimeStackview)
        
        //Adds label and chart to topSunriseSunsetTimeStackview
        topSunriseSunsetTimeStackview.addSubview(sunriseTimeLabel)
        topSunriseSunsetTimeStackview.addSubview(sunsetTimeLabel)
        topSunriseSunsetTimeStackview.addSubview(sunTimeChartView)
        
        //Adds label to solarNoonView
        solarNoonView.addSubview(solarNoonLabel)
        
        //Adds label to astronomicalDawnView
        astronomicalDawnView.addSubview(astronomicalDawnLabel)
        
        //Adds label to astronomicalDuskView
        astronomicalDuskView.addSubview(astronomicalDuskLabel)
        
        //Adds bottom views to bottomTimeStackview
        bottomTimeStackview.addArrangedSubview(solarNoonView)
        bottomTimeStackview.addArrangedSubview(astronomicalDawnView)
        bottomTimeStackview.addArrangedSubview(astronomicalDuskView)
        
        NSLayoutConstraint.activate([
            //topTitleLabel constraints
            topTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            topTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //topSunriseSunsetTimeStackview constraints
            topSunriseSunsetTimeStackview.topAnchor.constraint(equalTo: topTitleLabel.bottomAnchor, constant: 50),
            topSunriseSunsetTimeStackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topSunriseSunsetTimeStackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            topSunriseSunsetTimeStackview.heightAnchor.constraint(equalToConstant: 300),
            //sunriseTimeLabel constraints
            sunriseTimeLabel.leadingAnchor.constraint(equalTo: topSunriseSunsetTimeStackview.leadingAnchor, constant: 10),
            sunriseTimeLabel.topAnchor.constraint(equalTo: topSunriseSunsetTimeStackview.topAnchor, constant: 15),
            //sunsetTimeLabel constraints
            sunsetTimeLabel.trailingAnchor.constraint(equalTo: topSunriseSunsetTimeStackview.trailingAnchor, constant: -10),
            sunsetTimeLabel.topAnchor.constraint(equalTo: topSunriseSunsetTimeStackview.topAnchor, constant: 15),
            //sunTimeChartView constraints
            sunTimeChartView.topAnchor.constraint(equalTo: sunriseTimeLabel.bottomAnchor, constant: 15),
            sunTimeChartView.leadingAnchor.constraint(equalTo: sunriseTimeLabel.leadingAnchor),
            sunTimeChartView.trailingAnchor.constraint(equalTo: sunsetTimeLabel.trailingAnchor),
            sunTimeChartView.heightAnchor.constraint(equalToConstant: 200),
            //bottomTimeStackview constraints
            bottomTimeStackview.topAnchor.constraint(equalTo: topSunriseSunsetTimeStackview.bottomAnchor, constant: 20),
            bottomTimeStackview.leadingAnchor.constraint(equalTo: topSunriseSunsetTimeStackview.leadingAnchor),
            bottomTimeStackview.trailingAnchor.constraint(equalTo: topSunriseSunsetTimeStackview.trailingAnchor),
            //solarNoonView constraints
            solarNoonView.heightAnchor.constraint(equalToConstant: 40),
            //solarNoonLabel constraints
            solarNoonLabel.centerYAnchor.constraint(equalTo: solarNoonView.centerYAnchor),
            solarNoonLabel.leadingAnchor.constraint(equalTo: solarNoonView.leadingAnchor, constant: 15),
            //astronomicalDawnView constraints
            astronomicalDawnView.heightAnchor.constraint(equalToConstant: 40),
            //astronomicalDawnLabel constraints
            astronomicalDawnLabel.centerYAnchor.constraint(equalTo: astronomicalDawnView.centerYAnchor),
            astronomicalDawnLabel.leadingAnchor.constraint(equalTo: astronomicalDawnView.leadingAnchor, constant: 15),
            //astronomicalDuskView constraints
            astronomicalDuskView.heightAnchor.constraint(equalToConstant: 40),
            //astronomicalDuskLabel constraints
            astronomicalDuskLabel.centerYAnchor.constraint(equalTo: astronomicalDuskView.centerYAnchor),
            astronomicalDuskLabel.leadingAnchor.constraint(equalTo: astronomicalDuskView.leadingAnchor, constant: 15),
            
            
        ])
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: yValues, label: "")
        
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier
        set1.setColor(.white)
        set1.drawFilledEnabled = true
        set1.drawCirclesEnabled = true
        
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
        let set2 = LineChartDataSet(entries: yValues2, label: "Daylight")
        set2.drawCirclesEnabled = false
        set2.lineCapType = .round
        set2.lineWidth = 2.0
        set2.drawValuesEnabled = false
        set2.setColor(.systemYellow)
                                    
        let data = LineChartData(dataSets: [set1, set2])
        sunTimeChartView.data = data
    }
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 0.5),
        ChartDataEntry(x: Double(sunEventHour.sunriseHour), y: 1.0),
        ChartDataEntry(x: Double(sunEventHour.sunsetHour - sunEventHour.sunriseHour), y: 2.0),
        ChartDataEntry(x: Double(sunEventHour.sunsetHour), y: 1.0),
        ChartDataEntry(x: 24.0, y: 0.5),
    ]
                                    
    let yValues2: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 1.0),
        ChartDataEntry(x: 24.0, y: 1.0),
    ]
}

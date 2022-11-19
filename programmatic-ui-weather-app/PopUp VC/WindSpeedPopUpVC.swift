//
//  WindSpeedPopUpVC.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 11/13/22.
//

import UIKit
import Charts

class WindSpeedPopUpVC: UIViewController {
    
    //Creates titleLabel
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wind"
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    //Creates windSpeedStackview
    let windSpeedStackview: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.backgroundColor = .systemBlue
        view.axis = .vertical
        return view
    }()
    
    //Creates windSpeedChart & title
    let windSpeedChart: LineChartView = {
        let chartView = LineChartView()
        
        chartView.backgroundColor = .systemBlue
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.isUserInteractionEnabled = true
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.drawTopYLabelEntryEnabled = false
        yAxis.labelPosition = .outsideChart
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        
        return chartView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        view.alpha = 0.9
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .systemCyan
        view.alpha = 0.9
        
        if WeatherKitData.WindSpeedForecast.count > 11{
            print(".count > 10")
            let yValues: [ChartDataEntry] = [
                ChartDataEntry(x: 1.0, y: WeatherKitData.WindSpeedForecast[1]),
                ChartDataEntry(x: 2.0, y: WeatherKitData.WindSpeedForecast[2]),
                ChartDataEntry(x: 3.0, y: WeatherKitData.WindSpeedForecast[3]),
                ChartDataEntry(x: 4.0, y: WeatherKitData.WindSpeedForecast[4]),
                ChartDataEntry(x: 5.0, y: WeatherKitData.WindSpeedForecast[5]),
                ChartDataEntry(x: 6.0, y: WeatherKitData.WindSpeedForecast[6]),
                ChartDataEntry(x: 7.0, y: WeatherKitData.WindSpeedForecast[7]),
                ChartDataEntry(x: 8.0, y: WeatherKitData.WindSpeedForecast[8]),
                ChartDataEntry(x: 9.0, y: WeatherKitData.WindSpeedForecast[9]),
                ChartDataEntry(x: 10.0, y: WeatherKitData.WindSpeedForecast[10]),
                ChartDataEntry(x: 11.0, y: WeatherKitData.WindSpeedForecast[11]),
            ]
            setData(entries: yValues)
            
        } else {
            print("not yet")
        }
        layout()
    }
    
    private func layout() {
        
        view.addSubview(titleLabel)
        view.addSubview(windSpeedStackview)
        
        windSpeedStackview.addSubview(windSpeedChart)
        
        //        windSpeedStackview.addArrangedSubview(windSpeedChart)
        
        NSLayoutConstraint.activate([
            //titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //windSpeedStackview
            windSpeedStackview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            windSpeedStackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            windSpeedStackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            windSpeedStackview.heightAnchor.constraint(equalToConstant: 300),
            //windSpeedChart
            windSpeedChart.topAnchor.constraint(equalTo: windSpeedStackview.topAnchor, constant: 20),
            windSpeedChart.leadingAnchor.constraint(equalTo: windSpeedStackview.leadingAnchor, constant: 10),
            windSpeedChart.trailingAnchor.constraint(equalTo: windSpeedStackview.trailingAnchor, constant: -10),
            windSpeedChart.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setData(entries: [ChartDataEntry]) {
        let set1 = LineChartDataSet(entries: entries, label: "")
        set1.drawCirclesEnabled = true
        set1.mode = .horizontalBezier
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSet: set1)
        windSpeedChart.data = data
    }
}

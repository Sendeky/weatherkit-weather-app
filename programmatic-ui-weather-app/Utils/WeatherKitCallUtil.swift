//
//  WeatherKitCallUtil.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 11/2/22.
//

import Foundation
import WeatherKit
import CoreLocation
import UIKit

struct WeatherKitData: Codable{
    //RAW values for other funcs
    static var SunriseDate = Date()
    static var SunsetDate = Date()
    
    
    //Normal, converted values
    static var Temp = ""
    static var TempMax = ""
    static var TempMaxForecast = [String]()
    static var TempMin = ""
    static var TempMinForecast = [String]()
    static var TempFeels = 0
    static var UV = 0
    static var WindSpeed = ""
    static var Symbol = ""
    static var forecastSymbol = [String]()
    static var Humidity = 0
    static var localSunrise = ""
    static var localSunset = ""
    static var SolarNoon = ""
    static var AstronomicalDawn = ""
    static var AstronomicalDusk = ""
    static var Pressure = ""
    static var RainChance = 0
    static var WindSpeedForecast = [0.0]
    static var HourlyForecast = [0.0]
}

let weatherService = WeatherService()

class WeatherKitCallUtil {
}

extension MainViewController {
    func getWeather(location: CLLocation) {
        Task{
            do {
                let result = try await weatherService.weather(for: location)
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.short
                dateFormatter.dateStyle = DateFormatter.Style.none
                dateFormatter.timeZone = .current
                
                let formatter = MeasurementFormatter()
                if UserDefaults.standard.bool(forKey: "METRIC_UNITS") == true{
                    formatter.locale = Locale.current
                    formatter.numberFormatter.maximumFractionDigits = 0
                    formatter.numberFormatter.roundingMode = .up
                    formatter.unitOptions = [.providedUnit]
                } else if UserDefaults.standard.bool(forKey: "METRIC_UNITS") == false {
                    formatter.locale = Locale.current
                    formatter.numberFormatter.maximumFractionDigits = 0
                    formatter.numberFormatter.roundingMode = .up
//                    formatter.unitOptions = .providedUnit
                }
                //Data from currentWeather
                print(result.currentWeather.temperature.converted(to: .fahrenheit))
                print(formatter.string(from: result.currentWeather.temperature.converted(to: .fahrenheit)))
                let temp = formatter.string(from: result.currentWeather.temperature)
                print("supposed to be fahrenheit:\(temp)")
                let uv = result.currentWeather.uvIndex.value
                let wind = formatter.string(from: result.currentWeather.wind.speed)
                let symbol = result.currentWeather.symbolName
                let humidity = Int(100 * result.currentWeather.humidity)
                let pressure = formatter.string(from: result.currentWeather.pressure)
                
                //Data from dailyForecast[0] (today)
                let tempMax = formatter.string(from: result.dailyForecast[0].highTemperature)
                let tempMin = formatter.string(from: result.dailyForecast[0].lowTemperature)
                let localSunrise = dateFormatter.string(from: result.dailyForecast.forecast[0].sun.sunrise!)
                let localSunset = dateFormatter.string(from: result.dailyForecast.forecast[0].sun.sunset!)
                let solarNoon = dateFormatter.string(from: result.dailyForecast.forecast[0].sun.solarNoon!)
                let astronomicalDawn = dateFormatter.string(from: result.dailyForecast[0].sun.astronomicalDawn!)
                let astronomicalDusk = dateFormatter.string(from: result.dailyForecast[0].sun.astronomicalDusk!)
                
                var rainChance = Int(100 * result.dailyForecast.forecast[0].precipitationChance)
                if rainChance < 15 {
                    rainChance = 0
                } else {}
                
                
                //For loop for the tempMax for 5 days
                for i in 0...9 {
//                    print(result.dailyForecast[i].highTemperature)
                    let maxTemp = result.dailyForecast[i].highTemperature
                    WeatherKitData.TempMaxForecast.append(formatter.string(from: maxTemp))        //Append is needed to append into array
                    print("TempMaxForecast: \(WeatherKitData.TempMaxForecast[i])")
                    let forecastSymbol = result.dailyForecast[i].symbolName
                    WeatherKitData.forecastSymbol.append(forecastSymbol)
                    print("forecastSymbol: \(WeatherKitData.forecastSymbol[i])")
                    let minTemp = result.dailyForecast[i].lowTemperature
                    WeatherKitData.TempMinForecast.append(formatter.string(from: minTemp))
                    print("TempMinForecast: \(WeatherKitData.TempMinForecast[i])")
//                    print("WEATHERKITDATA TempMax array: \(WeatherKitData.TempMaxForecast[i])")
                }
                
                //For loop for 12hour wind
                for i in 0...11 {
                    let formatter = MeasurementFormatter()
                    formatter.unitOptions = .temperatureWithoutUnit
                    let windSpeed = result.hourlyForecast.forecast[i].wind.speed
                    let wind = (round(windSpeed.value * 10)) / 10
                    print(wind)
                    WeatherKitData.WindSpeedForecast.append(wind)
                    print(WeatherKitData.WindSpeedForecast[i])
                }
                
                //For loop for 12 hour weather
                for i in  0...12 {
                    let forecast = result.hourlyForecast.forecast[i].temperature.value
                    WeatherKitData.HourlyForecast.append(forecast)
                    print("Hourly Forecast: \(WeatherKitData.HourlyForecast[i])")
                }
                
                print(temp)
                print(uv)
                print(symbol)
                print(rainChance)
                print(result.hourlyForecast.forecast[0].wind)
                if result.weatherAlerts!.count > 0 {
                    print("Weather Alert: \(result.weatherAlerts?[0].summary)")
                } else {
                    print("No alerts")
                }
                
                print(Double(WeatherKitData.WindSpeedForecast[1]))
                //Puts fetched data into WeatherKitData struct
                WeatherKitData.Temp = temp
                WeatherKitData.TempMax = tempMax
                WeatherKitData.TempMin = tempMin
                WeatherKitData.UV = uv
                WeatherKitData.WindSpeed = wind
                WeatherKitData.Symbol = symbol
                WeatherKitData.Humidity = humidity
                WeatherKitData.Symbol = symbol
                WeatherKitData.localSunrise = localSunrise
                WeatherKitData.localSunset = localSunset
                WeatherKitData.SolarNoon = solarNoon
                WeatherKitData.AstronomicalDawn = astronomicalDawn
                WeatherKitData.AstronomicalDusk = astronomicalDusk
                WeatherKitData.Pressure = pressure
                WeatherKitData.RainChance = rainChance
                

                WeatherKitData.SunriseDate = result.dailyForecast.forecast[0].sun.sunrise!
                WeatherKitData.SunsetDate = result.dailyForecast.forecast[0].sun.sunset!
                
                
                DateConverter().timeArrayMaker()    //Runs timeArrayMaker func for timeArray in widget
                //puts WidgetData struct into widget
                var widget = WidgetData(temp: temp, tempMax: tempMax, tempMin: tempMin, symbolName: symbol, hourlyForecast: WeatherKitData.HourlyForecast, forecastTimeArray: timeArray.date)
                let primaryData = PrimaryData(widgetData: widget)
                //Encodes data into AppGroup
                primaryData.encode()
                
                
            } catch {
                print(String(describing: error))
            }
            self.updateLabelsAfterAwait()
        }
    }
    @MainActor
    private func updateLabelsAfterAwait() {
        let main = MainViewController()
        main.topTempMaxLabel.text = (WeatherKitData.TempMax)
        main.topWeatherIconView.image = UIImage(systemName: "\(WeatherKitData.Symbol)", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64))
        main.sunriseTimeLabel.text = "Sunrise was at: \(WeatherKitData.localSunrise)"
        main.sunsetTimeLabel.text = "Sunset was at: \(WeatherKitData.localSunset)"
        
        
        ForecastListVC().forecastTableView.reloadData()
        print("updateLabelsAfterAwait run")
        getWeatherLabelUpdate()
        DateConverter().convertDateToEpoch()
    }
}



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

struct WeatherKitData{
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
    static var Humidity = 0
    static var localSunrise = ""
    static var localSunset = ""
    static var SolarNoon = ""
    static var AstronomicalDawn = ""
    static var AstronomicalDusk = ""
    static var Pressure = ""
    static var RainChance = 0
    static var WindSpeedForecast = [0.0]
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
                formatter.locale = Locale.current
                formatter.numberFormatter.maximumFractionDigits = 0
                formatter.numberFormatter.roundingMode = .up
                
                //Data from currentWeather
                let temp = formatter.string(from: result.currentWeather.temperature)
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
                    print(WeatherKitData.TempMaxForecast[i])
//                    print("WEATHERKITDATA TempMax array: \(WeatherKitData.TempMaxForecast[i])")
                }
                
                for i in 0...11 {
                    let formatter = MeasurementFormatter()
                    formatter.unitOptions = .temperatureWithoutUnit
                    let windSpeed = result.hourlyForecast.forecast[i].wind.speed
                    let wind = (round(windSpeed.value * 10)) / 10
                    print(wind)
                    WeatherKitData.WindSpeedForecast.append(wind)
                    print(WeatherKitData.WindSpeedForecast[i])
                }
                
                print(temp)
                print(uv)
                print(symbol)
                print(rainChance)
                print(result.hourlyForecast.forecast[0].wind)
                print(Double(WeatherKitData.WindSpeedForecast[1]))
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
        
        print("updateLabelsAfterAwait run")
        getWeatherLabelUpdate()
        DateConverter().convertDateToEpoch()
    }
}



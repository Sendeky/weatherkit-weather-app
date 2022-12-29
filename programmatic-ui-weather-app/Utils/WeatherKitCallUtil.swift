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
    static var Sunrise = Date()
    static var Sunset = Date()
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
                
                //fetches location
                UserLocation.userCLLocation?.fetchCityAndCountry(completion: { city, country, error in
                    guard let city = city, let country = country, error == nil else { return }
                    print(city + ", " + country)  // City, Country
                    //Puts city name into cityLabel
                    self.cityLabel.text = "\(city)"
                })
                
                let calendar = Calendar.current
                let endDate = calendar.date(byAdding: .hour, value: 12,to: Date.now)
                let result = try await weatherService.weather(for: location, including: .current, .hourly(startDate: Date.now, endDate: endDate!), .daily)
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.short
                dateFormatter.dateStyle = DateFormatter.Style.none
                dateFormatter.timeZone = .current
                
                let formatter = MeasurementFormatter()
                formatter.unitStyle = .short
                formatter.unitOptions = .temperatureWithoutUnit
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
//                print(result.currentWeather.temperature.converted(to: .fahrenheit))
//                print(formatter.string(from: result.currentWeather.temperature.converted(to: .fahrenheit)))
                let temp = formatter.string(from: result.0.temperature)
                print("supposed to be fahrenheit:\(temp)")
                let uv = result.0.uvIndex.value
                let wind = formatter.string(from: result.0.wind.speed)
                let symbol = result.0.symbolName
                let humidity = Int(100 * result.0.humidity)
                let pressure = formatter.string(from: result.0.pressure)
                
                //Data from dailyForecast[0] (today)
                let tempMax = formatter.string(from: result.2[0].highTemperature)
                let tempMin = formatter.string(from: result.2[0].lowTemperature)
                let localSunrise = dateFormatter.string(from: result.2.forecast[0].sun.sunrise!)
                let localSunset = dateFormatter.string(from: result.2.forecast[0].sun.sunset!)
                let solarNoon = dateFormatter.string(from: result.2.forecast[0].sun.solarNoon!)
                let astronomicalDawn = dateFormatter.string(from: result.2[0].sun.astronomicalDawn!)
                let astronomicalDusk = dateFormatter.string(from: result.2[0].sun.astronomicalDusk!)
                
                var rainChance = Int(100 * result.2.forecast[0].precipitationChance)
                if rainChance < 15 {
                    rainChance = 0
                } else {}
                
                
                //For loop for the tempMax for 5 days
                for i in 0...9 {
//                    print(result.dailyForecast[i].highTemperature)
                    let maxTemp = result.2[i].highTemperature
                    WeatherKitData.TempMaxForecast.append(formatter.string(from: maxTemp))        //Append is needed to append into array
                    print("TempMaxForecast: \(WeatherKitData.TempMaxForecast[i])")
                    let forecastSymbol = result.2[i].symbolName
                    WeatherKitData.forecastSymbol.append(forecastSymbol)
                    print("forecastSymbol: \(WeatherKitData.forecastSymbol[i])")
                    let minTemp = result.2[i].lowTemperature
                    WeatherKitData.TempMinForecast.append(formatter.string(from: minTemp))
                    print("TempMinForecast: \(WeatherKitData.TempMinForecast[i])")
//                    print("WEATHERKITDATA TempMax array: \(WeatherKitData.TempMaxForecast[i])")
                }
                
                //For loop for 12hour wind
                for i in 0...11 {
                    let formatter = MeasurementFormatter()
                    formatter.unitOptions = .temperatureWithoutUnit
                    let windSpeed = result.1.forecast[i].wind.speed
                    let wind = (round(windSpeed.value * 10)) / 10
                    print(wind)
                    WeatherKitData.WindSpeedForecast.append(wind)
                    print(WeatherKitData.WindSpeedForecast[i])
                }
                
                //For loop for 12 hour weather
                for i in  0...12 {
                    let forecast = result.1.forecast[i].temperature.value
                    WeatherKitData.HourlyForecast.append(forecast)
                    print("Hourly Forecast: \(WeatherKitData.HourlyForecast[i])")
                }
                
                print(temp)
                print(uv)
                print(symbol)
                print(rainChance)
                print(result.1.forecast[0].wind)
//                if result.alerts!.count > 0 {
//                    print("Weather Alert: \(result.weatherAlerts?[0].summary)")
//                } else {
//                    print("No alerts")
//                }
                
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
                WeatherKitData.Sunrise = result.2.forecast[0].sun.sunrise!
                WeatherKitData.Sunset = result.2.forecast[0].sun.sunset!
                WeatherKitData.localSunrise = localSunrise
                WeatherKitData.localSunset = localSunset
                WeatherKitData.SolarNoon = solarNoon
                WeatherKitData.AstronomicalDawn = astronomicalDawn
                WeatherKitData.AstronomicalDusk = astronomicalDusk
                WeatherKitData.Pressure = pressure
                WeatherKitData.RainChance = rainChance
                

                WeatherKitData.SunriseDate = result.2.forecast[0].sun.sunrise!
                WeatherKitData.SunsetDate = result.2.forecast[0].sun.sunset!
                
                
                DateConverter().timeArrayMaker()    //Runs timeArrayMaker func for timeArray in widget
                //puts WidgetData struct into widget
                var widget = WidgetData(temp: temp, tempMax: tempMax, tempMin: tempMin, symbolName: symbol, hourlyForecast: WeatherKitData.HourlyForecast, forecastTimeArray: timeArray.formattedHours)
                let primaryData = PrimaryData(widgetData: widget)
                //Encodes data into AppGroup
                primaryData.encode()
                
            } catch {
                print(String(describing: error))
            }
            self.updateLabelsAfterAwait()
        }
    }
    //@MainActor runs after getweather Task completes
    @MainActor
    private func updateLabelsAfterAwait() {
        ForecastListVC().forecastTableView.reloadData()
        print("updateLabelsAfterAwait run")
        getWeatherLabelUpdate()
        DateConverter().convertDateToEpoch()
        createNotification()
    }
}

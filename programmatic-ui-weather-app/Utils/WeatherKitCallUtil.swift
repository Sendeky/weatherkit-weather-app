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


let weatherService = WeatherService()

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
//                    self.cityLabel.text = "San Francisco"
                })
//                let TempLocation = CLLocation(latitude: 39.9042, longitude: 116.4074)     // Beijing
                
                let calendar = Calendar.current
                let endDate = calendar.date(byAdding: .hour, value: 12,to: Date.now)
                let result = try await weatherService.weather(for: location, including: .current, .hourly(startDate: Date.now, endDate: endDate!), .daily)
                
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.short
                dateFormatter.dateStyle = DateFormatter.Style.none
                dateFormatter.timeZone = .current
                
                // will have 0 maximumFractionDigits
                let MF0 = MeasurementFormatter()
                MF0.unitStyle = .short
                MF0.locale = .autoupdatingCurrent
                MF0.numberFormatter.maximumFractionDigits = 0
                
                // will have 1 maximumFractionDigits
                let MF1 = MeasurementFormatter()
                MF1.unitStyle = .short
                MF1.locale = .autoupdatingCurrent
                MF1.numberFormatter.maximumFractionDigits = 1
                
                //Data from currentWeather
                let temp = MF0.string(from: result.0.temperature)
                
                MF0.numberFormatter.maximumFractionDigits = 3
                let uv = result.0.uvIndex.value
                let windSpeed = MF0.string(from: result.0.wind.speed)
                print(windSpeed)
                let windDirection = result.0.wind.compassDirection
                print("gust: \(result.0.wind.gust)")
                let symbol = result.0.symbolName
                let humidity = Int(100 * result.0.humidity)
                let pressure = MF1.string(from: result.0.pressure)
                
                //Data from dailyForecast[0] (today)
                let tempMax = MF0.string(from: result.2[0].highTemperature)
                let tempMin = MF0.string(from: result.2[0].lowTemperature)
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
                for i in 0...6 {
//                    print(result.dailyForecast[i].highTemperature)
                    let maxTemp = result.2[i].highTemperature
                    WeatherKitData.TempMaxForecast.append(MF0.string(from: maxTemp))        //Append is needed to append into array
                    print("TempMaxForecast: \(WeatherKitData.TempMaxForecast[i])")
                    let forecastSymbol = result.2[i].symbolName
                    WeatherKitData.forecastSymbol.append(forecastSymbol)
                    print("forecastSymbol: \(WeatherKitData.forecastSymbol[i])")
                    let minTemp = result.2[i].lowTemperature
                    WeatherKitData.TempMinForecast.append(MF0.string(from: minTemp))
                    print("TempMinForecast: \(WeatherKitData.TempMinForecast[i])")
//                    print("WEATHERKITDATA TempMax array: \(WeatherKitData.TempMaxForecast[i])")
                }
                
                //For loop for 12hours
                for i in 0...11 {
                    // wind speed for next 12 hours
                    let formatter = MeasurementFormatter()
                    formatter.unitOptions = .temperatureWithoutUnit
                    let windSpeed = result.1.forecast[i].wind.speed
                    let wind = (round(windSpeed.value * 10)) / 10
//                    print("Wind: \(wind)")
                    WeatherKitData.WindSpeedForecast.append(wind)
                    
                    // gusts for next 12 hours`
                    let gust = result.1.forecast[i].wind.gust
                    if let unwrapperGust = gust {
                        WeatherKitData.WindGusts.append(unwrapperGust)
                        print("gust#\(i): \(unwrapperGust)")
                    }
                    
                    // precipitation chance for next 12 hours
                    print("precipitation chance\(i): \(result.1.forecast[i].precipitationChance)")
                }
                
                //For loop for 12 hour weather
                for i in  0...11 {
                    let forecast = result.1.forecast[i].temperature.value
                    WeatherKitData.HourlyForecast.append(forecast)
                    print("Hourly Forecast: \(WeatherKitData.HourlyForecast[i])")
                    let symbol = result.1.forecast[i].symbolName
                    WeatherKitData.HourlyForecastSymbol.append(symbol)
                }
                
//                print(temp)
//                print(uv)
//                print(symbol)
//                print(rainChance)
//                print(result.1.forecast[0].wind)
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
                WeatherKitData.WindSpeed = windSpeed
                WeatherKitData.WindDirection = "\(windDirection)"
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
                WeatherKitData.PrecipitationChance = rainChance
                
                
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
        
        let date = WeatherKitData.SunsetDate
        let interval = WeatherKitData.SunsetDate.timeIntervalSinceReferenceDate - WeatherKitData.SunriseDate.timeIntervalSinceReferenceDate
        
        let rocketTimer = Timer(fireAt: date, interval: interval, target: self, selector: #selector(AnimateRocket), userInfo: nil, repeats: false)
        RunLoop.main.add(rocketTimer, forMode: RunLoop.Mode.common)
    }
}

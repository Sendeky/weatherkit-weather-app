//
//  WindSpeedPopUpVC.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/13/22.
//

import SwiftUI
import Charts

struct Item: Identifiable{
    var id = UUID()
    var value1: Double
    var value2: Double
}

struct WindSpeedPopUpVC: View {
    
    // @State is used because "items" changes
    // Variable for graph values
    @State var items: [Item] = [
        Item(value1: 0.0, value2: 0.0),
        Item(value1: 24.0, value2: 0.0),
    ]
    @State var currentTime = 0  // Array for current time (for graph)
    @State var gusts: [Double] = [0.0] // An array of gust values
    
    var body: some View {
        ZStack {
            //        windView.applyBlurEffect(.systemUltraThinMaterialLight, cornerRadius: 20)
//            Color(UIColor(red: 125.0/255.0, green: 175.0/255.0, blue: 255.0/255.0, alpha: 1.0))
            VStack {
                Text("Wind")
                    .font(Font.custom("SpaceX", size: 24.0))
                    .padding()
                HStack(alignment: .firstTextBaseline) {
                    VStack {
                        Text("\(WeatherKitData.WindSpeed)")
                            .font(Font.custom("SpaceX", size: 24.0))
                            .padding(.leading)
                        Text(WeatherKitData.WindDirection)
//                            .font(Font.custom("SpaceX", size: 10.0))
                    }
                    Spacer()
                }
                VStack {
//                    RoundedRectangle(cornerRadius: 20)
//                        .frame(height: 300)
//                        .padding(.top, 5)
//                        .padding(.horizontal, 10)
                    Color(.clear)
                        .frame(height: UIScreen.main.bounds.height / 3)
//                        .foregroundColor(.blue)
                        .overlay(Chart(items) { item in
                            AreaMark(x: .value("", item.value1 + Double(currentTime)),
                                     yStart: .value("Min", item.value1 > 0 ? item.value1  - item.value1 : item.value1 + item.value1), //ternary for when temp is less than 0
                                     yEnd: .value("Max", item.value2)
                            ) //BarMark
                            .opacity(0.5)
                            .foregroundStyle(.primary)
                            .interpolationMethod(.monotone)
                            LineMark (
                                x: .value("", item.value1 + Double(currentTime)),
                                y: .value("", item.value2)
                            ) //LineMark
                            .interpolationMethod(.monotone)
                            .lineStyle(StrokeStyle(lineWidth: 8))
                        }) //Chart
                        .chartXScale(domain: (currentTime + 1)...(currentTime + 9))
                        .chartXAxisLabel("Time")
                        .chartYScale(domain: Int(WeatherKitData.WindSpeedForecast.min()! - 5)...Int(WeatherKitData.WindSpeedForecast.max()! + 5))
                        .chartYAxisLabel("MPH")
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        .padding()
                    Spacer()
                    VStack {
                        Text("Weather Information")
                            .font(.title)
                            .padding(.bottom, 10)
                               
                        ForEach(gusts, id: \.self) { gust in
                            Text("Gust: \(gust)m/s")
                                   
                        }
                        
                    }
                }
//                Spacer()
            }
        }
            .background(BackgroundBlurView())
        .onAppear {
            print(WeatherKitData.WindSpeedForecast)
            /*if WeatherKitData.WindSpeedForecast.isEmpty == false {
                for i in 1...9 {

                    print("Wind speed forecast \(WeatherKitData.WindSpeedForecast[i])")
                    Item(value1: Double(i), value2: WeatherKitData.WindSpeedForecast[i])
                }
            }*/
            items.removeAll(keepingCapacity: false)
            for i in 1...9 {
                items.append(Item(value1: Double(i), value2: WeatherKitData.WindSpeedForecast[i]))
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "h a"
            
            // Get the current time
            let CurrentTime = Calendar.current.dateComponents([.hour], from: Date())        // gets current time (hour)
            let currentHour = CurrentTime.hour ?? 0
            
            currentTime = currentHour
            
            currentTime = currentTime > 12 ? currentTime - 13 : currentTime - 1     // Some extremely stupid logic to get the chart to fill up and have the time line up
                                                                                    // It's "-13" and "-1" because I think the array starts at 1
                                                                                    // (first element in windspeed array is empty, so we start with the first one, mgiht fix later)

            print("Current Time: \(currentHour)")
            
        }.edgesIgnoringSafeArea(.bottom)
    }
}

// Background Blur struct
struct BackgroundBlurView: UIViewRepresentable {
    //Makes UIView, returns UIView
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}


// Preview Struct
struct WindSpeedPopUpVC_Previews: PreviewProvider {
    static var previews: some View {
        WindSpeedPopUpVC()
    }
}

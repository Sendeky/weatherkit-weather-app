//
//  ForecastView.swift
//  weatherkit-watchosExtension Watch App
//
//  Created by Ruslan Spirkin on 2/10/23.
//

import SwiftUI

struct Forecast: Hashable {
    var temp: String
}

struct ForecastView: View {
    @State var forecast: [Forecast]
    
    var body: some View {
        ForEach(forecast, id: \.self) { temp in
            HStack {
                Text(temp.temp)
                Image(systemName: "cloud.sun.fill").renderingMode(.original).font(.title3)
            }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(forecast: [Forecast(temp: "12")])
    }
}

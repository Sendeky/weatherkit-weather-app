//
//  CurrentView.swift
//  weatherkit-watchosExtension Watch App
//
//  Created by Ruslan Spirkin on 2/9/23.
//

import SwiftUI
import Charts


struct CurrentView: View {
    @State var currentTemp: String
    
    var body: some View {
        HStack {
            Text(currentTemp).font(.title)
            Image(systemName: "cloud.sun.rain.fill").renderingMode(.original).font(.title)
        }
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView(currentTemp: "12˚C")
    }
}

//
//  RangeView.swift
//  weatherkit-watchosExtension Watch App
//
//  Created by Ruslan Spirkin on 2/10/23.
//

import SwiftUI

struct RangeView: View {
    @State var minTemp: String  //Takes in minTemp, watches when changed (State)
    @State var maxTemp: String  //Takes in maxTemp, watches when changed (State)
    
    var body: some View {
        Text("Min: \(minTemp) - Max: \(maxTemp)").font(.title3)
                .padding(.vertical)
    }
}

struct RangeView_Previews: PreviewProvider {
    static var previews: some View {
        RangeView(minTemp: "7", maxTemp: "12")
    }
}

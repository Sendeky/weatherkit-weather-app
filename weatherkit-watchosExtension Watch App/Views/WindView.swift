//
//  WindView.swift
//  weatherkit-watchosExtension Watch App
//
//  Created by Ruslan Spirkin on 2/10/23.
//

import SwiftUI

struct WindView: View {
    @State var windSpeed: String
    
    var body: some View {
        Text(windSpeed)
    }
}

struct WindView_Previews: PreviewProvider {
    static var previews: some View {
        WindView(windSpeed: "12 MPH").font(.title3)
    }
}

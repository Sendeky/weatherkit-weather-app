//
//  WindSpeedPopUpVC.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/13/22.
//

import SwiftUI

struct WindSpeedPopUpVC: View {
    var body: some View {
        ZStack {
            Color(UIColor(red: 125.0/255.0, green: 175.0/255.0, blue: 255.0/255.0, alpha: 1.0))
            VStack {
                Text("Wind")
                    .font(.largeTitle)
                    .padding()
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 300)
                        .padding(.top, 5)
                        .padding(.horizontal, 10)
                        .foregroundColor(.blue)
                }
                Spacer()
            }
        }
    }
}

struct WindSpeedPopUpVC_Previews: PreviewProvider {
    static var previews: some View {
        WindSpeedPopUpVC()
    }
}

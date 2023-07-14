//
//  SwiftUIBackgroundBlur.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 7/14/23.
//

import SwiftUI

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

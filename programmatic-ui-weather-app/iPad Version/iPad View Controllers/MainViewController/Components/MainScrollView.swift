//
//  MainScrollView.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 12/17/24.
//

import Foundation
import UIKit

extension iPadMainViewController {
    func setupMainScrollView() {
        //mainScrollView settings
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.contentSize = CGSize(width: 200, height: 300)
        mainScrollView.alwaysBounceVertical = true
        mainScrollView.isScrollEnabled = true
        mainScrollView.alwaysBounceHorizontal = false
    }
}

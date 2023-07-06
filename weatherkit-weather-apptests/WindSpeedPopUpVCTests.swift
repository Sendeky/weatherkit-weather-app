//
//  WindSpeedPopUpVCTests.swift
//  weatherkit-weather-apptests
//
//  Created by Ruslan Spirkin on 5/27/23.
//

import XCTest
@testable import weatherkit_weather_app // Replace with your app's name

class WindSpeedPopUpVCTests: XCTestCase {

    func testWindSpeedPopUpVC_InitialItemsCount() {
        let view = WindSpeedPopUpVC()
        XCTAssertEqual(view.items.count, 2, "Initial items count should be 2")
    }

    func testWindSpeedPopUpVC_ItemsCountAfterAppending() {
        var view = WindSpeedPopUpVC()
        view.items.append(Item(value1: 3.0, value2: 10.0))
        XCTAssertEqual(view.items.count, 2, "Items count should increase after appending an item")
    }
    // Add more tests as needed

}


//
//  NeontriUITests.swift
//  NeontriUITests
//
//  Created by KOVIGROUP on 07/11/2019.
//  Copyright © 2019 KOVIGROUP. All rights reserved.
//

import XCTest

class NeontriUITests: XCTestCase {

    override func setUp() {
    
        continueAfterFailure = false

    
    }

    override func tearDown() {
       
    }

    func testExample() {
        
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

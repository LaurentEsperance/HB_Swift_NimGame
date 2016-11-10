//
//  NimGameUITests.swift
//  NimGameUITests
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import XCTest

class NimGameUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
                 
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        let nbPlayerWheel = app.pickers["playerNbWheelPicker"]
        let but1Match = app.buttons["but1match"]
        let but2Matches = app.buttons["but2matches"]
        let but3Matches = app.buttons["but3matches"]
        let curPlayerLabel = app.staticTexts["curPlayerLabel"]
        let gameMode = app.staticTexts["playerModeLabel"]
        
        // Choose the number of player
        app.pickerWheels.element.adjust(toPickerWheelValue: "1 Player")
        gameMode.tap()
        XCTAssertEqual(gameMode.value as! String, "1 Player mode")
        
    }
    
}

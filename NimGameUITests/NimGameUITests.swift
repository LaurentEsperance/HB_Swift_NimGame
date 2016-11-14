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
        let butSettings = app.buttons["main_vc_settings_button"]
        let butBackFromSettings = app.buttons["sett_CV_back_button"]
        let nbMatchesTextEdit =  app.textFields["max_matches_text_edit"]
        let randStartSwitch = app.switches["rand_start_switch"]
        //let clearTextInNbMatchesTextEdit = app.buttons["Clear text"]
        
        
        // TEST for 2 players //
        XCTAssertTrue(nbPlayerWheel.exists, "The wheelpicker should appear at the launch of the app")
        XCTAssertFalse(but1Match.exists, "The button for 1 match should NOT appear at the launch of the app")
        XCTAssertFalse(but2Matches.exists, "The button for 2 matches should NOT appear at the launch of the app")
        XCTAssertFalse(but3Matches.exists, "The button for 3 matches should NOT appear at the launch of the app")
        
        // Choose the number of matches
        butSettings.tap()
        XCTAssertFalse(nbPlayerWheel.exists, "The wheelpicker should NOT appear on settings view")
        XCTAssertFalse(but1Match.exists, "The button for 1 match should NOT appear on settings view")
        XCTAssertFalse(but2Matches.exists, "The button for 2 matches should NOT appear on settings view")
        XCTAssertFalse(but3Matches.exists, "The button for 3 matches should NOT appear on settings view")
        XCTAssertTrue(butBackFromSettings.exists, "The button for 3 matches should appear on settings view")
        XCTAssertTrue(nbMatchesTextEdit.exists, "The editText should appear on settings view")
        
        nbMatchesTextEdit.tap()
        nbMatchesTextEdit.typeText("20")
        // Test if the number of matches had been saved
        butBackFromSettings.tap()
        butSettings.tap()
        XCTAssertTrue((nbMatchesTextEdit.value != nil), "20")
        butBackFromSettings.tap()
        
        // Start the game with no random first player
        butSettings.tap()
        
        if (randStartSwitch.isEnabled) {
            randStartSwitch.tap()
        }
        butBackFromSettings.tap()
        
        // Choose the number of player
        app.pickerWheels.element.adjust(toPickerWheelValue: "2 Players")
        gameMode.tap()
        XCTAssertEqual(gameMode.label, "2 Players mode")
        XCTAssertEqual(curPlayerLabel.label, "Player 1")
        
    }
    
}

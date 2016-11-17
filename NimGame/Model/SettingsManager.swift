//
//  SettingsManager.swift
//  NimGame
//
//  Created by imac on 17/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import Foundation

class SettingsManager {
    
    private static var singleInstance:SettingsManager?
    private let _userDefaults:UserDefaults
    private static let INITIAL_MATCHES_COUNT_KEY = "INITIAL_MATCHES_COUNT"
    private static let WIN_GAME_SCORE_BONUS_KEY = "WIN_GAME_SCORE_BONUS"
    private static let IS_START_RANDOM_KEY = "IS_START_RANDOM"
    
    public static var instance:SettingsManager {
        if singleInstance == nil {
            singleInstance = SettingsManager()
        }
        return singleInstance!
    }
    
    private init() {
        _userDefaults = UserDefaults.standard
        let defaultsValues = [
            SettingsManager.INITIAL_MATCHES_COUNT_KEY:20,
            SettingsManager.WIN_GAME_SCORE_BONUS_KEY:10,
            SettingsManager.IS_START_RANDOM_KEY:false
        ] as [String : Any]
        _userDefaults.register(defaults: defaultsValues)
    }
    
    var initialMatchesCount:Int{
        get {
            return _userDefaults.integer(forKey: SettingsManager.INITIAL_MATCHES_COUNT_KEY)
        }
        set {
            _userDefaults.set(newValue, forKey:SettingsManager.INITIAL_MATCHES_COUNT_KEY)
        }
    }
    
    var winGameBonus:Int{
        get {
            return _userDefaults.integer(forKey: SettingsManager.WIN_GAME_SCORE_BONUS_KEY)
        }
    }
    
    var randomStart:Bool{
        get {
            return _userDefaults.bool(forKey: SettingsManager.IS_START_RANDOM_KEY)
        }
        set {
            _userDefaults.set(newValue,forKey: SettingsManager.IS_START_RANDOM_KEY)
        }
    }
    
}

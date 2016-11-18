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
    private static let PLAYER_1_NAME_KEY = "PLAYER_1_NAME"
    private static let PLAYER_2_NAME_KEY = "PLAYER_2_NAME"
    private static let PLAYER_LIST_KEY = "PLAYER_LIST"
    
    public static var instance:SettingsManager {
        if singleInstance == nil {
            singleInstance = SettingsManager()
        }
        return singleInstance!
    }
    
    private init() {
        _userDefaults = UserDefaults.standard
        let initDict : [String : Int] = ["test":0]
        let defaultsValues = [
            SettingsManager.INITIAL_MATCHES_COUNT_KEY:20,
            SettingsManager.WIN_GAME_SCORE_BONUS_KEY:10,
            SettingsManager.IS_START_RANDOM_KEY:false,
            SettingsManager.PLAYER_LIST_KEY:initDict
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
    
    var player1Name:String{
        get{
            return _userDefaults.string(forKey: SettingsManager.PLAYER_1_NAME_KEY)!
        }
        set{
            _userDefaults.set(newValue,forKey: SettingsManager.PLAYER_1_NAME_KEY)
        }
    }

    var player2Name:String{
        get{
            return _userDefaults.string(forKey: SettingsManager.PLAYER_2_NAME_KEY)!
        }
        set{
            _userDefaults.set(newValue,forKey: SettingsManager.PLAYER_2_NAME_KEY)
        }
    }
    
    var playerList:[String:Int]{
        get{
            return _userDefaults.value(forKey: SettingsManager.PLAYER_LIST_KEY) as! [String : Int]
        }
        set {
            _userDefaults.set(newValue, forKey: SettingsManager.PLAYER_LIST_KEY)
        }
    }
}

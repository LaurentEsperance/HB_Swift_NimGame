//
//  ComputerPlayer.swift
//  NimGame
//
//  Created by imac on 18/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import Foundation

class ComputerPlayer: Player {
    private var _name:String = ""
    private static var _score:Int = 0
    private static var singleInstance:ComputerPlayer?
    
    public static var instance:ComputerPlayer {
        if singleInstance == nil {
            singleInstance = ComputerPlayer()
        }
        return singleInstance!
    }
    
    override var score: Int{
        get{
            return ComputerPlayer._score
        }
        set {
            ComputerPlayer._score = newValue
        }
    }
    
    override private init() {
        super.init(name: "IA", score: 0)
    }
    
    func nbMatchesTakenIA(nbMatchesInGame:Int)->Int{
        var nbMatchesToTake:Int = (nbMatchesInGame - 1) % 4
        if (nbMatchesToTake == 0) {
            nbMatchesToTake = Tool.generateRandomNumber(min: 1, max: min(3,nbMatchesInGame))
        }
        print("The IA takes \(nbMatchesToTake) matches")
        return nbMatchesToTake
    }
    
}

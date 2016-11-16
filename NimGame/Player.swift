//
//  Player.swift
//  NimGame
//
//  Created by imac on 14/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import Foundation

class Player {
    var _name:String
    var _score:Int
    
    var name:String {
        get{
            return self._name
        }
        set(newValue) {
            self._name = newValue
        }
    }
    var score: Int {
        get {
            return self._score
        }
        set(newValue){
            self._score = newValue
        }
    }
    
    init() {
        _name = ""
        _score = 0
    }
    
    init(name:String, score:Int) {
        self._name = name
        self._score = score
    }
    
    func win(){
        self._score += 10
    }
    

}

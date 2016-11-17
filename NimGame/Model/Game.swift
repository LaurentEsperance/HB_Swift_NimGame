//
//  Game.swift
//  NimGame
//
//  Created by imac on 17/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import Foundation

class Game {
    
    private var _player1:Player
    private var _player2:Player
    private var _matchesCount:Int
    private var _currentPlayer : Player
    
    init() {
        _player1 = Player(name: "", score: 0)
        _player2 = Player(name: "", score: 0)
        _matchesCount = 0
        _currentPlayer = _player1
    }
    
    init(p1:Player,p2:Player,nbMatches:Int) {
        _player1 = p1
        _player2 = p2
        _matchesCount = nbMatches
        _currentPlayer = _player1
    }
    
    func win(player:Player){
        player.score += SettingsManager.instance.winGameBonus
    }
    
    func loss(player:Player){
        player.score -= 10
    }
    
    var matchesCount:Int{
        get {
            return _matchesCount
        }
        set {
            _matchesCount = newValue
        }
    }
    
    var winner:Player?{
        var gameWinner:Player? = nil
        if isGameOver {
            gameWinner = _currentPlayer
        }
        return gameWinner
    }
    
    var isGameOver:Bool {
        return _matchesCount <= 0
    }
    
    
    func removeMatches(nbMatches:Int){
        _matchesCount -= nbMatches
        _matchesCount = max(_matchesCount,0)
        _currentPlayer = (_currentPlayer === _player1) ? _player2 : _player1
    }
    
    var currentPlayer:Player{
        return _currentPlayer
    }
    
}

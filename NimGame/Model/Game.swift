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
        // Need to initialize all the variables before using a function
        _currentPlayer = _player1
        _currentPlayer = getFirstPlayer(p1: _player1, p2: _player2)
    }
    
    init(p1:Player,p2:Player,nbMatches:Int) {
        _player1 = p1
        _player2 = p2
        _matchesCount = nbMatches
        // Need to initialize all the variables before using a function
        _currentPlayer = _player1
        _currentPlayer = self.getFirstPlayer(p1: self._player1, p2: self._player2)
        gameMovesWithIA()
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
        if (_matchesCount > 0){
           gameMovesWithIA()
        }
        
    }
    
    var currentPlayer:Player{
        return _currentPlayer
    }
    
    // Random Start management
    func getFirstPlayer (p1:Player, p2:Player) -> Player{
        var playerToStart: Player
        if SettingsManager.instance.randomStart {
            if (Tool.generateRandomNumber(min: 1, max: 2) == 1) {
                playerToStart = p1
            } else {
                playerToStart = p2
            }
        } else {
            playerToStart = p1
        }
        return playerToStart
    }
    
    func gameMovesWithIA() {
        if (_currentPlayer.name == "IA") {
            let playerIA = _currentPlayer as! ComputerPlayer
            removeMatches(nbMatches: playerIA.nbMatchesTakenIA(nbMatchesInGame: _matchesCount))
        }
    }
    
}

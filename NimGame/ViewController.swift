//
//  ViewController.swift
//  NimGame
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var ui_nbPlayerView: UIView!
    @IBOutlet weak var ui_pickerView: UIPickerView!
    @IBOutlet weak var ui_gameLabel: UILabel!
    @IBOutlet weak var ui_currentPlayerLabel: UILabel!
    @IBOutlet weak var ui_nbMatchesLabel: UILabel!
    @IBOutlet weak var ui_gameTxtView: UITextView!
    @IBOutlet weak var ui_gameView: UIView!
    @IBOutlet weak var ui_gameProgressV: UIProgressView!
    @IBOutlet weak var ui_but1Match: UIButton!
    @IBOutlet weak var ui_but2Matches: UIButton!
    @IBOutlet weak var ui_but3Matches: UIButton!
    
    
    let onePlayer:String = "1 Player"
    let twoPlayers:String = "2 Players"
    let nbMatchesMax:Int = 20
    var isPlayer2TheComputer:Bool = true
    var nbPlayer = [""]
    var nbMatches:Int = 0
    var joueurEnCours : Int = 0
    var nbMatchesChosenByPlayer:Int = 0
    var turn:Int = 0
    let userDefaults:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ui_pickerView.dataSource = self
        self.ui_pickerView.delegate = self
        nbPlayer = ["Nb Player?" , onePlayer , twoPlayers]
        gameInit()
    }
    
    private func gameInit(){
        ui_nbPlayerView.isHidden = false
        ui_gameLabel.isHidden = true
        ui_gameView.isHidden = true
        //nbMatches = nbMatchesMax
        nbMatches = userDefaults.integer(forKey: "MAX_MATCHES")
        joueurEnCours = 0
        nbMatchesChosenByPlayer = 0
        turn = 0
        ui_gameTxtView.text=""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nbPlayer.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nbPlayer[row]
    }
    
    @IBAction func newGameBut(_ sender: UIButton) {
        gameInit()
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print("You have selected \(nbPlayer[row])")
        ui_nbPlayerView.isHidden = true
        NimGame(nbPlayer: nbPlayer[row])
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        nbMatchesChosenByPlayer = sender.tag
        //ui_gameTxtView.text! += "At turn \(turn) Player\(joueurEnCours) have chosen \(nbMatchesChosenByPlayer) matches\n"
        //print("At turn \(turn) Player\(joueurEnCours) have chosen \(nbMatchesChosenByPlayer) matches")
        nbMatches -= nbMatchesChosenByPlayer
        gameMoveForward()
    }
    
    func gameMoveForward(){
        turn += 1
        print("At turn \(turn) there is \(nbMatches) matches in the game")
        joueurEnCours = (joueurEnCours == 1) ? 2 : 1
        if (nbMatches <= 0) {
            if ((joueurEnCours == 2) && isPlayer2TheComputer) {
                ui_gameTxtView.text! += "The computer wins \n"
            } else {
                ui_gameTxtView.text! += "Player \(joueurEnCours) wins \n"
            }
        } else {
            displayMatches(nbMatches: nbMatches)
            displayProgressBar(nbMatches: nbMatches)
            if (joueurEnCours == 2) {
                if (isPlayer2TheComputer) {
                    let nbMatchesChosenByComputer = nbAllumettesIA(nbAllumettesEnJeu: nbMatches)
                    nbMatches -= nbMatchesChosenByComputer
                    gameMoveForward()
                }
            }
            switch nbMatches {
            case 1:
                ui_but2Matches.isHidden = true
                fallthrough
            case 2:
                ui_but3Matches.isHidden = true
            default:
                ui_but2Matches.isHidden = false
                ui_but3Matches.isHidden = false
                
            }
            ui_currentPlayerLabel.text = "Player \(joueurEnCours)"
        }
    }
    
    func NimGame(nbPlayer:String) {
        // Prepare the launch of the game
        ui_gameLabel.text = nbPlayer + " mode"
        ui_gameLabel.isHidden = false
        ui_gameView.isHidden = false
        isPlayer2TheComputer = (nbPlayer == onePlayer)
        // The first player is chosen randomly
        if (userDefaults.bool(forKey: "IS_START_RANDOM")) {
           joueurEnCours = generateRandomNumber(min: 1, max: 2)
        } else {
            joueurEnCours = 2
        }
        //ui_gameTxtView.text = "There is \(nbMatches) matches in the game\n"
        gameMoveForward()
    }
    
    func displayMatches(nbMatches:Int) {
        var matchesToDisplay:String = ""
        for _ in 0..<nbMatches {
            matchesToDisplay += "| "
        }
        ui_nbMatchesLabel.text = matchesToDisplay
    }
    
    func displayProgressBar(nbMatches:Int){
        let progressPercentage:Float = (Float(nbMatchesMax-nbMatches) / Float(nbMatchesMax))
        ui_gameProgressV.progress = progressPercentage
    }
    
    func nbAllumettesIA(nbAllumettesEnJeu:Int)->Int{
        var nbAllumettesChoisieParOrdinateur:Int = (nbAllumettesEnJeu - 1) % 4
        if (nbAllumettesChoisieParOrdinateur == 0) {
            nbAllumettesChoisieParOrdinateur = generateRandomNumber(min: 1, max: min(3,nbAllumettesEnJeu))
        }
        ui_gameTxtView.text! += "At turn \(turn) the computer had taken \(nbAllumettesChoisieParOrdinateur) matches\n"
        //print("L'ordinateur a retiré \(nbAllumettesChoisieParOrdinateur) allumette" + (nbAllumettesChoisieParOrdinateur > 1 ? "s" : ""))
        return nbAllumettesChoisieParOrdinateur
    }
    
    func generateRandomNumber(min:Int, max:Int) -> Int {
        let range = max-min + 1
        return Int(arc4random_uniform(UInt32(range))) + min
    }
    
}


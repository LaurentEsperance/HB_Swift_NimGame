//
//  ViewController.swift
//  NimGame
//
//  Created by imac on 10/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    
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
    @IBOutlet weak var ui_playerChoiceView: UIView!
    @IBOutlet weak var ui_playerChoiceTable: UITableView!
    
    
    let onePlayer:String = "1 Player"
    let twoPlayers:String = "2 Players"
    var firstPLayer: Player = Player()
    var secondPlayer: Player = Player()
    
    let playerExample1 : Player = Player(name: "Toto", score: 10)
    let playerExample2 : Player = Player(name: "Tata", score: 20)
    let playerIA : Player = Player(name: "IA", score: 0)
    
    let nbMatchesMax:Int = 20
    var isPlayer2TheComputer:Bool = true
    var nbPlayerList = [""]
    var nbMatches:Int = 0
    var joueurEnCours : Int = 0
    var nbMatchesChosenByPlayer:Int = 0
    var turn:Int = 0
    let userDefaults:UserDefaults = UserDefaults.standard
    var curPlayer:Player = Player()
    var listPlayers = [String: Int]()
    var arrayPlayers = [String]()
    var nbPlayerInGame: String = ""
    
    
    private var _game:Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ui_pickerView.dataSource = self
        self.ui_pickerView.delegate = self
        nbPlayerList = ["Nb Player?" , onePlayer , twoPlayers]
        ui_playerChoiceView.isHidden = true
        gameInit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func gameInit(){
        ui_nbPlayerView.isHidden = false
        ui_gameLabel.isHidden = true
        ui_gameView.isHidden = true
        //Reset the picker to initial place
        ui_pickerView.selectRow(0, inComponent: 0, animated: false)
        nbMatches = userDefaults.integer(forKey: "MAX_MATCHES")
        //listPlayers = userDefaults.dictionary(forKey: "LIST_OF_PLAYERS") as! [String : Int]
        listPlayers = ["Toto" : 10, "Tata" : 5]
        joueurEnCours = 0
        nbMatchesChosenByPlayer = 0
        turn = 0
        ui_gameTxtView.text=""
        nbPlayerInGame = ""
    }
    
    private func newGame(nbPlayers:Int){
        if nbPlayers == 1 {
            _game = Game(p1: Player(name:"Toto"), p2: ComputerPlayer.instance, nbMatches: SettingsManager.instance.initialMatchesCount)
        } else {
            _game = Game(p1: Player(name:"Toto"), p2: Player(name:"Tata"), nbMatches: SettingsManager.instance.initialMatchesCount)
        }
        let playerString:String = (nbPlayers == 1) ? "player" : "players"
        ui_gameLabel.text =  "\(nbPlayers) \(playerString) mode"
        ui_gameLabel.isHidden = false
        ui_gameView.isHidden = false
        updateDisplay()
    }
    
    private func updateDisplay(){
        if let gameInProgress = _game {
            let nbMatchesInGame = gameInProgress.matchesCount
            displayMatches(nbMatches: nbMatchesInGame)
            displayProgressBar(nbMatches: nbMatchesInGame)
            if gameInProgress.isGameOver,
                let gameWinner = gameInProgress.winner{
                ui_gameTxtView.text! += "\(gameWinner.name) wins"
                gameWinner.win()
            } else {
                ui_currentPlayerLabel.text = gameInProgress.currentPlayer.name
            }
            ui_but1Match.isHidden = nbMatchesInGame < 1
            ui_but2Matches.isHidden = nbMatchesInGame < 2
            ui_but3Matches.isHidden = nbMatchesInGame < 3
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var nbElts:Int = 0
        if (pickerView == ui_pickerView) {
            nbElts = nbPlayerList.count
        }
        return nbElts
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var stringToDisplay:String = ""
        if (pickerView == ui_pickerView) {
            stringToDisplay = nbPlayerList[row]
        }
        return stringToDisplay
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print("You have selected \(nbPlayerList[row])")
        ui_nbPlayerView.isHidden = true
        nbPlayerInGame = nbPlayerList[row]
        //NimGame(nbPlayer: nbPlayerList[row])
        newGame(nbPlayers: row)
    }
    
    @IBAction func newGameBut(_ sender: UIButton) {
        gameInit()
    }
    
    
    @IBAction func buttonClicked(_ button: UIButton) {
        nbMatchesChosenByPlayer = button.tag
        if let gameInProgress = _game {
            gameInProgress.removeMatches(nbMatches: button.tag)
        }
        updateDisplay()
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
    
    /*func getPlayers(nbPlayer:String){
        if (nbPlayer == onePlayer){
            // TODO launch a picker to choose the first player
            firstPLayer = playerExample1
            secondPlayer = playerIA
            
        } else {
            // TODO launch a picker to choose the first player
            firstPLayer = playerExample1
            // TODO delete the player from the players array and
            // launch a picker to choose the second player
            secondPlayer = playerExample2
        }
    }*/
    
    func createPlayer() -> Player{
        let playerName:String = ""
        let playerScore:Int = 0
        //TODO Display a prompt which asks the name of the user
        
        return Player(name: playerName, score: playerScore)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listPlayers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellc: UITableViewCell = self.ui_playerChoiceTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cellc.textLabel?.text = arrayPlayers[indexPath.row]
        return cellc
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (nbPlayerInGame == "onePlayer") {
            let playerName = arrayPlayers[indexPath.row]
            let Score:Int = listPlayers[playerName]!
            firstPLayer = Player(name: playerName, score: Score)
        }
        print("Player \(arrayPlayers[indexPath.row]) has been chosen")
    }
    
    func dictToArray(dict:[String: Int]) -> [String] {
        var arr = [String]()
        for (key) in dict {
            arr.append("\(key)")
        }
        return arr
    }
    
}


//
//  ScoreViewController.swift
//  NimGame
//
//  Created by imac on 14/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    static var player1:Player = Player(name: "Toto", score: 10)
    static var player2:Player = Player(name: "Tata", score: 20)
    static var player3:Player = Player(name: "Titi", score: 30)
    var playerTable:[Player] = [player1, player2, player3]
    
    
    @IBOutlet weak var ui_scoresTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_scoresTableView.delegate = self
        ui_scoresTableView.dataSource = self
        self.ui_scoresTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ui_backButtonfromScoreList() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playerTable.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TableViewCell"
        let cellc = self.ui_scoresTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        //cellc.textLabel?.text = playerTable[indexPath.row]._name
        cellc.ui_playerNameLabel.text = playerTable[indexPath.row]._name
        cellc.ui_playerScoreLabel.text = String(playerTable[indexPath.row]._score)

        return cellc
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Player \(playerTable[indexPath.row]._name) has been chosen")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

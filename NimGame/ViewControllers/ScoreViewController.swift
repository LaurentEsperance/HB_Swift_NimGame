//
//  ScoreViewController.swift
//  NimGame
//
//  Created by imac on 14/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var playerListNames: [String] = []
    var playerListScores : [Int] = []
    var sortedKeys:[(key:String, value:Int)] = []
    
    @IBOutlet weak var ui_scoresTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_scoresTableView.delegate = self
        ui_scoresTableView.dataSource = self
        
        let playerDictonary = SettingsManager.instance.playerList
        
        sortedKeys = playerDictonary.sorted{ $0.value > $1.value }
        print(sortedKeys)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ui_backButtonfromScoreList() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedKeys.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TableViewCell"
        let cellc = self.ui_scoresTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        let tupleInSortedList = sortedKeys[indexPath.row]
        print(tupleInSortedList)
        print(tupleInSortedList.key)
        cellc.displayNameAndScore(playerName: tupleInSortedList.key, playerScore: tupleInSortedList.value)
        return cellc
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
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

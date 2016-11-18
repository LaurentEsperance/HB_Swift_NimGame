//
//  SettingsViewController.swift
//  NimGame
//
//  Created by imac on 14/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UITextFieldDelegate {
    
    let userDefaults:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var ui_randomStartSwitch: UISwitch!
    @IBOutlet weak var ui_nbMaxMatchesLabel: UITextField!
    @IBOutlet weak var ui_player1NameLabel: UITextField!
    @IBOutlet weak var ui_player2NameLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_nbMaxMatchesLabel.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ui_nbMaxMatchesLabel.text = String(SettingsManager.instance.initialMatchesCount)
        ui_randomStartSwitch.isOn = SettingsManager.instance.randomStart
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Delegate function on TextField
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        var isTheLabelAnInteger: Bool = false
        if let textFromNbMatchesMaxLabel = ui_nbMaxMatchesLabel.text {
            isTheLabelAnInteger = (Int(textFromNbMatchesMaxLabel) != nil)
        }
        return isTheLabelAnInteger
    }
    
    // Delegate function on TextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let initialNbMatchesLabel = ui_nbMaxMatchesLabel.text,
            let intValNbMatches = Int(initialNbMatchesLabel)
        {
            SettingsManager.instance.initialMatchesCount = intValNbMatches
        }
        
        
        return false
    }
    
    @IBAction func ui_backButton() {
        userDefaults.setValue(ui_nbMaxMatchesLabel.text, forKey: "MAX_MATCHES")
        userDefaults.setValue(ui_randomStartSwitch.isOn, forKey: "IS_START_RANDOM")
        if let navController = self.navigationController
        {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func ui_switchChanged() {
        SettingsManager.instance.randomStart = ui_randomStartSwitch.isOn
    }
    
    
}

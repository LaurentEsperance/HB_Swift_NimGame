//
//  SettingsViewController.swift
//  NimGame
//
//  Created by imac on 14/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let userDefaults:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var ui_randomStartSwitch: UISwitch!
    @IBOutlet weak var ui_nbMaxMatchesLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let nbMaxMatchesFromDefault = userDefaults.integer(forKey: "MAX_MATCHES")
        ui_nbMaxMatchesLabel.text = String(nbMaxMatchesFromDefault)
        ui_randomStartSwitch.isOn = userDefaults.bool(forKey: "IS_START_RANDOM")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ui_backButton() {
        userDefaults.setValue(ui_nbMaxMatchesLabel.text, forKey: "MAX_MATCHES")
        userDefaults.setValue(ui_randomStartSwitch.isOn, forKey: "IS_START_RANDOM")
        dismiss(animated: true, completion: nil)
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

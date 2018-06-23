//
//  StartScreen.swift
//  MobileChess
//
//  Created by Kathleen on 6/12/18.
//  Copyright © 2018 Team Cowdog. All rights reserved.
//

import UIKit
class StartScreen: UIViewController {
    
    // pass data from one screen to another
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destVC = segue.destination as! ViewController
        
        if segue.identifier == "singleplayer"{
            destVC.isAgainstAI = true
        }
        if segue.identifier == "multiplayer"{
            destVC.isAgainstAI = false
        }
    }
    
    
    @IBAction func unwind(segue: UIStoryboardSegue){
        
    }
    
    
    
}

//
//  File.swift
//  Ping-Pong
//
//  Created by Prashuk Ajmera on 5/21/19.
//  Copyright © 2019 Prashuk Ajmera. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    
   
    @IBAction func easy(_ sender: Any) {
        moveToGame(game: 11)
    }
    
    @IBAction func medium(_ sender: Any) {
        moveToGame(game: 12)
    }
    
    @IBAction func hard(_ sender: Any) {
        moveToGame(game: 13)
    }
    
    @IBAction func player2(_ sender: Any) {
        moveToGame(game: 20)
    }
       
    @IBAction func player2Bluetooth(_ sender: Any) {
        moveToGame(game: 21)
    }
       
    func moveToGame(game: Int) {
        currentGameType = game
        performSegue(withIdentifier: "toGameVC", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
}

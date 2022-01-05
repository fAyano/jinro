//
//  GameViewController.swift
//  928
//
//  2021/09/28.
//

import UIKit
import Combine//タイマーを作る

class GameViewController: SuperGameViewController {
    @IBOutlet weak var upbutton: UIButton!
    @IBOutlet weak var rightbutton: UIButton!
    @IBOutlet weak var downbutton: UIButton!
    @IBOutlet weak var leftbutton: UIButton!
    @IBOutlet weak var bombbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnAction(sender: UIButton){
        print("sender.tag\(sender.tag)")
        btn(sender:sender, id:myid, ex:ex[0])
        bomb(sender:sender, id:myid, ex:ex[0])
        showBoard()
        showCharacter()
    }
    
    func bomb(sender:UIButton, id:Int, ex:Int){
        if(sender.tag==5&&number[ex-19]==3||number[ex-18]==3||number[ex-17]==3||number[ex-1]==3||number[ex]==3||number[ex+1]==3||number[ex+17]==3||number[ex+18]==3||number[ex+19]==3||number[ex-19]==4||number[ex-18]==4||number[ex-17]==4||number[ex-1]==4||number[ex]==4||number[ex+1]==4||number[ex+17]==4||number[ex+18]==4||number[ex+19]==4){
                        //t=1
                        //ポイント処理
            doPost(id:id,num:ex,tag:sender.tag)
                        //self.performSegue(withIdentifier: "toLastVC", sender: nil)
        }
    }
}



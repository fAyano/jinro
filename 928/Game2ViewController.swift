//
//  Game2ViewController.swift
//  928
//
//  2021/10/26.
//

import UIKit
import Combine//タイマーを作る

class Game2ViewController: SuperGameViewController {
    @IBOutlet weak var upbutton: UIButton!
    @IBOutlet weak var rightbutton: UIButton!
    @IBOutlet weak var downbutton: UIButton!
    @IBOutlet weak var leftbutton: UIButton!
    
    //let GVC = AbstractGameViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    @IBAction func btnAction(sender: UIButton){
        print("sender.tag\(sender.tag)")
        if(myid==2){
            btn(sender:sender, id:myid, ex:ex[1])
            key(sender:sender, id:myid, ex:ex[1])
        }else{
            btn(sender:sender, id:myid, ex:ex[2])
            crown(sender:sender, id:myid, ex:ex[2])
        }
        showBoard()
        showCharacter()
    }
    
    func key(sender:UIButton, id:Int, ex:Int){
        //上
        if(sender.tag==1&&number[ex-1]==5){
            doPost(id:id,num:ex-1,tag:sender.tag)
            //ポイント処理
        }
        //右
        else if(sender.tag==2&&number[ex+18]==5){
            doPost(id:id,num:ex+18,tag:sender.tag)
        }
        //下
        else if(sender.tag==3&&number[ex+1]==5){
            doPost(id:id,num:ex+1,tag:sender.tag)
        }
        //左
        else if(sender.tag==4&&number[ex-18]==5){
            doPost(id:id,num:ex-18,tag:sender.tag)
        }
    }
    
    func crown(sender:UIButton, id:Int, ex:Int){
        //上
        if(sender.tag==1&&number[ex-1]==6){
            doPost(id:id,num:ex-1,tag:sender.tag)
            //ポイント処理
        }
        //右
        else if(sender.tag==2&&number[ex+18]==6){
            doPost(id:id,num:ex+18,tag:sender.tag)
        }
        //下
        else if(sender.tag==3&&number[ex+1]==6){
            doPost(id:id,num:ex+1,tag:sender.tag)
        }
        //左
        else if(sender.tag==4&&number[ex-18]==6){
            doPost(id:id,num:ex-18,tag:sender.tag)
        }
    }
}



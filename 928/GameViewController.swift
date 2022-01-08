//
//  GameViewController.swift
//  928
//
//  2021/09/28.
//

import UIKit


class GameViewController: SuperGameViewController {
    @IBOutlet weak var upbutton: UIButton!
    @IBOutlet weak var rightbutton: UIButton!
    @IBOutlet weak var downbutton: UIButton!
    @IBOutlet weak var leftbutton: UIButton!
    @IBOutlet weak var bombbutton: UIButton!
    @IBOutlet weak var jinro: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnAction(sender: UIButton){
        print("sender.tag\(sender.tag)")
        btn(sender:sender, id:myid, ex:ex[0], point:point[0])
        if(sender.tag==5){
            bomb(sender:sender, id:myid, ex:ex[0], point:point[0])
        }
        showBoard()
        showCharacter()
    }
    
    func bomb(sender:UIButton, id:Int, ex:Int, point:Int){
        var p=point
        if(number[ex-19]==3||number[ex-18]==3||number[ex-17]==3||number[ex-1]==3||number[ex]==3||number[ex+1]==3||number[ex+17]==3||number[ex+18]==3||number[ex+19]==3){
            if(p==0||p==2){
                p+=1
                //爆弾ボタンを押した時はキャラクターは移動しないのでtagは一つ前のtagをpostする
                doPost(id:id,num:ex,tag:tag[0],point:p)
            }
        }else if(number[ex-19]==4||number[ex-18]==4||number[ex-17]==4||number[ex-1]==4||number[ex]==4||number[ex+1]==4||number[ex+17]==4||number[ex+18]==4||number[ex+19]==4){
            if(p==0||p==1){
                p+=2
                doPost(id:id,num:ex,tag:tag[0],point:p)
            }
        }
    }
}

//プロトコル
extension GameViewController: AbstractClass {
    func task() {
        switch point[0]{
        case 0:
            let image1 = UIImage(named: "jinro1")
            jinro.image = image1
        case 1:
            let image1 = UIImage(named: "jinro2")
            jinro.image = image1
        case 2:
            let image1 = UIImage(named: "jinro3")
            jinro.image = image1
        case 3:
            let image1 = UIImage(named: "jinro4")
            jinro.image = image1
        default:break
        }
    }
}



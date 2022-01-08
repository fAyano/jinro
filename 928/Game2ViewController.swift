//
//  Game2ViewController.swift
//  928
//
//  2021/10/26.
//

import UIKit

class Game2ViewController: SuperGameViewController {
    @IBOutlet weak var upbutton: UIButton!
    @IBOutlet weak var rightbutton: UIButton!
    @IBOutlet weak var downbutton: UIButton!
    @IBOutlet weak var leftbutton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var item1: UIImageView!
    @IBOutlet weak var item2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    @IBAction func btnAction(sender: UIButton){
        print("sender.tag\(sender.tag)")
        if(myid==2){
            btn(sender:sender, id:myid, ex:ex[1], point:point[1])
            key(sender:sender, id:myid, ex:ex[1], point:point[1])
        }else{
            btn(sender:sender, id:myid, ex:ex[2], point:point[2])
            crown(sender:sender, id:myid, ex:ex[2], point:point[2])
        }
        showBoard()
        showCharacter()
    }
    
    func key(sender:UIButton, id:Int, ex:Int, point:Int){
        //引数はデフォルトで定数扱いになるので変数として新たに定義し、書き換え可能にする
        var p=point
        //上
        if(sender.tag==1&&number[ex-1]==5){
            p=1
            doPost(id:id,num:ex-1,tag:sender.tag,point:p)
        }
        //右
        else if(sender.tag==2&&number[ex+18]==5){
            p=1
            doPost(id:id,num:ex+18,tag:sender.tag,point:p)
        }
        //下
        else if(sender.tag==3&&number[ex+1]==5){
            p=1
            doPost(id:id,num:ex+1,tag:sender.tag,point:p)
        }
        //左
        else if(sender.tag==4&&number[ex-18]==5){
            p=1
            doPost(id:id,num:ex-18,tag:sender.tag,point:p)
        }
    }
    
    func crown(sender:UIButton, id:Int, ex:Int, point:Int){
        var p=point
        //上
        if(sender.tag==1&&number[ex-1]==6){
            p=1
            doPost(id:id,num:ex-1,tag:sender.tag,point:p)
        }
        //右
        else if(sender.tag==2&&number[ex+18]==6){
            p=1
            doPost(id:id,num:ex+18,tag:sender.tag,point:p)
        }
        //下
        else if(sender.tag==3&&number[ex+1]==6){
            p=1
            doPost(id:id,num:ex+1,tag:sender.tag,point:p)
        }
        //左
        else if(sender.tag==4&&number[ex-18]==6){
            p=1
            doPost(id:id,num:ex-18,tag:sender.tag,point:p)
        }
    }
}

//プロトコル
extension Game2ViewController: AbstractClass {
    func task() {
        if(myid==2){
            switch(point[1],point[2]){
            case(0,0):
                let image1 = UIImage(named: "key1")
                item1.image = image1
                let image2 = UIImage(named: "crown1")
                item2.image = image2
            case(1,0):
                let image1 = UIImage(named: "key2")
                item1.image = image1
                let image2 = UIImage(named: "crown1")
                item2.image = image2
            case(0,1):
                let image1 = UIImage(named: "key1")
                item1.image = image1
                let image2 = UIImage(named: "crown2")
                item2.image = image2
            case(1,1):
                let image1 = UIImage(named: "key2")
                item1.image = image1
                let image2 = UIImage(named: "crown2")
                item2.image = image2
            default:break
            }
        }else{
            switch(point[1],point[2]){
            case(0,0):
                let image1 = UIImage(named: "key3")
                item1.image = image1
                let image2 = UIImage(named: "crown3")
                item2.image = image2
            case(1,0):
                let image1 = UIImage(named: "key4")
                item1.image = image1
                let image2 = UIImage(named: "crown3")
                item2.image = image2
            case(0,1):
                let image1 = UIImage(named: "key3")
                item1.image = image1
                let image2 = UIImage(named: "crown4")
                item2.image = image2
            case(1,1):
                let image1 = UIImage(named: "key4")
                item1.image = image1
                let image2 = UIImage(named: "crown4")
                item2.image = image2
            default:break
            }
        }
    }
}



//
//  GameViewController.swift
//  928
//
//  Created by 藤澤彩乃 on 2021/09/28.
//

import UIKit
import Combine//タイマーを作る

class GameViewController: UIViewController {
    @IBOutlet weak var upbutton: UIButton!
    @IBOutlet weak var rightbutton: UIButton!
    @IBOutlet weak var downbutton: UIButton!
    @IBOutlet weak var leftbutton: UIButton!
    @IBOutlet weak var bombbutton: UIButton!
    var updateLabelCancellable: AnyCancellable?//タイマー
    var id:Int = 0//自分のid
    var id1:Int = 1
    var id2:Int = 2
    var id3:Int = 3
    var ex:Int = 19//１つ前のプレイヤーの配列番号
    var ex2:Int = 33
    var ex3:Int = 289
    var ls:Int = 40//ラベルのサイズ
    var t:Int = 1//データ通信の回数
    //-----
    var labelArray: [UILabel] = []
    var labelArray2: [UILabel] = []
    var number: [Int] = []
    //-----
    override func viewDidLoad() {
        
        // ---Combineでタイマーを作る---
        updateLabelCancellable = Timer
            .publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [self] (date) in
                if(t==1){
                    //位置情報の初期化
                    doPost(id:id1,num:ex)
                    doPost(id:id2,num:ex2)
                    doPost(id:id3,num:ex3)
                }
                doGet()
                for i in 0..<324 {
                    chooseColor(a:i)
                }
                number[ex]=2
                number[ex2]=3
                number[ex3]=4
                chooseColor2(a:ex)
                chooseColor2(a:ex2)
                chooseColor2(a:ex3)
                if(t>1){
                    showBoard()
                }
                t+=1
            })
        //-------
    
        super.viewDidLoad()
        var a:Int = 0
        
        //背景 0→壁, 1→動ける範囲, 2→プレイヤー, 3→敵, 4->プレイヤー2
        number = [0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,
                  0,2,1,1,0, 1,1,1,1,1, 1,1,1,1,0, 3,1,0,
                  0,1,1,1,0, 1,1,1,1,1, 1,1,1,1,0, 1,1,0,
                  0,1,1,1,0, 1,1,1,1,1, 1,1,1,1,0, 1,1,0,
                  0,1,1,1,0, 1,1,1,1,1, 1,1,1,1,0, 1,1,0,
                  
                  0,1,1,1,0, 1,1,0,0,0, 1,1,1,1,0, 1,1,0,
                  0,1,1,1,0, 1,1,0,1,1, 1,1,1,1,0, 1,1,0,
                  0,1,1,1,0, 1,1,0,1,1, 1,1,1,1,0, 1,1,0,
                  0,1,1,1,0, 0,0,0,1,1, 1,1,1,1,0, 1,1,0,
                  0,1,1,1,1, 1,1,1,1,1, 1,1,0,0,0, 1,1,0,
                  
                  0,1,1,1,1, 1,1,1,1,1, 1,1,0,1,1, 1,1,0,
                  0,0,0,0,0, 0,0,1,1,1, 1,1,0,1,1, 1,1,0,
                  0,1,1,1,1, 1,0,1,1,1, 1,1,0,1,1, 1,1,0,
                  0,1,1,1,1, 1,0,1,1,1, 1,1,0,1,1, 1,1,0,
                  0,1,1,1,1, 1,0,0,0,1, 1,1,1,1,1, 1,1,0,
                  
                  0,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,0,
                  0,4,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,0,
                  0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,
                ]

        for x in 1...18 {
            for y in 1...18 {
                let label = UILabel()
                let label2 = UILabel()
                label.frame = CGRect(x: x*ls-10, y: y*ls+100, width: ls, height: ls)
                label2.frame = CGRect(x: 27+8*x, y: y*8+550, width: 8, height: 8)
                //ラベルの位置を確認
                //label.text = String("\(x),\(y)")
                label.textAlignment = NSTextAlignment.center
                label.textColor = UIColor.white
                //ラベルを配列に入れる
                labelArray.append(label)
                labelArray2.append(label2)
                //色を決める
                chooseColor(a:a)
                a+=1
            }
        }
        showBoard()
    }
    
    @IBAction func btnAction(sender: UIButton){
        print("sender.tag\(sender.tag)")
        //上
        if(sender.tag==1){
            if(number[ex-1]==1){
                doPost(id:id,num:ex-1)
            }
        }
        //右
        if(sender.tag==2){
            if(number[ex+18]==1){
                doPost(id:id,num:ex+18)
            }
        }
        //下
        if(sender.tag==3){
            if(number[ex+1]==1){
                doPost(id:id,num:ex+1)
            }
        }
        //左
        if(sender.tag==4){
            if(number[ex-18]==1){
                doPost(id:id,num:ex-18)
            }
        }
        //爆弾ボタン
        if(sender.tag==5){
            if(number[ex-19]==3||number[ex-18]==3||number[ex-17]==3||number[ex-1]==3||number[ex]==3||number[ex+1]==3||number[ex+17]==3||number[ex+18]==3||number[ex+19]==3||number[ex-19]==4||number[ex-18]==4||number[ex-17]==4||number[ex-1]==4||number[ex]==4||number[ex+1]==4||number[ex+17]==4||number[ex+18]==4||number[ex+19]==4){
                t=1
                ex=0
                doPost(id:id,num:ex)
                self.performSegue(withIdentifier: "toLastVC", sender: nil)
            }
        }
        showBoard()
    }
    //POST
    func doPost(id:Int, num:Int){
        //URLを設定
        guard let req_url = URL(string: "http://xr03.tsuda.ac.jp:8080/Test/TestServlet")
            else{return}
        //print("urlセット完了")
        //リクエストに必要な情報を宣言
        var req = URLRequest(url: req_url)
        //print("リクエストの宣言")
        //POSTを指定
        req.httpMethod = "POST"
        //POSTするデータをBODYとして設定
        req.httpBody = "test=\(id)\(num)".data(using: .utf8)
        //sessionの作成
        let session = URLSession(configuration: .default,delegate: nil, delegateQueue: OperationQueue.main)
        //print("sessionの作成")
        //リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data, response ,error) in
        })
        //request送信
        task.resume()
    }
    //GET
    func doGet(){
        URLSession.shared.dataTask(with: URL(string: "http://xr03.tsuda.ac.jp:8080/Test/TestServlet")!) { [self] data, response, error in
            guard let d = data, let s = String(data: d, encoding: .utf8) else { return }
        //string->int
            var n=0
            var thisid=0
            for num in s {
                print("\(n): \(num)")
                if(n==1||n==2||n==3||n==4){
                    if let intValue = num.wholeNumberValue {
                        //print("Value is \(intValue)")
                        if(n==1){
                            thisid=intValue
                        }else if(n==2){
                            if(thisid==1){
                                ex=intValue
                                print(ex)
                            }else if(thisid==2){
                                ex2=intValue
                                print(ex2)
                            }else if(thisid==3){
                                ex3=intValue
                                print(ex3)
                            }
                        }else if(n==3||n==4){
                            if(thisid==1){
                                ex*=10
                                ex+=intValue
                                print("ex\(ex)")
                            }else if(thisid==2){
                                ex2*=10
                                ex2+=intValue
                                print("ex2\(ex2)")
                            }else if(thisid==3){
                                ex3*=10
                                ex3+=intValue
                                print("ex3\(ex3)")
                            }
                        }
                    } else {
                        print("Not an integer")
                    }
                }
                n+=1;
            }
        }.resume()
    }
    //色を決める
    func chooseColor(a:Int){
        if(number[a]==0){
            //labelArray[a].backgroundColor = UIColor.black
            labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "wall")!)
            labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "wall2")!)
        }else{
            number[a]=1
            labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "floor")!)
            labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "floor")!)
        }
    }
    func chooseColor2(a:Int){
        if(number[a]==2){
            labelArray[a].backgroundColor = UIColor.blue
            labelArray2[a].backgroundColor = UIColor.blue
        }else if(number[a]==3){
            labelArray[a].backgroundColor = UIColor.red
            labelArray2[a].backgroundColor = UIColor.red
        }else if(number[a]==4){
            labelArray[a].backgroundColor = UIColor.green
            labelArray2[a].backgroundColor = UIColor.green
        }
    }
    //表示する
    func showBoard() {
        //配列に入ったラベルの表示
        for label in labelArray2 {
            view.addSubview(label)
        }
        var s:Int = 0//画面上に移す配列番号
        if(ex>=18*4&&ex<=18*13){
            s=ex-18*4-ex%18
            //print("s\(s)")
        }else if(ex>=18*4){
            s=18*9
            //print("s2\(s)")
        }
        if(ex%18>=4&&ex%18<=13){
            s+=ex%18-4
        }else if(ex%18>=4){
            s+=9
        }
        for x in 1...9 {
            for y in 1...9 {
                labelArray[s].frame = CGRect(x: x*ls-10, y: y*ls+100, width: ls, height: ls)
                view.addSubview(labelArray[s])
                s+=1
            }
            s+=9
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


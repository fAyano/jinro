//
//  GameViewController.swift
//  928
//
//  2021/09/28.
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
        
        //背景 0→壁, 1→動ける範囲, 2→プレイヤー, 3→プレイヤー2, 4→プレイヤー3, 5→池, 6→テント, 7→物干し竿
        number = [0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,
                  0,2,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 3,1,0,
                  0,1,1,1,1, 0,0,0,0,0, 1,1,1,1,1, 1,1,0,
                  0,1,1,1,1, 0,5,5,5,0, 1,1,6,6,6, 1,1,0,
                  0,1,1,1,1, 0,5,5,5,0, 1,6,6,6,6, 1,1,0,
                  
                  0,1,1,1,1, 0,0,0,5,0, 1,6,6,6,6, 1,1,0,
                  0,1,1,1,1, 1,1,1,0,0, 1,1,6,6,6, 1,1,0,
                  0,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,0,
                  0,1,1,1,1, 1,1,1,0,0, 1,1,1,1,1, 1,1,0,
                  0,1,1,1,1, 1,1,1,0,5, 0,0,1,1,1, 1,1,0,
                  
                  0,1,1,1,1, 1,1,1,0,5, 5,0,1,1,1, 1,1,0,
                  7,7,1,1,1, 1,1,1,0,5, 5,0,1,1,1, 1,1,0,
                  7,7,1,1,1, 1,1,1,0,5, 5,0,1,1,1, 1,1,0,
                  7,7,1,1,6, 6,6,1,0,0, 0,0,1,1,1, 1,1,0,
                  0,1,1,6,6, 6,6,1,1,1, 1,1,1,1,1, 1,1,0,
                  
                  0,1,1,6,6, 6,6,1,1,1, 1,1,1,1,1, 1,1,0,
                  0,4,1,1,6, 6,6,1,1,1, 1,1,1,1,1, 1,1,0,
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
            if(a==0){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_upperleft")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_upperleft2")!)
            }else if(a==17){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_lowerleft")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_lowerleft2")!)
            }else if(a==306){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_upperright")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_upperright2")!)
            }else if(a==323){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_lowerright")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_lowerright2")!)
            }else if(a%18==0){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_top")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_top2")!)
            }else if(a%18==17){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_bottom")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_bottom2")!)
            }else if(a>0&&a<18){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_left")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_left2")!)
            }else if(a>305&&a<324){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_right")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_right2")!)
            //池
            }else if(a==41){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_upperleft")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_upperleft2")!)
            }else if(a>=42&&a<=44||a==172){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_left")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_left2")!)
            }else if(a==95||a==242){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_upperright")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_upperright2")!)
            }else if(a==96||a==97||a==243||a==244){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_right")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_right2")!)
            }else if(a==45||a==173){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_lowerleft")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_lowerleft2")!)
            }else if(a==245){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_lowerright")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_lowerright2")!)
            }else if(a%18==5||a%18==8){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_top")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_top2")!)
            }else if(a%18==9||a%18==11){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_bottom")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake_bottom2")!)
            }else{
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_rf")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass_rf2")!)
            }
        }else if(number[a]==5){
            labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake")!)
            labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "lake2")!)
        }else if(number[a]==6){
            if(a>=238&&a<=240){
            //テント1
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-235+3*(a-238))")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-235+3*(a-238))_2")!)
            }else if(a>=256&&a<=258){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-252+3*(a-256))")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-252+3*(a-256))_2")!)
            }else if(a>=274&&a<=276){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-269+3*(a-274))")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-269+3*(a-274))_2")!)
            }else if(a>=292&&a<=294){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-286+3*(a-292))")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-286+3*(a-292))_2")!)
            }else if(a==255){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent1")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent1_2")!)
            }else if(a==273){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent2")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent2_2")!)
            //テント2
            }else if(a>=66&&a<=69){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-63+3*(a-66))")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-63+3*(a-66))_2")!)
            }else if(a>=84&&a<=87){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-80+3*(a-84))")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-80+3*(a-84))_2")!)
            }else if(a>=102&&a<=105){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-97+3*(a-102))")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-97+3*(a-102))_2")!)
            }else if(a>=120&&a<=123){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-114+3*(a-120))")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent\(a-114+3*(a-120))_2")!)
            }else if(a==83){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent1")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent1_2")!)
            }else if(a==101){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent2")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "tent2_2")!)
            }
        }else if(number[a]==7){
            if(a%18==0){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "laundry\((a-180)/18)")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "laundry\((a-180)/18)_2")!)
            }else if(a%18==1){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "laundry\((a-1)/18-7)")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "laundry\((a-1)/18-7)_2")!)
            }
        }else{
            number[a]=1
            //橋
            if(a>=133&&a<=136){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "bridge")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "bridge2")!)
            //地面
            }else if(a==138||a==110){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "ground_upperleft")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "ground_upperleft2")!)
            }else if(a==156||a==229||a==218){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "ground_upperright")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "ground_upperright2")!)
            }else if(a==142||a==113||a==168){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "ground_lowerleft")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "ground_lowerleft2")!)
            }else if(a==232||a==222){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "ground_lowerright")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "ground_lowerright2")!)
            }else if(a>=139&&a<=141||a>=157&&a<=160||a>=175&&a<=178||a>=193&&a<=196||a>=211&&a<=214||a>=230&&a<=231||a>=111&&a<=112||a>=128&&a<=131||a>=146&&a<=149||a>=164&&a<=167||a>=182&&a<=186||a>=200&&a<=204||a>=219&&a<=221){
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "ground")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "ground2")!)
            }else{
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass")!)
                labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "grass2")!)
            }
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

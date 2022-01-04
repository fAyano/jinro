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
    var updateLabelCancellable: AnyCancellable?//対戦画面のタイマー
    //--id--
    var id:Int = 0//自分
    var id1:Int = 1//プレーヤー1
    var id2:Int = 2//プレーヤー2
    var id3:Int = 3//プレーヤー3
    //----
    //--それぞれのプレーヤーの一つ前の配列番号--
    var ex1:Int = 19
    var ex2:Int = 51
    var ex3:Int = 289
    //----
    //--それぞれのプレーヤーの歩いている向き--
    var tag1:Int=3
    var tag2:Int=1
    var tag3:Int=3
    //----
    //--時間--
    var time1:Int=1
    var time2:Int=1
    var time3:Int=1
    //----
    var ls:Int = 40//ラベルのサイズ
    var t:Int = 1//データ通信の回数
    //---配列--
    var labelArray: [UILabel] = []//メイン画面のキャラクターを表示するために使用
    var labelArray2: [UILabel] = []//全体画面
    var number: [Int] = []//ゲームの移動できる範囲を決めるときに使用
    //-----
    override func viewDidLoad() {
        
        // ---Combineでタイマーを作る---
        updateLabelCancellable = Timer
            .publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [self] (date) in
                if(t==1){
                    //位置情報の初期化
                    doPost(id:id1,num:ex1,tag:tag1)
                    doPost(id:id2,num:ex2,tag:tag2)
                    doPost(id:id3,num:ex3,tag:tag3)
                }
                doGet()
                for i in 0..<324 {
                    chooseColor(a:i)
                }
                number[ex1]=2
                number[ex2]=3
                number[ex3]=4
                chooseColor2(a:ex1)
                chooseColor2(a:ex2)
                chooseColor2(a:ex3)
                if(t>1){
                    showBoard()
                    showCharacter()
                }
                t+=1
            })
        //-------
    
        super.viewDidLoad()
        var a:Int = 0
        
        //歩けない所→0, 歩けるところ→1, プレイヤー1(人狼)→2, プレーヤー2(市民)→3, プレーヤー3(市民)→4, 鍵→5, 冠→6
        number = [0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,
                  0,2,1,1,1, 1,1,1,6,0, 0,0,0,0,0, 0,0,0,
                  0,1,1,1,0, 0,0,1,1,0, 0,0,0,0,1, 1,3,0,
                  0,1,1,0,0, 0,0,1,1,0, 0,0,0,0,1, 1,1,0,
                  0,1,1,0,0, 0,0,1,1,0, 0,0,0,0,1, 1,1,0,
                  
                  0,1,1,1,0, 0,0,1,1,0, 0,0,0,0,1, 1,1,0,
                  0,1,1,1,1, 1,1,1,0,0, 0,0,0,0,0, 1,1,0,
                  0,1,0,1,0, 0,1,1,1,1, 1,1,1,1,1, 1,1,0,
                  0,1,0,1,0, 0,1,1,0,0, 0,0,0,0,0, 1,1,0,
                  0,1,1,1,1, 1,1,1,1,0, 0,0,0,0,0, 1,1,0,
                  
                  0,1,0,1,1, 1,1,1,1,0, 0,0,0,0,0, 1,1,0,
                  0,1,0,1,1, 0,0,0,0,0, 0,0,0,0,0, 1,1,0,
                  0,1,1,1,1, 0,0,0,0,0, 0,0,0,0,1, 1,1,0,
                  0,1,0,1,1, 0,0,0,0,0, 0,0,0,0,1, 5,1,0,
                  0,1,1,1,1, 0,0,0,0,1, 1,1,1,1,1, 0,0,0,
                  
                  0,1,1,1,1, 0,0,0,0,1, 1,1,1,1,0, 0,0,0,
                  0,4,1,1,1, 0,0,0,0,1, 1,1,1,1,1, 0,0,0,
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
        showCharacter()
    }
    
    @IBAction func btnAction(sender: UIButton){
        print("sender.tag\(sender.tag)")
        //上
        if(sender.tag==1){
            if(number[ex1-1]==1){
                doPost(id:id,num:ex1-1,tag:sender.tag)
            }
        }
        //右
        if(sender.tag==2){
            if(number[ex1+18]==1){
                doPost(id:id,num:ex1+18,tag:sender.tag)
            }
        }
        //下
        if(sender.tag==3){
            if(number[ex1+1]==1){
                doPost(id:id,num:ex1+1,tag:sender.tag)
            }
        }
        //左
        if(sender.tag==4){
            if(number[ex1-18]==1){
                doPost(id:id,num:ex1-18,tag:sender.tag)
            }
        }
        //爆弾ボタン
        if(sender.tag==5){
            if(number[ex1-19]==3||number[ex1-18]==3||number[ex1-17]==3||number[ex1-1]==3||number[ex1]==3||number[ex1+1]==3||number[ex1+17]==3||number[ex1+18]==3||number[ex1+19]==3||number[ex1-19]==4||number[ex1-18]==4||number[ex1-17]==4||number[ex1-1]==4||number[ex1]==4||number[ex1+1]==4||number[ex1+17]==4||number[ex1+18]==4||number[ex1+19]==4){
                t=1
                ex1=0
                doPost(id:id,num:ex1,tag:tag1)
                self.performSegue(withIdentifier: "toLastVC", sender: nil)
            }
        }
        showBoard()
        showCharacter()
    }
    //POST
    func doPost(id:Int, num:Int, tag:Int){
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
        req.httpBody = "test=\(id),\(num),\(tag),".data(using: .utf8)
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
            let str:String = s
            print(s)
            // 取得したデータを,で分割する
            let arr:[String] = str.components(separatedBy: ",")
            //arr[0]: id, arr[1]: 配列番号, arr[2]: プレーヤーの歩いている向き
            let id:Int = Int(arr[0])!//string→int
            print("id:\(id)")
            let num:Int = Int(arr[1])!//string→int
            print("num:\(num)")
            switch id{
                case 1:
                    ex1=num
                case 2:
                    ex2=num
                case 3:
                    ex3=num
                default: break
            }
            let tag:Int = Int(arr[2])!//string→int
            print("tag:\(tag)")
            switch id{
                case 1:
                    tag1=tag
                case 2:
                    tag2=tag
                case 3:
                    tag3=tag
                default: break
            }
        }.resume()
    }
    //色を決める
    func chooseColor(a:Int){
        if(number[a]==5){
            labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "key")!)
        }else if(number[a]==6){
            labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "crown")!)
        }else if(number[a] != 0 ){
            number[a]=1
            labelArray[a].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)//背景を透明にする
            labelArray2[a].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        }
    }
    func chooseColor2(a:Int){
        if(number[a]==2){
            switch tag1 {
                case 1:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character1_back\(time1)")!)
                case 2:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character1_right\(time1)")!)
                case 3:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character1_front\(time1)")!)
                case 4:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character1_left\(time1)")!)
                default: break
            }
            if(time1==1){
                time1=2
            }else{
                time1=1
            }
            labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "character1")!)
        }else if(number[a]==3){
            switch tag2 {
                case 1:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character2_back\(time2)")!)
                case 2:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character2_right\(time2)")!)
                case 3:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character2_front\(time2)")!)
                case 4:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character2_left\(time2)")!)
                default: break
            }
            if(time2==1){
                time2=2
            }else{
                time2=1
            }
            labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "character2")!)
        }else if(number[a]==4){
            switch tag3 {
                case 1:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character3_back\(time3)")!)
                case 2:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character3_right\(time3)")!)
                case 3:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character3_front\(time3)")!)
                case 4:
                    labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character3_left\(time3)")!)
                default: break
            }
            if(time3==1){
                time3=2
            }else{
                time3=1
            }
            labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "character3")!)
        }
    }
    //どの位置からメイン画面に表示するかを決める
    func show() -> Int{
        var s:Int = 0//画面上に移す配列番号
        if(ex1>=18*4&&ex1<=18*13){
            s=ex1-18*4-ex1%18
            //print("s\(s)")
        }else if(ex1>=18*4){
            s=18*9
            //print("s2\(s)")
        }
        if(ex1%18>=4&&ex1%18<=13){
            s+=ex1%18-4
        }else if(ex1%18>=4){
            s+=9
        }
        return s
    }
    //キャラクターを表示する
    func showCharacter() {
        //--全体画面を表示する--
        //配列に入ったラベルの表示
        for label in labelArray2 {
            view.addSubview(label)
        }
        //----
        //--メイン画面を表示する--
        var s:Int=show()
        for x in 1...9 {
            for y in 1...9 {
                labelArray[s].frame = CGRect(x: x*ls-10, y: y*ls+100, width: ls, height: ls)
                view.addSubview(labelArray[s])
                s+=1
            }
            s+=9
        }
        //----
    }
    //背景を表示する
    func showBoard(){
        //--全体画面--
        let image2 = UIImage(named: "haikei2")!
        let imageView2 = UIImageView(image: image2)
        imageView2.frame = CGRect(x: 35, y: 558, width: 144, height: 144)
        view.addSubview(imageView2)
        //----
        //--メイン画面--
        let image = UIImage(named: "haikei")!
        let clipRect = CGRect(x: show()/18*40, y: show()%18*40, width: 360, height: 360)//トリミングする
        let cripImageRef = image.cgImage!.cropping(to: clipRect)
        let crippedImage = UIImage(cgImage: cripImageRef!)
        let imageView = UIImageView(image: crippedImage)
        imageView.frame = CGRect(x: 30, y: 140, width: 360, height: 360)//表示する画像の位置と大きさを設定する
        view.addSubview(imageView)
        //----
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

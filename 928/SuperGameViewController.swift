//
//  AbstractGameViewController.swift
//  928
//
//  2022/01/04.
//

import UIKit
import Combine//タイマーを作る

class SuperGameViewController: UIViewController {
    var updateLabelCancellable: AnyCancellable?//タイマー
    var myid : Int = 0//自分のid
    //---配列--
    var labelArray: [UILabel] = []//メイン画面のキャラクターを表示するために使用
    var labelArray2: [UILabel] = []//全体画面
    var number: [Int] = []//ゲームの移動できる範囲を決めるときに使用
    var id:[Int] = [1,2,3]//[プレーヤー1のid, プレーヤー2のid, プレーヤー3のid]
    var ex:[Int] = [19,51,289]//それぞれのプレーヤーの一つ前の配列番号
    var tag:[Int] = [3,1,3]//それぞれのプレーヤーの歩いている向き
    var time: [Int] = [1,1,1]
    var point:[Int] = [0,0,0]
    //-----
    var ls:Int = 40//ラベルのサイズ
    var t:Int = 1//データ通信の回数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ---Combineでタイマーを作る---
        updateLabelCancellable = Timer
            .publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [self] (date) in
                if(t==1){
                    //位置情報の初期化
                    doPost(id:id[0],num:ex[0],tag:tag[0],point:point[0])
                    doPost(id:id[1],num:ex[1],tag:tag[1],point:point[1])
                    doPost(id:id[2],num:ex[2],tag:tag[2],point:point[2])
                }else{
                    doGet()
                    for i in 0..<324 {
                        setBoard(a:i)
                    }
                    for i in 0..<3 {
                        number[ex[i]]=i+2
                        setCharacter(a:ex[i],b:i)
                    }
                    showBoard()
                    showCharacter()
                    //抽象メソッド
                    if let obj = self as? AbstractClass {
                        obj.task()
                    }
                    
                }
                //最終画面に移るか判定
                if(point[0]==3||point[1]==1&&point[2]==1){
                    if(myid==1){
                        self.performSegue(withIdentifier: "toLastVC", sender: nil)
                    }else{
                        self.performSegue(withIdentifier: "toLastVC2", sender: nil)
                    }
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
                label.frame = CGRect(x: x*ls-10, y: y*ls+20, width: ls, height: ls)
                label2.frame = CGRect(x: 27+8*x, y: y*8+430, width: 8, height: 8)
                //ラベルの位置を確認
                //label.text = String("\(x),\(y)")
                //label.text = String("\((x-1)*18+y-1)")
                label.textAlignment = NSTextAlignment.center
                label.textColor = UIColor.white
                //ラベルを配列に入れる
                labelArray.append(label)
                labelArray2.append(label2)
                a+=1
            }
        }
    }
    func btn(sender:UIButton, id:Int, ex:Int, point:Int){
        //上
        if(sender.tag==1&&number[ex-1]==1){
            doPost(id:id,num:ex-1,tag:sender.tag,point:point)
        }
        //右
        else if(sender.tag==2&&number[ex+18]==1){
            doPost(id:id,num:ex+18,tag:sender.tag,point:point)
        }
        //下
        else if(sender.tag==3&&number[ex+1]==1){
            doPost(id:id,num:ex+1,tag:sender.tag,point:point)
        }
        //左
        else if(sender.tag==4&&number[ex-18]==1){
            doPost(id:id,num:ex-18,tag:sender.tag,point:point)
        }
    }
    //POST
    func doPost(id:Int, num:Int, tag:Int, point:Int){
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
        req.httpBody = "test=\(id),\(num),\(tag),\(point),".data(using: .utf8)
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
            //arr[0]: id, arr[1]: 配列番号, arr[2]: プレーヤーの歩いている向き, arr[3]: ポイント
            let id:Int = Int(arr[0])!//string→int
            print("id:\(id)")
            let num:Int = Int(arr[1])!//string→int
            print("num:\(num)")
            let thistag:Int = Int(arr[2])!//string→int
            print("tag:\(thistag)")
            let thispoint:Int = Int(arr[3])!//string→int
            print("point:\(thispoint)")
            ex[id-1]=num
            tag[id-1]=thistag
            if(point[id-1]<thispoint){
                point[id-1]=thispoint
            }
        }.resume()
    }
    //市民が集めるアイテムを表示、一つ前の動作のキャラクターが残っているので削除
    func setBoard(a:Int){
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
    //どの画像を選ぶかを決める
    func setCharacter(a:Int,b:Int){
        switch tag[b]{
            case 1:
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character\(b+1)_back\(time[b])")!)
            case 2:
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character\(b+1)_right\(time[b])")!)
            case 3:
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character\(b+1)_front\(time[b])")!)
            case 4:
                labelArray[a].backgroundColor = UIColor(patternImage: UIImage(named: "character\(b+1)_left\(time[b])")!)
            default: break
        }
        if(time[b]==1){
            time[b]=2
        }else{
            time[b]=1
        }
        labelArray2[a].backgroundColor = UIColor(patternImage: UIImage(named: "character\(b+1)")!)
    }
    //どの位置からメイン画面に表示するかを決める
    func show() -> Int{
        var s:Int = 0//メイン画面の左上に表示する配列番号
        if(ex[myid-1]>=18*4&&ex[myid-1]<=18*13){
            s=ex[myid-1]-18*4-ex[myid-1]%18
        }else if(ex[myid-1]>=18*4){
            s=18*9
        }
        if(ex[myid-1]%18>=4&&ex[myid-1]%18<=13){
            s+=ex[myid-1]%18-4
        }else if(ex[myid-1]%18>=4){
            s+=9
        }
        return s
    }
    //ラベルを表示する
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
                labelArray[s].frame = CGRect(x: x*ls-10, y: y*ls+20, width: ls, height: ls)
                view.addSubview(labelArray[s])
                s+=1
            }
            s+=9
        }
        //----
    }
    //背景(imageView)を表示する
    func showBoard(){
        //--全体画面--
        let image2 = UIImage(named: "haikei2")!
        let imageView2 = UIImageView(image: image2)
        imageView2.frame = CGRect(x: 35, y: 438, width: 144, height: 144)
        view.addSubview(imageView2)
        //----
        //--メイン画面--
        let image = UIImage(named: "haikei")!
        let clipRect = CGRect(x: show()/18*40, y: show()%18*40, width: 360, height: 360)//トリミングする
        let cripImageRef = image.cgImage!.cropping(to: clipRect)
        let crippedImage = UIImage(cgImage: cripImageRef!)
        let imageView = UIImageView(image: crippedImage)
        imageView.frame = CGRect(x: 30, y: 60, width: 360, height: 360)//表示する画像の位置と大きさを設定する
        view.addSubview(imageView)
        //----
    }
    //勝敗の結果の値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let LastVC = segue.destination as! LastViewController
        if(point[0]==3){
            if(myid==1){
                LastVC.name="人狼"
                LastVC.win = true
            }else{
                LastVC.name="市民"
                LastVC.win = false
            }
        }else if(point[1]==1&&point[2]==1){
            if(myid==2||myid==3){
                LastVC.name="市民"
                LastVC.win = true
            }else{
                LastVC.name="人狼"
                LastVC.win = false
            }
        }
    }
}

//プロトコルの実装
protocol AbstractClass: class{
    func task()
}

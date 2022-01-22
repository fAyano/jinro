//
//  CharacterViewController.swift
//  928
//
//  2021/10/26.
//

import UIKit
import Combine//タイマーを作る
class CharacterViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var okLabel: UIButton!
    @IBOutlet weak var image: UIImageView!
    var id:Int = 0
    var updateLabelCancellable: AnyCancellable?//タイマー
    var t:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doGet()
        //一定時間画像を交互に表示する
        updateLabelCancellable = Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [self] (date) in
                if(self.t%2==0){
                    image.image = UIImage(named: "jinro")
                }else{
                    image.image = UIImage(named: "shimin")
                }
                t+=1
                if(t>25){
                    updateLabelCancellable?.cancel()//タイマーを止める
                    if(id%3==1){
                        idLabel.text = "あなたは人狼です"
                        image.image = UIImage(named: "jinro")
                    }else{
                        idLabel.text = "あなたは市民です"
                        image.image = UIImage(named: "shimin")
                    }
                    print("id\(id)")
                }
            })
    }
    //idの値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(id%3==1){
            let GameVC = segue.destination as! GameViewController
            GameVC.myid = 1
        }else if(id%3==2){
            let GameVC = segue.destination as! Game2ViewController
            GameVC.myid = 2
        }else if(id%3==0){
            let GameVC = segue.destination as! Game2ViewController
            GameVC.myid = 3
        }
    }
    //GET
    func doGet(){
        URLSession.shared.dataTask(with: URL(string: "http://xr03.tsuda.ac.jp:8080/ID/IDServlet")!) { [self] data, response, error in
            guard let d = data, let s = String(data: d, encoding: .utf8) else { return }
            let str:String = s
            print(s)
            // 取得したデータを,で分割する
            let arr:[String] = str.components(separatedBy: ",")
            id = Int(arr[0])!//string→int
            print("-------")                                                                                   
            print("id:\(id)")
            print("-------")                                                                                               
        }.resume()
    }
    
    @IBAction func btnAction(sender: UIButton){
        if(id%3==1){
            self.performSegue(withIdentifier: "toGameVC", sender: nil)
        }else{
            self.performSegue(withIdentifier: "toGame2VC", sender: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

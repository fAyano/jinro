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
                        print("--------")
                        print("id\(id)")
                        print("--------")
                    }else{
                        idLabel.text = "あなたは市民です"
                        image.image = UIImage(named: "shimin")
                        print("--------")
                        print("id\(id)")
                        print("--------")
                    }
                }
            })
    }
    //idの値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(id%3==1){
            let GameVC = segue.destination as! GameViewController
            GameVC.id = id%3
        }else if(id%3==2){
            let GameVC = segue.destination as! Game2ViewController
            GameVC.id = id%3
        }else if(id%3==0){
            let GameVC = segue.destination as! Game2ViewController
            GameVC.id = 3
        }
    }
    //GET
    func doGet(){
        URLSession.shared.dataTask(with: URL(string: "http://xr03.tsuda.ac.jp:8080/ID/IDServlet")!) { [self] data, response, error in
            guard let d = data, let s = String(data: d, encoding: .utf8) else { return }
        //string->int
            var n=0
            for num in s {
                print("\(n): \(num)")
                if(n>=1&&n<=3){
                    if let intValue = num.wholeNumberValue {
                        if(n==1){
                            id=intValue
                        }else if(n==2){
                            id*=10
                            id+=intValue
                            print(id)
                        }else if(n==3){
                            id*=10
                            id+=intValue
                            print(id)
                        }
                    } else {
                        print("Not an integer")
                    }
                }
                n+=1;
            }
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

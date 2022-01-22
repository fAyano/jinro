//
//  LastViewController.swift
//  928
//
//  2021/09/29.
//

import UIKit

class LastViewController: UIViewController {
    var win:Bool = true//勝ち→true, 負け→false
    var name:String = ""
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(win==true){
            messageLabel.text = "\(name)の勝ち!おめでとう!"
            let image = UIImage(named: "win")
            imageView.image = image
        }else{
            messageLabel.text = "\(name)の負け、、😢"
            let image = UIImage(named: "lose")
            imageView.image = image
        }
    }
    @IBAction func toTopButtonAction(_sender: Any){
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
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

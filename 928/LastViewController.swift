//
//  LastViewController.swift
//  928
//
//  2021/09/29.
//

import UIKit

class LastViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

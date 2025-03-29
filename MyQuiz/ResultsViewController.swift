//
//  ResultsViewController.swift
//  MyQuiz
//
//  Created by Sobha Khadka on 2025-03-28.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var stat: UILabel!
    
    var finalScore : Int = 0
    var statis : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score.text = String(finalScore)
        stat.text = statis
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func done(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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

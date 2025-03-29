//
//  AddQuestionsViewController.swift
//  MyQuiz
//
//  Created by Sobha Khadka on 2025-03-21.
//

import UIKit

class AddQuestionsViewController: UIViewController{
    
    
    var questionClass : QuestionManager?
    
    var question : Question?
    
    var isNew : Bool = true
    
    var index : Int = -1
    
    @IBOutlet weak var questionText: UITextField!
    
    @IBOutlet weak var correctAnswerText: UITextField!
    
    @IBOutlet weak var incorrectAnswerText1: UITextField!
    
    @IBOutlet weak var incorrectAnswerText2: UITextField!
    
    @IBOutlet weak var incorrectAnswerText3: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionClass = ((UIApplication.shared.delegate) as! AppDelegate).QuestionModel
        
        if let goodQuestion = question {
            fieldfill(goodQuestion)
        }
        // Do any additional setup after loading the view.
    }
    
    func fieldfill(_ Question: Question) {
        questionText.text = Question.questionText
        correctAnswerText.text = Question.correctAnswer
        incorrectAnswerText1.text = Question.incorrectAnswers[0]
        incorrectAnswerText2.text = Question.incorrectAnswers[1]
        incorrectAnswerText3.text = Question.incorrectAnswers[2]
    }
    
    @IBAction func saveQuestion(_ sender: UIButton) {
        if(questionText.text=="" || correctAnswerText?.text=="" || incorrectAnswerText1.text=="" || incorrectAnswerText2.text=="" || incorrectAnswerText3.text==""){
            let alert = UIAlertController(title: "Empty Feilds Empty!!", message: "No field should be left empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                let newQuestion = Question(questionText: (self.questionText?.text)!, correctAnswer: (self.correctAnswerText?.text)!, incorrectAnswers: [(self.incorrectAnswerText1?.text)!, (self.incorrectAnswerText2?.text)!, (self.incorrectAnswerText3?.text)!])
                if(self.isNew) {
                    self.questionClass?.addQuestion(newQuestion)
                } else {
                    self.questionClass?.updateQuestion(at: self.index, with: newQuestion)
                }
                self.dismiss(animated: true)
            }))
            present(alert, animated: true)
            
            
//            dismiss(animated: true)
        }
    }
    
    @IBAction func cancelChanges(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in self.dismiss(animated: true)}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
        
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

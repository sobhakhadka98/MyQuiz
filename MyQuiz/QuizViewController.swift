//
//  QuizViewController.swift
//  MyQuiz
//
//  Created by Sobha Khadka on 2025-03-28.
//

import UIKit

class QuizViewController: UIViewController {
    
    var questionClass : QuestionManager?
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var option1Button: UIButton!
    
    @IBOutlet weak var option2Button: UIButton!
    
    @IBOutlet weak var option3Button: UIButton!
    
    @IBOutlet weak var option4button: UIButton!
    
    @IBOutlet weak var previousButtonOutlet: UIButton!
    
    @IBOutlet weak var finishButtonOutlet: UIButton!
    
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    @IBOutlet weak var progress: UIProgressView!
    
    let normalImage = UIImage(systemName: "circle")
    let selectedImage = UIImage(systemName: "circle.inset.filled")
    
    
    var questions: [Question] = []
    var currentQuestionIndex = 0
    var selectedAnswers: [UUID: String] = [:]
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionClass = ((UIApplication.shared.delegate) as! AppDelegate).QuestionModel
        questions = QuestionManager.shared.getShuffledQuestions()
        print("total questions \(questions.count)")
        if(questions.count>0){
            updateUI()
        } else {
            questionLabel.text = "No questions added yet"
            let buttons = [option1Button, option2Button, option3Button, option4button, previousButtonOutlet, finishButtonOutlet, nextButtonOutlet, progress]
            
            for button in buttons {
                button?.isHidden = true
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        let question = questions[currentQuestionIndex]
        
        if let answer = sender.currentTitle {
            selectedAnswers[question.id] = answer
        }
        
        let buttons = [option1Button, option2Button, option3Button, option4button]
        
        for button in buttons {
            button?.backgroundColor = UIColor.systemCyan
            button?.setImage(normalImage, for: .normal)
        }
        
        sender.backgroundColor = UIColor.systemBlue
        sender.setImage(selectedImage, for: .normal)
    }
    
    
    @IBAction func prevButton(_ sender: UIButton) {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            updateUI()
        }
    }
    
    @IBAction func finishButton(_ sender: UIButton) {
        calculateScore()
        performSegue(withIdentifier: "showScoreSegue", sender: nil)
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            updateUI()
        }
    }
    
    func calculateScore() {
        score = 0
        for question in questions {
            if let selectedAnswer = selectedAnswers[question.id], selectedAnswer == question.correctAnswer {
                score += 1
            }
        }
        print("score is \(score)")
    }
    
    
    func updateUI(){
        let question = questions[currentQuestionIndex]
        questionLabel.text = question.questionText
        print("index \(currentQuestionIndex)")
        let currentProgress = Float(currentQuestionIndex)/Float(questions.count);
        print(currentProgress)
        progress.setProgress(currentProgress, animated: true)
        
        let answers = question.getAllAnswersShuffled()
        
        let buttons = [option1Button, option2Button, option3Button, option4button]
        
        for button in buttons {
            button?.backgroundColor = UIColor.systemCyan
            button?.setImage(normalImage, for: .normal)
        }
        
        option1Button.setTitle(answers[0], for: .normal)
        option2Button.setTitle(answers[1], for: .normal)
        option3Button.setTitle(answers[2], for: .normal)
        option4button.setTitle(answers[3], for: .normal)
        
        if let selected = selectedAnswers[question.id] {
            for button in buttons {
                if button?.currentTitle == selected {
                    button?.backgroundColor = UIColor.systemBlue
                    button?.setImage(selectedImage, for: .normal)
                }
            }
        }
        
        
        previousButtonOutlet.isHidden = (currentQuestionIndex == 0)
        nextButtonOutlet.isHidden = (currentQuestionIndex == questions.count - 1)
        finishButtonOutlet.isHidden = (currentQuestionIndex != questions.count - 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        calculateScore()
        if let finalScore = segue.destination as? ResultsViewController {
            finalScore.finalScore = score
            finalScore.statis = "\(score) correct answers out of \(questions.count)"
        }
//        dismiss(animated: true)
    }
    
    @IBAction func Home(_ sender: Any) {
        dismiss(animated: true)
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

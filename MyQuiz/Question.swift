//
//  Question.swift
//  MyQuiz
//
//  Created by Sobha Khadka on 2025-03-21.
//

import Foundation

protocol QuestionDelegate {
    func addNewQueston()
    func updateQuestion()
}

class Question {
    var id : UUID = UUID()
    var questionText : String = ""
    var correctAnswer : String = ""
    var incorrectAnswers : [String] = []
    
    init(questionText: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.questionText = questionText
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
    }
    
    func getAllAnswersShuffled() -> [String] {
        return (incorrectAnswers + [correctAnswer]).shuffled()
    }
}

class QuestionManager {
    
    static var shared : QuestionManager = QuestionManager()
    
    var questionList : [Question] = []
    
    var questionDataSource : QuestionDelegate?
    
    func addQuestion(_ question: Question) {
        questionList.append(question)
        questionDataSource?.addNewQueston()
    }
    
    func updateQuestion(at index: Int, with question: Question) {
        print("updating question \(index) with \(question)")
        print("number of ques : \(questionList.count)")
        if index<questionList.count {
            questionList[index] = question
            questionDataSource?.updateQuestion()
        }
    }
    
    func getShuffledQuestions() -> [Question] {
        return questionList.shuffled()
    }
    
    func getquestion(at index: Int) -> Question? {
        return (index >= 0 && index < questionList.count) ? questionList[index] : nil
    }
}



//
//  QuestionsTableViewController.swift
//  MyQuiz
//
//  Created by Sobha Khadka on 2025-03-21.
//

import UIKit

class QuestionsTableViewController: UITableViewController, QuestionDelegate {
    func addNewQueston() {
        tableView.reloadData()
    }
    
    func updateQuestion() {
        tableView.reloadData()
    }
    
    var questionClass : QuestionManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        questionClass = ((UIApplication.shared.delegate) as! AppDelegate).QuestionModel
        QuestionManager.shared.questionDataSource = self


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (questionClass?.questionList.count)!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! QuestionsTableViewCell
        if let goodQuestions = questionClass?.questionList[indexPath.row] {
            cell.questionText.text = "\(goodQuestions.questionText)"
            cell.correctAnswer.text = "\(goodQuestions.correctAnswer)"
            cell.incorrectAnswer1.text = "\(goodQuestions.incorrectAnswers[0])"
            cell.incorrectAnswer2.text = "\(goodQuestions.incorrectAnswers[1])"
            cell.incorrectAnswer3.text = "\(goodQuestions.incorrectAnswers[2])"
        }
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AddQuestionsViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                if let goodQuestion = QuestionManager.shared.getquestion(at: indexPath.row) {
                    destinationVC.question = goodQuestion
                    destinationVC.isNew = false
                    destinationVC.index = indexPath.row
                }
            }
                
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

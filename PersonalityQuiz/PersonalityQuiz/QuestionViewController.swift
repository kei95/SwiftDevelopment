//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Yamashtia Keisuke on 2019-08-29.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers: [Answer(text: "Steak", type: .dog),
                            Answer(text: "Fish", type: .cat),
                            Answer(text: "Carrots", type: .rabbit),
                            Answer(text: "Corn", type: .turtle)]),
        Question(text: "Which activitys do you enjoy?",
                 type: .multiple,
                 answers: [Answer(text: "Swimming", type: .turtle),
                            Answer(text: "Sleeping", type: .cat),
                            Answer(text: "Cuddling", type: .rabbit),
                            Answer(text: "Eating", type: .dog)]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [Answer(text: "I dislike them", type: .cat),
                            Answer(text: "I get a little nervous", type: .rabbit),
                            Answer(text: "I barely notice them", type: .turtle),
                            Answer(text: "I love them", type: .dog)])
    ]
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    
    @IBOutlet var singleQuestin: UIStackView!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    
    @IBOutlet var multipleQuestion: UIStackView!
    @IBOutlet var multipleLabel1: UILabel!
    @IBOutlet var multipleLabel2: UILabel!
    @IBOutlet var multipleLabel3: UILabel!
    @IBOutlet var multipleLabel4: UILabel!
    
    @IBOutlet var switch1: UISwitch!
    @IBOutlet var switch2: UISwitch!
    @IBOutlet var switch3: UISwitch!
    @IBOutlet var switch4: UISwitch!
    
    
    @IBOutlet var rangedQuestion: UIStackView!
    @IBOutlet var slider: UISlider!
    @IBOutlet var rangedLabel2: UILabel!
    @IBOutlet var rangedLabel3: UILabel!
    @IBOutlet var rangedBtn: UIButton!
    

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        singleQuestin.isHidden = true
        multipleQuestion.isHidden = true
        rangedQuestion.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionLabel.text = currentQuestion.text
        progressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    func updateSingleStack(using answers: [Answer]){
        singleQuestin.isHidden = false
        btn1.setTitle(answers[0].text, for: .normal)
        btn2.setTitle(answers[1].text, for: .normal)
        btn3.setTitle(answers[2].text, for: .normal)
        btn4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]){
        multipleQuestion.isHidden = false
        switch1.isOn = false
        switch2.isOn = false
        switch3.isOn = false
        switch4.isOn = false
        multipleLabel1.text = answers[0].text
        multipleLabel2.text = answers[1].text
        multipleLabel3.text = answers[2].text
        multipleLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedQuestion.isHidden = false
        slider.setValue(0.5, animated: false)
        rangedLabel2.text = answers.first?.text
        rangedLabel3.text = answers.last?.text
        
    }
    @IBAction func singleAnswerBtnPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case btn1:
            answersChosen.append(currentAnswers[0])
        case btn2:
            answersChosen.append(currentAnswers[1])
        case btn3:
            answersChosen.append(currentAnswers[2])
        case btn4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func multipleAnswerBtnPressed(_ sender: Any) {
    let currentAnswers = questions[questionIndex].answers
        
        if switch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if switch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if switch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if switch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
    }

    @IBAction func rangedAnswerBtnPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        let index = Int(round(slider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
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

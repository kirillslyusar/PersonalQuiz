//
//  ViewController.swift
//  PersonalQuiz
//
//  Created by Кирилл Слюсарь on 16.05.2023.
//

import UIKit

class QuationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var quastionProgressView: UIProgressView!
    @IBOutlet var qastionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtoms: [UIButton]!
    
    @IBOutlet var maltipeStackView: UIStackView!
    @IBOutlet var multipeLabels: [UILabel]!
    @IBOutlet var maltipeSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    
    @IBOutlet var rangeLabels: [UILabel]!
    @IBOutlet var rangeSlider: UISlider!
    
    
    
    // MARK: - Private properties
    private let quastions = Quation.getQuation()
    private var quastionIndex = 0
    private var currentAnswers :[Answer] {
        quastions[quastionIndex].answers
    }
    private var answerChosen : [Answer] = []
 
    
    // MARK: View Life Curcle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
        
        let answerCount = Float(currentAnswers.count - 1)
        rangeSlider.maximumValue = answerCount
        rangeSlider.value = answerCount / 2
        
        
    }
    
    // MARK: - IBAction
    
    @IBAction func singleAnswerButtonPresed(_ sender: UIButton) {
        guard let buttonIndex =  singleButtoms.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answerChosen.append(currentAnswer)
        
        
        goToNextQuastion()
    }
    
    
    @IBAction func multipeAnswerButtonPresed() {
        
        for (multupleSwitch, answer) in zip(maltipeSwitches, currentAnswers) {
            if multupleSwitch.isOn {
                answerChosen.append(answer)
            }
        }
        
        goToNextQuastion()
    }
    
    
    @IBAction func rangeAnswerButtonPressed() {
        
        let index = lrintf(rangeSlider.value)
        answerChosen.append(currentAnswers[index])
        goToNextQuastion()
    }
    
    deinit {
        print("QuationViewController выгружен")
    }
}



    // MARK: - Private Methods
    private extension QuationViewController {
        func updateUI() {
            
            for stackView in [singleStackView, maltipeStackView, rangedStackView] {
                stackView?.isHidden = true
            }
            // Получаем текущий вопрос
            let currentQuastion = quastions[quastionIndex]
            // устанавливаем текущий вопрос для quastionLabel
            qastionLabel.text = currentQuastion.title
            
            //расчет прогресвью
            let totalProgress = Float(quastionIndex) / Float(quastions.count)
            quastionProgressView.setProgress(totalProgress, animated: true)
            
            //Меняем номер вопрооса в тайтле
            title = "Вопрос № \(quastionIndex + 1) из \(quastions.count)"
            
            showCurrentAnswers(for: currentQuastion.responseType)
            
        }
        func showCurrentAnswers(for type: ResponseType) {
            switch type {
        
            case .single:
                showSingleStackView(with: currentAnswers)
            case .multiple:
                showMultipeStackView(with: currentAnswers)
            case .range:
                showRangeStackView(with: currentAnswers)
            }
        }
// метод, который отображает первй стек с вопросами
        func showSingleStackView(with answers: [Answer]) {
            singleStackView.isHidden.toggle()
            for (button, answer) in zip(singleButtoms, answers) {
                button.setTitle(answer.title, for: .normal)
            }
            
        }
        
        func showMultipeStackView(with answers: [Answer]) {
            maltipeStackView.isHidden.toggle()
            for (label, answer) in zip(multipeLabels, answers) {
                label.text = answer.title
            }
        }
            
            
            func showRangeStackView(with answers: [Answer]) {
                rangedStackView.isHidden.toggle()
                
                rangeLabels.first?.text = answers.first?.title
                rangeLabels.last?.text = answers.last?.title
                
            }
            
            
            func goToNextQuastion() {
                quastionIndex += 1
                
                if quastionIndex < quastions.count {
                    updateUI()
                    return
                }
                
                performSegue(withIdentifier: "resultSegue", sender: nil)
                
            }
    
            
}
        
    



//
//  Calculator - ViewController.swift
//  Created by Christy.
//  Copyright © yagom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // case, static let 차이를 확실하게 알아두기
    enum Case {
        static let zero = "0"
        static let blank = ""
        static let space = " "
        static let decimal = "."
        static let minus = "-"
        
    }
    
    @IBOutlet weak var operandsLabel: UILabel!
    @IBOutlet weak var operatorsLabel: UILabel!
    
    // 연산 프로퍼티로 현재 화면에 떠있는 오퍼레이터와 숫자를 받아올 수 있음!!!
    var currentOperand: String {
        return operandsLabel.text ?? Case.zero
    }
    
    var currentOperator: String {
        return operatorsLabel.text ?? Case.blank
    }
    
    var isFirst: Bool = true
    
    var expressionArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        resetLabel()
    }
    
    func resetLabel() {
        operandsLabel.text = Case.zero
        operatorsLabel.text = Case.blank
    }
    
    @IBAction func allClearButtonTapped(_ sender: UIButton) {
        expressionArray.removeAll()
        print("clear, \(expressionArray)")
        resetLabel()
    }
    
    @IBAction func clearEntryButtonTapped(_ sender: UIButton) {
        operandsLabel.text = Case.zero
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        guard let number = sender.currentTitle else { return }
        
        if isFirst {
            if currentOperand == Case.zero {
                operandsLabel.text = number
            } else {
                let inputNumber = number
                operandsLabel.text = inputNumber
                isFirst = false
            }
        } else {
            if currentOperand == Case.zero {
                operandsLabel.text = number
            } else {
                let inputNumber = currentOperand + number
                operandsLabel.text = inputNumber
            }
        }
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        guard let operators = sender.currentTitle else { return }
        
        // 숫자가 입력이 안되었을 때
        if currentOperand == Case.zero {
            operatorsLabel.text = operators
            print("\(currentOperator), \(currentOperand)")
            print("3:\(expressionArray)")
        } else {
            if currentOperator == Case.blank {
                expressionArray.append(currentOperand)
            } else {
                // 숫자가 있고 연산자를 누를 때 -> 들어온 값을 append시켜야 한다
                expressionArray.append(currentOperator)
                expressionArray.append(currentOperand)
                print("\(currentOperator), \(currentOperand)")
                print("1:\(expressionArray)")
            }
            operandsLabel.text = Case.zero
            operatorsLabel.text = operators
            print("out: \(currentOperator), \(currentOperand)")
            print("2:\(expressionArray)")
        }
    }
    
    @IBAction func numberZeroButtonTapped(_ sender: UIButton) {
        // 앞에 숫자가 있어야 합니다. 0일때 눌리면 안됨
        guard let numberZero = sender.currentTitle,
              currentOperand != Case.zero else { return }
        
        operandsLabel.text = currentOperand + numberZero
    }
    
    @IBAction func decimalPointButtonTapped(_ sender: UIButton) {
        guard let decimalPoint = sender.currentTitle,
              !currentOperand.contains(Case.decimal) else { return }
        
        operandsLabel.text = currentOperand + decimalPoint
    }
    
    
    // -5 상태에서 9 누르면 -59 되도록 바꿔야 함
    @IBAction func signChangeButtonTapped(_ sender: UIButton) {
        guard currentOperand != Case.zero else { return }
        
        // -가 없으면 -를 쓰고, 있으면 뺴고
        if currentOperand.contains(Case.minus) {
            // - 빼주기
            operandsLabel.text = currentOperand.trimmingCharacters(in: ["-"])
        } else {
            // -붙이기
            operandsLabel.text = Case.minus + currentOperand
        }
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        guard !expressionArray.isEmpty else { return }
        
        // 최신값 append 시켜주기
        expressionArray.append(currentOperator)
        expressionArray.append(currentOperand)

        let stringExpression = expressionArray.joined(separator: "")
        print("stringExpression: \(stringExpression)")
        var parsedExpression = ExpressionParser.parse(from: stringExpression)
        print("Parsed: \(parsedExpression)")
        let result = parsedExpression.result()
        
        print("result: \(result)")
        
        operandsLabel.text = String(result)
        operatorsLabel.text = Case.blank
        
        expressionArray = []
        isFirst = true
        print("12, \(expressionArray)")
    }
}

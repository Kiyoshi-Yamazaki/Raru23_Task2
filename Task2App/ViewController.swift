//
//  ViewController.swift
//  Task2App
//
//  Created by 山崎喜代志 on 2021/03/14.
//

import UIKit

enum CalculationResult {
    case valid(Double)
    case invalid(String)
}

enum Calculator {
    case add
    case sub
    case mul
    case div

    init?(selectedIndex: Int) {
        let results: [Calculator] = [.add, .sub, .mul, .div]
        guard results.indices.contains(selectedIndex) else { return nil }
        self = results[selectedIndex]
    }

    func calculate(num1: Double, num2: Double) -> CalculationResult {
        switch self {
        case .add:
            return .valid(num1 + num2)
        case .sub:
            return .valid(num1 - num2)
        case .mul:
            return .valid(num1 * num2)
        case .div:
            guard num2 != 0 else { return .invalid("割る数には0以外を入力してください") }
            return .valid(num1 / num2)
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var segmentController: UISegmentedControl!
    @IBOutlet private weak var textLabel: UILabel!

    private var calculator: Calculator = .add

    override func viewDidLoad() {
        super.viewDidLoad()
        textField1.keyboardType = .numberPad
        textField2.keyboardType = .numberPad
    }

    @IBAction func didTapButton(_ sender: Any) {

        let num1 = Double(textField1.text ?? "") ?? 0
        let num2 = Double(textField2.text ?? "") ?? 0
        switch calculator.calculate(num1: num1, num2: num2) {
        case let .valid(result):
            textLabel.text = String(result)
        case let .invalid(message):
            textLabel.text = message
        }
    }

    @IBAction func didSelectedButton(_ sender: UISegmentedControl) {
        guard let calculator = Calculator(selectedIndex: sender.selectedSegmentIndex) else {
            fatalError("Invalid selectedSegmentIndex.")
        }
        self.calculator = calculator
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

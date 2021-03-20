//
//  ViewController.swift
//  Task2App
//
//  Created by 山崎喜代志 on 2021/03/14.
//

import UIKit

enum State {
    case add
    case sub
    case mul
    case div
}

class ViewController: UIViewController {

    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var segmentController: UISegmentedControl!
    @IBOutlet private weak var textLabel: UILabel!

    private var state: State = .add

    override func viewDidLoad() {
        super.viewDidLoad()
        textField1.keyboardType = .numberPad
        textField2.keyboardType = .numberPad
    }

    func culculate(num1: Double, num2: Double, culculate: (Double, Double) -> (Double)) -> Double {
        culculate(num1, num2)
    }

    @IBAction func didTapButton(_ sender: Any) {

        switch state {

        case .add:
            textLabel.text = String(culculate(num1: Double(textField1.text ?? "") ?? 0,
                                              num2: Double(textField2.text ?? "") ?? 0,
                                              culculate: +)
            )
        case .sub:
            textLabel.text = String(culculate(num1: Double(textField1.text ?? "") ?? 0,
                                              num2: Double(textField2.text ?? "") ?? 0,
                                              culculate: -)
            )
        case .mul:
            textLabel.text = String(culculate(num1: Double(textField1.text ?? "") ?? 0,
                                              num2: Double(textField2.text ?? "") ?? 0,
                                              culculate: *)
            )
        case .div:

            if textField2.text == String(0) {
                textLabel.text = "割る数には0以外を入力してください"
                return
            }
            textLabel.text = String(culculate(num1: Double(textField1.text ?? "") ?? 0,
                                              num2: Double(textField2.text ?? "") ?? 0,
                                              culculate: /)
            )

        }

    }

    @IBAction func didSelectedButton(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {

        case 0:
            state = .add
        case 1:
            state = .sub
        case 2:
            state = .mul
        case 3:
            state = .div
        default:
            break
        }
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

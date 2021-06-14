//
//  ViewController.swift
//  CountOnMe
//
//  Created by JEAN SEBASTIEN BRUNET on 14/6/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    let calculation = CalculationModel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(displayCalculationResult(notification:)),
                                               name: Notification.Name("updateDisplay"), object: nil)
    }

    // MARK: - @IBOutlets

    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var textView: UITextView!

    // MARK: - @objC functions
    @objc func displayCalculationResult(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        textView.text = userInfo["updateDisplay"] as? String
    }

    // MARK: - @IBActions

    @IBAction func numberButtonTapped(_ sender: UIButton) {
        guard let inputNumber = sender.title(for: .normal) else { return }
        calculation.numberButtonTapped(numberText: inputNumber)
    }

    @IBAction func aCButtonTapped(_ sender: UIButton) {
        calculation.clear()
    }

    @IBAction func equalButtonTapped(_ sender: UIButton) {
        calculation.equalButtonTapped()
    }

    @IBAction func plusButtonTapped(_ sender: UIButton) {
        calculation.plusButtonTapped()
    }

    @IBAction func minusButtonTapped(_ sender: UIButton) {
        calculation.minusButtonTapped()
    }

    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        calculation.multiplyButtonTapped()
    }

    @IBAction func dividedButtonTapped(_ sender: UIButton) {
        calculation.divideButtonTapped()
    }
}

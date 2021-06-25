//
//  ViewController.swift
//  CountOnMe
//
// created by vincent.....
//  Created by JEAN SEBASTIEN BRUNET on 14/6/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    let calculation = TreatmentModel()
    var textViewLength: Int { textView.text.count}

    // MARK: - @IBOutlets

    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var textView: UITextView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(displayCalculationResult(notification:)),
                                               name: Notification.Name("updateDisplay"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayAlert(notification:)),
                                               name: Notification.Name("alertDisplay"), object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        textView.addGestureRecognizer(tapGesture)
    }

    // MARK: - @objC Functions
    @objc func displayCalculationResult(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        textView.text = userInfo["updateDisplay"] as? String
    }

    @objc func displayAlert(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let errorMessage = userInfo["message"] as? String else { return }
        createAlert(message: errorMessage)
    }

    @objc func handleTapGesture(_ sender: UIPanGestureRecognizer) {
        calculation.deleteLastEntry()
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
        calculation.calculate()
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

    // MARK: - Private functions

    /// This function presents an alert to the user.
    private func createAlert(message: String) {
        let alertViewController = UIAlertController(title: "Alert!", message: message, preferredStyle: UIAlertController.Style.alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }

}

// add function to adapt character size

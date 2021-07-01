//
//  ViewController.swift
//  CountOnMe
//
//  Created by JEAN SEBASTIEN BRUNET on 14/6/21.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
// swiftlint:disable line_length
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    let calculation = TreatmentModel()

    // MARK: - @IBOutlets

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

    /// This function updates textView whenever the value of inputString property
    /// of model changes.
    @objc func displayCalculationResult(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        textView.text = userInfo["updateDisplay"] as? String
    }

    /// This function displays alerts if a notification is received.
    @objc func displayAlert(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let errorMessage = userInfo["message"] as? String else { return }
        createAlert(message: errorMessage)
    }

    /// This function, by calling deleteLastEntry() method from model,
    /// deletes the last character of the textView.
    @objc func handleTapGesture(_ sender: UIPanGestureRecognizer) {
        calculation.deleteLastEntry()
    }

    // MARK: - @IBActions

    /// This function adds a number in textView.
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        guard let inputNumber = sender.title(for: .normal) else { return }
        calculation.numberButtonTapped(numberText: inputNumber)
    }

    /// THis function clears the textView.
    @IBAction func aCButtonTapped(_ sender: UIButton) {
        calculation.clear()
    }

    /// This function performs calculation by calling
    /// calculate() function of the model.
    @IBAction func equalButtonTapped(_ sender: UIButton) {
        calculation.calculate()
    }

    /// This function adds a plus to textView by calling the
    /// model's matching function.
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        calculation.plusButtonTapped()
    }

    /// This function adds a minus to textView by calling the
    /// model's matching function.
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        calculation.minusButtonTapped()
    }

    /// This function adds a multiply to textView by calling the
    /// model's matching function.
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        calculation.multiplyButtonTapped()
    }

    /// This function adds a divide to textView by calling the
    /// model's matching function.
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

} // end of class ViewController: UIViewController

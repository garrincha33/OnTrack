//
//  CreateGoalVC.swift
//  OnTrack
//
//  Created by Richard Price on 13/09/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        goalTextView.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notication: NSNotification) {
        let keyboardFrame = (notication.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        UIView.animate(withDuration: 0.3) {
            self.constraintToBottom.constant = keyboardFrame!.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notication: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constraintToBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func nextbtnPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "finishGoalVC") as? FinishGoalVC else {
                return
            }
            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
            presentDetail(finishGoalVC)
        } else {
            alertTextGoal()
        }
    }
    @IBAction func shortTermButtonPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    @IBAction func longTermBtn(_ sender: Any) {
        goalType = .longTerm
        shortTermBtn.setDeselectedColor()
        longTermBtn.setSelectedColor()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismissDetails()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

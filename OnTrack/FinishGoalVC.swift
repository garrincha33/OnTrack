//
//  FinishGoalVC.swift
//  OnTrack
//
//  Created by Richard Price on 14/09/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var createGoalBtn: UIButton!
    
    @IBOutlet weak var pointsTextField: UITextField!
    
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        
        self.goalDescription = description
        self.goalType = type
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        pointsTextField.delegate = self
 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func keyboardWillShow(_ notication: NSNotification) {
        let keyboardFrame = (notication.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        UIView.animate(withDuration: 0.3) {
            self.constraintToBottom.constant = keyboardFrame!.height
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(_ notication: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constraintToBottom.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    

    @IBAction func createGoalBtnPressed(_ sender: Any) {
        
        //pass data to core data
        
        
    }


}

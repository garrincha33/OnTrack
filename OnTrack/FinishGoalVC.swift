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
    @IBAction func createGoalBtnPressed(_ sender: Any) {
        if pointsTextField.text != "" && pointsTextField.text != "\(0)" {
                self.save { (complete) in
                    if complete {
                        ad?.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        
        else {
            
            alert()
            
            }
        }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetails()
    }
    
    func save(completion: (_ finished: Bool) -> ()){
        guard let managedContext = context else  {
            return
        }
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        //---save to persistant storage
        do {
            try managedContext.save()
            print("sucessfully saved to core data")
            completion(true)
        } catch {
            print("couldnt save \(error.localizedDescription)")
            completion(false)
        }
    }
}

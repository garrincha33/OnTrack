//
//  UIViewControllerExt.swift
//  OnTrack
//
//  Created by Richard Price on 13/09/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
    let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
        
    }
    func dismissDetails() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    func alert() {
        // Create message
        let alertController = UIAlertController(title: "Ooooops",
                                                message: "sorry thats not a valid number for a goal",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController,
                     animated: true,
                     completion:nil)
        
    }
    
    func alertTextGoal() {
        // Create message
        let alertController = UIAlertController(title: "Ooooops",
                                                message: "sorry you didnt enter a goal",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController,
                     animated: true,
                     completion:nil)
        
    }
}

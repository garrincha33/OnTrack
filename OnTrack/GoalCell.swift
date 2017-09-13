//
//  GoalCell.swift
//  OnTrack
//
//  Created by Richard Price on 12/09/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    
    @IBOutlet weak var goalTypeLbl: UILabel!
    
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    func configureCell(description: String, type: GoalType, goalAmountProgress: Int) {

        self.goalDescriptionLbl.text = description
        self.goalTypeLbl.text = type.rawValue
        self.goalProgressLbl.text = String(describing: goalAmountProgress)
        
    }
}

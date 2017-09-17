//
//  MainVC.swift
//  OnTrack
//
//  Created by Richard Price on 12/09/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var goals: [Goal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    
                    tableView.isHidden = true
                }
            }
        }
        
        tableView.reloadData()
    }
    
    @IBAction func addGoralBtnPressed(_ sender: Any) {
        
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {
            return
        }
        presentDetail(createGoalVC)
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return goals.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else {
            
            return UITableViewCell() }
        
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)

        return cell
    
    }
}


extension MainVC {
    
    func fetch(completion: (_ Complete: Bool) -> ()) {
        
        guard let managedContext = context else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            
            goals = try managedContext.fetch(fetchRequest)
            print("successfully loaded from coredata")
            completion(true)
            
        } catch {
            
            print("could not fetch : \(error.localizedDescription)")
            completion(false)
        }
    }
}




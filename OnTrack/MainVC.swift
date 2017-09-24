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
        fetchGoals()
        tableView.reloadData()
    }
    func fetchGoals() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    
                    tableView.isHidden = true
                }
            }
        }
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
    //----------------------- swipe to delete and action
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.deleteGoal(atindexPath: indexPath)
            self.fetchGoals()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let addAction = UITableViewRowAction(style: .normal, title: "ADD") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        addAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return [deleteAction, addAction]
    }
     //----------------------- swipe to delete and add action
}
extension MainVC {
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = context else {return}
        let chosenGoal = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        do {
            try managedContext.save()
        } catch {
            print("could not set progess : \(error.localizedDescription)")
        }
    }
    func deleteGoal(atindexPath indexPath: IndexPath) {
        guard let managedContext = context else {return}
        managedContext.delete(goals[indexPath.row])
        do {
            try managedContext.save()
        } catch {
            print("error in saving : \(error.localizedDescription)")
        }
    }
    func fetch(completion: (_ Complete: Bool) -> ()) {
        guard let managedContext = context else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try managedContext.fetch(fetchRequest)
            
            completion(true)
        } catch {
            print("could not fetch : \(error.localizedDescription)")
            completion(false)
        }
    }
    func undoLastAction(completion: (_ Complete: Bool) -> ()) {
        guard let managedContext = context else {return}
        managedContext.undoManager?.undo()
        do {
            try managedContext.save()
            completion(true)
        } catch {
            print("error in saving : \(error.localizedDescription)")
            completion(false)
        }
    }
}

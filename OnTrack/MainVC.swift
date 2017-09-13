//
//  MainVC.swift
//  OnTrack
//
//  Created by Richard Price on 12/09/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
        
    }
    
    @IBAction func addGoralBtnPressed(_ sender: Any) {
        
    
        
        
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else {
            
            return UITableViewCell() }
        
        cell.configureCell(description: "Eat Salad", type: .shortTerm, goalAmountProgress: 2)
        
        return cell
    
    }
}




//
//  ViewController.swift
//  HitListCoreDataLearning
//
//  Created by Phetrungnapha, K. on 6/18/2560 BE.
//  Copyright © 2560 iTopStory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var viewModels: [ViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Person List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModels = ViewModel.fetchPerson(entityName: "PersonManagedObject")
    }
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add a new person", message: "Please enter information", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let firstNameTextField = alert.textFields?[0], let firstName = firstNameTextField.text else {
                return
            }
            guard let lastNameTextField = alert.textFields?[1], let lastName = lastNameTextField.text else {
                return
            }
            
            self.viewModels.append(ViewModel.addPerson(firstName: firstName, lastName: lastName))
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField()
        alert.addTextField()
        
        alert.textFields?[0].placeholder = "First name"
        alert.textFields?[1].placeholder = "Last name"
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModels[indexPath.row].fullName
        return cell
    }
    
}

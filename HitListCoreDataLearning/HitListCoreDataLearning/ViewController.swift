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
    
    fileprivate var viewModelManager = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Person List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModels = viewModelManager.fetchPerson(entityName: "PersonManagedObject")
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
            
            self.viewModels.append(self.viewModelManager.addPerson(firstName: firstName, lastName: lastName))
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

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedViewModel = viewModels[indexPath.row]
            viewModelManager.deletePerson(identifier: selectedViewModel.personIdentifier) { [unowned self] in
                self.viewModels.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedViewModel = viewModels[indexPath.row]
        
        let alert = UIAlertController(title: "Update person", message: "Please edit information", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let firstNameTextField = alert.textFields?[0], let firstName = firstNameTextField.text else {
                return
            }
            guard let lastNameTextField = alert.textFields?[1], let lastName = lastNameTextField.text else {
                return
            }

            self.viewModelManager.updatePerson(viewModel: selectedViewModel, firstName: firstName, lastName: lastName) { [unowned self] in
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField()
        alert.addTextField()
        
        alert.textFields?[0].text = selectedViewModel.firstName
        alert.textFields?[1].text = selectedViewModel.lastName
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}

//
//  ViewModel.swift
//  HitListCoreDataLearning
//
//  Created by Phetrungnapha, K. on 6/18/2560 BE.
//  Copyright © 2560 iTopStory. All rights reserved.
//

import Foundation

class ViewModel {
    
    fileprivate var person: Person?
    
    convenience init(person: Person) {
        self.init()
        self.person = person
    }
    
    var personIdentifier: String {
        return person?.identifier ?? ""
    }
    
    var firstName: String {
        return person?.firstName ?? ""
    }
    
    var lastName: String {
        return person?.lastName ?? ""
    }
    
    var fullName: String {
        return "\(person?.firstName ?? "") \(person?.lastName ?? "")"
    }
    
}

extension ViewModel {
    
    func addPerson(firstName: String, lastName: String) -> ViewModel {
        let identifier = UUID().uuidString
        let person = Person(identifier: identifier, firstName: firstName, lastName: lastName)
        let personViewModel = ViewModel(person: person)
        
        if let personManagedObject = CoreDataService.shared.prepareManagedObject(entityName: "PersonManagedObject") {
            personManagedObject.setValue(identifier, forKey: "identifier")
            personManagedObject.setValue(firstName, forKey: "firstName")
            personManagedObject.setValue(lastName, forKey: "lastName")
            CoreDataService.shared.saveContext()
        }
        
        return personViewModel
    }
    
    func fetchPerson(entityName: String) -> [ViewModel] {
        var viewModels = [ViewModel]()
        if let personManagedObjects = CoreDataService.shared.fetchObjects(entityName: entityName) {
            viewModels = personManagedObjects.map {
                let identifier = $0.value(forKeyPath: "identifier") as? String ?? ""
                let firstName = $0.value(forKeyPath: "firstName") as? String ?? ""
                let lastName = $0.value(forKeyPath: "lastName") as? String ?? ""
                let person = Person(identifier: identifier, firstName: firstName, lastName: lastName)
                return ViewModel(person: person)
            }
        }
        return viewModels
    }
    
    func deletePerson(identifier: String, completion: (() -> ())) {
        CoreDataService.shared.deleteObject(entityName: "PersonManagedObject", identifier: identifier)
        completion()
    }
    
    func updatePerson(viewModel: ViewModel, firstName: String, lastName: String, completion: (() -> ())) {
        viewModel.person = Person(identifier: viewModel.personIdentifier, firstName: firstName, lastName: lastName)
        
        let valuesForUpdate = [
            "firstName": firstName,
            "lastName": lastName
        ]
        CoreDataService.shared.updateObject(entityName: "PersonManagedObject", identifier: viewModel.personIdentifier, valuesForUpdate: valuesForUpdate)
        
        completion()
    }
    
}

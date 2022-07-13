//
//  DatabaseManager.swift
//  NewsApp
//
//  Created by Aakash Decosta on 13/07/22.
//


import UIKit
import CoreData

class DatabaseManager {
    private var context: NSManagedObjectContext!
    static let shared = DatabaseManager()
    
    init () {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    func addData<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name,
              let  entity = NSEntityDescription.entity(forEntityName: entityName, in: context)else { return nil}
        let object = T(entity: entity, insertInto: context)
        return object
    }
    
    
    func save() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        let request  = T.fetchRequest()
        do {
            let result = try context.fetch(request)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
       
    }
}

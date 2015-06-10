//
//  CoreDataFun.swift
//  SwiftFeeder
//
//  Created by Rick Windham on 6/9/15.
//  Copyright (c) 2015 Rick Windham. All rights reserved.
//

import Foundation
import CoreData

class CoreDataFun {
    let moc:NSManagedObjectContext
    
    init(context:NSManagedObjectContext) {
        moc = context
    }
    
    func fetchAll(entityName: String) -> NSArray? {
        let request = NSFetchRequest(entityName: entityName)
        var error:NSError?
        
        let result = moc.executeFetchRequest(request, error: &error)
        
        if let err = error {
            println("Fetch Error: \(err)")
        }
        
        return result
    }
    
    func fetchWhere(attribute:String, equals value:String, forEntityName entityName: String) -> [AnyObject]? {
        let request = NSFetchRequest(entityName: entityName)
        request.predicate = NSPredicate(format: "%K == %@", attribute, value)
        
        var error:NSError?
        
        let result = moc.executeFetchRequest(request, error: &error)
        
        if let err = error {
            println("Fetch Error: \(err)")
        }
        
        return result
    }
    
    func saveAction() -> Bool {
        var error: NSError? = nil
        if moc.hasChanges && !moc.save(&error) {
            return false
        }
        return true
    }

}

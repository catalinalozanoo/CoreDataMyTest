//
//  User.swift
//  CoreDataMyTest
//
//  Created by catalina lozano on 16/06/24.
//

import Foundation
import CoreData

public class User: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var language: String
    
}

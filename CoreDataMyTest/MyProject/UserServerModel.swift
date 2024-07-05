//
//  UserServerModel.swift
//  CoreDataMyTest
//
//  Created by catalina lozano on 16/06/24.
//

import Foundation

class UserServerModel: Codable {
    let name: String
    let type: String
    //let avatar: String
    
    static let databaseHandler = DatabaseHandler.shared
    
    func store(){
        guard let user = UserServerModel.databaseHandler.add(User.self) else {return}
       // user.avatar = avatar
        user.type = type
        user.name = name
        UserServerModel.databaseHandler.save()
    }
}

struct APIResponse<T: Codable>: Codable {
    let data: T
}

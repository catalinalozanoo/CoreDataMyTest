//
//  APIHandler.swift
//  CoreDataMyTest
//
//  Created by catalina lozano on 16/06/24.
//

import Foundation

class APIHandler {
    static let shared = APIHandler()
    
    private init(){}
    
    func fetchUsers(completion: @escaping() ->Void){
        var request = URLRequest(url: URL(string: "https://reqres.in/api/users")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request){ data,response, error in
            do {
                if let data = data {
                    let model = try JSONDecoder().decode(APIResponse<[UserServerModel]>.self, from: data)
                    model.data.forEach {$0.store()}
                    completion()
                }
            } catch {
                print("Error")
            }
        }
        task.resume()
    }
}









































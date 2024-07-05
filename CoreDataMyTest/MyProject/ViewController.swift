//
//  ViewController.swift
//  CoreDataMyTest
//
//  Created by catalina lozano on 16/06/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let databaseHandler = DatabaseHandler.shared
    var users: [User]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
    }
    @IBAction func addUser(_ sender: Any){
        showAlert()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        APIHandler.shared.fetchUsers {
            self.fetchUsers()
        }
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        cell.user = users?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let user = users?[indexPath.row] else {return}
                tableView.beginUpdates()
                self.databaseHandler.delete(object: user)
                users?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
        }
    }
}
extension ViewController{
    fileprivate func showAlert(){
        let alertVC = UIAlertController(title: "Enter user detail", message: "provide name & email", preferredStyle: .alert)
        alertVC.addTextField{ (textField) in
            textField.placeholder = "Name"
        }
        alertVC.addTextField{ (textField) in
            textField.placeholder = "Email"
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (alert) -> Void in
            let nameTextField = alertVC.textFields![0] as UITextField
            let emailTextField = alertVC.textFields![1] as UITextField
            
            self.saveUser(name: nameTextField.text ?? "ABS", type: emailTextField.text ?? "123")
            self.fetchUsers()
        })
        alertVC.addAction(submitAction)
        alertVC.view.tintColor = UIColor.black
        present(alertVC, animated: true)
    }
    func saveUser(name: String, type: String){
        let user = databaseHandler.add(User.self)
        user?.name = name
        user?.type = type
        //user?.avatar = "https://randomuser.me/api/portraits/med/men\(Int.random(in: 0..<99)).jpg"
        databaseHandler.save()
    }
    fileprivate func fetchUsers(){
        users = databaseHandler.fetch(User.self)
    }
}



































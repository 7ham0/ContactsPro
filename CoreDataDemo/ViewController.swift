//
//  ViewController.swift
//  ContactsPro
//
//  Created by Giorgi Shamugia on 1/21/20.
//  Copyright © 2020 7ham0. All rights reserved.
//

import UIKit

//TODO: - Bilingual application.
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var contacts = [Contact]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "DataTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DataTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllContacts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
        
    }
    
    
    //cells
    //TODO - Create custom cell. +
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as!
            DataTableViewCell
        cell.myLabel?.text = contacts[indexPath.row].name
        cell.myImageView?.image = UIImage(data: contacts[indexPath.row].profile!)
        
        
        return cell
    }
    
    //Contacts fetch
    func getAllContacts() {
        contacts = try! context.fetch(Contact.fetchRequest())
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = contacts[indexPath.row].name
        let phone = contacts[indexPath.row].phone
        let mail = contacts[indexPath.row].mail
        
     //alert
        let alert = UIAlertController(title: name, message: "Phone: \(String(describing: phone!)) \n E-mail: \(String(describing: mail!)) ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //edit cells
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            let alert = UIAlertController(title: "Are you sure to delete?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                let contact = self.contacts[indexPath.row]
                self.context.delete(contact)
                self.appDelegate.saveContext()
                self.getAllContacts()
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            
            let dest = self.storyboard?.instantiateViewController(withIdentifier: "editScreen") as!
            EditContactViewController
            
            dest.isUpdate = true
            dest.contactIndex = indexPath.row
            dest.name = self.contacts[indexPath.row].name
            dest.mail = self.contacts[indexPath.row].mail
            dest.phone = self.contacts[indexPath.row].phone
            dest.image = UIImage(data: self.contacts[indexPath.row].profile!)
            
            self.navigationController?.pushViewController(dest, animated: true)
            
        }
        return [delete, edit]
    }
    
}

//
//  sViewController.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import UIKit
import RealmSwift

class PedDoseTableViewController: UITableViewController {
    

    @IBOutlet var pedLrgLbl: UITableView!
    
    var todoItems1: Results<Weight1>?
    let realm = try! Realm()
    
    var selectedCategory1 : Item1? {
        didSet{
            loadItems1()
        }
    }
    
    override func viewDidLoad() {
        
        let nib = UINib.init(nibName: "PedViewCell", bundle: nil)
        self.pedLrgLbl.register(nib, forCellReuseIdentifier: "PedViewCell")
        
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory1?.title1
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems1?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PedViewCell", for: indexPath) as! PedViewCell
        
        cell.pedDView.text = todoItems1?[indexPath.row].title2
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 2
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems1?[indexPath.row] {
            do {
                try realm.write {
                    item.done2 = !item.done2
                }
            } catch {
                print("Error saving done status, \(error)")
            }
            tableView.reloadData()
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            
            self.updateModel(at: indexPath)
        }
        
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256
    }
    
    //MARK: - Add New Items
    
    
    @IBAction func addNewDose(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new dose", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            if let currentCategory = self.selectedCategory1 {
                do {
                    try self.realm.write {
                        let newItem = Weight1()
                        newItem.title2 = textField.text!
                        currentCategory.weight1.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manupulation Methods
    
    
    
    func loadItems1() {
        
        todoItems1 = selectedCategory1?.weight1.sorted(byKeyPath: "title2", ascending: true)
        
        tableView.reloadData()
        
    }
    func updateModel(at indexPath: IndexPath) {
        if let item = todoItems1?[indexPath.row] {
            do{
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error deleting item \(error)")
            }
            tableView.reloadData()
        }
        
    }
}

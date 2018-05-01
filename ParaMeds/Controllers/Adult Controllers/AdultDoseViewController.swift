//
//  bViewController.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import UIKit
import RealmSwift

class AdultDoseViewController: UITableViewController {
    
    
    @IBOutlet var adultViewLbl: UITableView!
    
    var doseItems: Results<Weight>?
    let realm = try! Realm()
    
    var selectedCategory1 : Item? {
        didSet{
            loadItems1()
        }
    }
    
    override func viewDidLoad() {
        
        let nib = UINib.init(nibName: "AdultViewCell", bundle: nil)
        self.adultViewLbl.register(nib, forCellReuseIdentifier: "AdultViewCell")
        
        super.viewDidLoad()
        
        tableView.rowHeight = 524
        tableView.separatorStyle = .none
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory1?.title
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doseItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdultViewCell", for: indexPath) as! AdultViewCell
        
        cell.adultbLbl.text = doseItems?[indexPath.row].title3
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 2
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = doseItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done3 = !item.done3
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
    
    
    @IBAction func addAdultDose(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new dose", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            if let currentCategory = self.selectedCategory1 {
                do {
                    try self.realm.write {
                        let newItem = Weight()
                        newItem.title3 = textField.text!
                        currentCategory.weight.append(newItem)
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
            print("Handle Cancel Logic here")
        }))
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manupulation Methods
    
    
    
    func loadItems1() {
        
        doseItems = selectedCategory1?.weight.sorted(byKeyPath: "title3", ascending: true)
        
        tableView.reloadData()
        
    }
    func updateModel(at indexPath: IndexPath) {
        if let item = doseItems?[indexPath.row] {
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


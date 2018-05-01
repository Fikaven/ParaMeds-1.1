//
//  aViewController.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import UIKit
import RealmSwift

class AdultWeightViewController: UITableViewController {
    
    
    @IBOutlet var weightTableView: UITableView!
    
    
    var items: Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category?{
        didSet {
            loadItems()
        }
    }
    override func viewDidLoad() {
        
        let nib = UINib.init(nibName: "AdultDoseCell", bundle: nil)
        self.weightTableView.register(nib, forCellReuseIdentifier: "AdultDoseCell")
        
        super.viewDidLoad()
        
        tableView.rowHeight = 104
        tableView.separatorStyle = .none
        
    }
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory?.name
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (items?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdultDoseCell", for: indexPath) as! AdultDoseCell
        
        cell.drugLbl.text = items?[indexPath.row].title
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 2
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToAdultDose", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AdultDoseViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory1 = items?[indexPath.row]
            
        }
        
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
        return 120
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category1) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
    }
    
    //MARK: - Add New Categories
    
    
    @IBAction func addAdultWeight(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new weight", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new weight"
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manupulation Methods
    
    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    //MARK: - Deleteing categories
    
    func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.items?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category \(error)")
            }
            tableView.reloadData()
        }
    }
}


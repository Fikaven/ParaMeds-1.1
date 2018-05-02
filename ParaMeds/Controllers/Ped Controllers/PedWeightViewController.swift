//
//  aViewController.swift
//  ParaMeds
//
//  Created by Stephen Smith on 4/30/18.
//  Copyright © 2018 Stephen Smith. All rights reserved.
//

import UIKit
import RealmSwift

class PedWeightViewController: UITableViewController {

    
    @IBOutlet var pedWeightView: UITableView!
    
    var items1: Results<Weight1>?
    let realm = try! Realm()
    var selectedCategory : Category1?{
        didSet {
            loadItems()
        }
    }
    override func viewDidLoad() {
        
        let nib = UINib.init(nibName: "PedDoseCell", bundle: nil)
        self.pedWeightView.register(nib, forCellReuseIdentifier: "PedDoseCell")
        
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory?.pedDrug1
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items1?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PedDoseCell", for: indexPath) as! PedDoseCell
        
        cell.pedDrugLbl.text = items1?[indexPath.row].pedWeight1
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 2
        
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPedDose", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PedDoseTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory1 = items1?[indexPath.row]
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
    
    @IBAction func addNewWeight(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new weight", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Weight1()
                        newItem.pedWeight1 = textField.text!
                        currentCategory.items1.append(newItem)
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
            textField.placeholder = "Add a new category"
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manupulation Methods
    
    func loadItems() {
        items1 = selectedCategory?.items1.sorted(byKeyPath: "pedWeight1", ascending: true)
        tableView.reloadData()
    }
    
    //MARK: - Deleteing categories
    
    func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.items1?[indexPath.row] {
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



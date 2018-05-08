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
    
    var pDoseItems: Results<Dose1>?
    let realm = try! Realm()
    
    var selectedCategory1 : Weight1? {
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
        title = selectedCategory1?.pedWeight1
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pDoseItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PedViewCell", for: indexPath) as! PedViewCell
        
        cell.pInjctLbl.text = pDoseItems?[indexPath.row].pInjct
        cell.pInitialDoseLbl.text = pDoseItems?[indexPath.row].pfrstDose
        cell.pSecondDoseLbl.text = pDoseItems?[indexPath.row].pScndDose
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 2
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = pDoseItems?[indexPath.row] {
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
        return 332
    }
    
    //MARK: - Add New Items
    
    
    @IBAction func addNewDose(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        var textField1 = UITextField()
        var textField2 = UITextField()
        
        let alert = UIAlertController(title: "Add a dose", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            if let currentCategory = self.selectedCategory1 {
                do {
                    try self.realm.write {
                        let newItem = Dose1()
                        newItem.pInjct = textField.text!
                        newItem.pfrstDose = textField1.text!
                        newItem.pScndDose = textField2.text!
                        currentCategory.weight1.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Injection method      "
            textField = alertTextField
            
        }
        alert.addTextField { (alertTextField1) in
            alertTextField1.placeholder = "Initian dose"
            textField1 = alertTextField1
        }
        alert.addTextField { (alertTextField2) in
            alertTextField2.placeholder = "Second/Max dose"
            textField2 = alertTextField2
        }
        
        alert.addAction(action)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manupulation Methods
    
    
    
    func loadItems1() {
        
        pDoseItems = selectedCategory1?.weight1.sorted(byKeyPath: "pInjct", ascending: true)
        
        tableView.reloadData()
        
    }
    func updateModel(at indexPath: IndexPath) {
        if let item = pDoseItems?[indexPath.row] {
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

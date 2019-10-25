//
//  RandomPersonTableViewController.swift
//  assessment6
//
//  Created by Matthew O'Connor on 10/25/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import UIKit

class RandomPersonTableViewController: UITableViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func randomizeNamesButtonTapped(_ sender: Any) {
        randomizeList()
        
    }
    
    @IBAction func addPersonNameButtonTapped(_ sender: Any) {
        addNameToList()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (RandomController.shared.nameList.count / 2)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RandomController.shared.nameList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        let nameList = RandomController.shared.nameList[indexPath.row]
        cell.textLabel?.text = nameList.name
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let nameList = RandomController.shared.nameList[indexPath.row]
            RandomController.shared.remove(name: nameList)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func addNameToList() {
        let alertController = UIAlertController(title: "Add A Name", message: "Add a name to the list...", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "add name here"
        }
        let postAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let nameText = alertController.textFields?[0].text else {return}
            RandomController.shared.addName(name: nameText) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(postAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    func randomizeList() -> [RandomName] {
        let listName = [RandomName]()
        let newList = listName.shuffled()
        return newList
    }
}


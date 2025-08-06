//
//  PantryViewController.swift
//  PantryPal
//
//  Created by Praise Olatide on 8/2/25.
//


import UIKit

class PantryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var pantryItems: [PantryItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPantry()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPantryItem))
    }

    @objc func addPantryItem() {
        let alert = UIAlertController(title: "Add Ingredient", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "e.g., eggs" }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let name = alert.textFields?.first?.text, !name.isEmpty else { return }
            let newItem = PantryItem(name: name)
            self?.pantryItems.append(newItem)
            self?.savePantry()
            self?.tableView.reloadData()
        }))
        present(alert, animated: true)
    }

    func savePantry() {
        if let data = try? JSONEncoder().encode(pantryItems) {
            UserDefaults.standard.set(data, forKey: "pantry")
        }
    }

    func loadPantry() {
        if let data = UserDefaults.standard.data(forKey: "pantry"),
           let items = try? JSONDecoder().decode([PantryItem].self, from: data) {
            pantryItems = items
        }
    }
}

extension PantryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pantryItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PantryCell", for: indexPath)
        cell.textLabel?.text = pantryItems[indexPath.row].name
        return cell
    }

    // Optional: swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pantryItems.remove(at: indexPath.row)
            savePantry()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

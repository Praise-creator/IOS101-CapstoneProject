//
//  RecipesViewController.swift
//  PantryPal
//
//  Created by Praise Olatide on 8/3/25.
//

import UIKit

class RecipesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var recipes: [Recipe] = []
    var pantryItems: [PantryItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search Recipes", style: .plain, target: self, action: #selector(searchRecipes))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPantry()
    }

    func loadPantry() {
        if let data = UserDefaults.standard.data(forKey: "pantry"),
           let items = try? JSONDecoder().decode([PantryItem].self, from: data) {
            pantryItems = items
        }
    }

    @objc func searchRecipes() {
        let ingredientList = pantryItems.map { $0.name }.joined(separator: ",")
        fetchRecipes(ingredients: ingredientList)
    }

    func fetchRecipes(ingredients: String) {
        let apiKey = "API_KEY_HERE"
        let urlString = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredients)&number=10&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode([Recipe].self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = results
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else if let error = error {
                print("Request error:", error)
            }
        }.resume()
    }
}

extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.title
        cell.detailTextLabel?.text = "\(recipe.usedIngredientCount) used, \(recipe.missedIngredientCount) missing"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedRecipe = recipes[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {
            detailVC.recipe = selectedRecipe
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }


}

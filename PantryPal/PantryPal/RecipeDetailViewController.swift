import UIKit

class RecipeDetailViewController: UIViewController {
    var recipe: Recipe?
    var isFavorited = false


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe Details"
        setupUI()
    }

    func setupUI() {
        guard let recipe = recipe else { return }
        titleLabel.text = recipe.title
        infoLabel.text = "\(recipe.usedIngredientCount) used • \(recipe.missedIngredientCount) missing"

        if let url = URL(string: recipe.image) {
            fetchImage(from: url) { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }

    func setInitialFavoriteState() {
        guard let recipe = recipe else { return }

        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let saved = try? JSONDecoder().decode([Recipe].self, from: data) {
            let isFavorited = saved.contains(where: { $0.id == recipe.id })
            saveButton.isSelected = isFavorited
        }
    }

    @IBAction func saveToFavorites(_ sender: UIButton) {
        guard let recipe = recipe else { return }

        var saved: [Recipe] = []
        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let existing = try? JSONDecoder().decode([Recipe].self, from: data) {
            saved = existing
        }

        if sender.isSelected {
            
            saved.removeAll(where: { $0.id == recipe.id })
            sender.isSelected = false
        } else {
            
            saved.append(recipe)
            sender.isSelected = true
        }

        if let data = try? JSONEncoder().encode(saved) {
            UserDefaults.standard.set(data, forKey: "favorites")
        }
    }
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }.resume()
    }
}

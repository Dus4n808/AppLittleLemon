//
//  DataMenu.swift
//  Restaurant
//
//  Created by Dusan Fama on 28.12.2024.
//
import SwiftUI
// raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json
/*{
  "menu": [
    {
      "id": 1,
      "title": "Greek Salad",
      "description": "The famous greek salad of crispy lettuce, peppers, olives, our Chicago.",
      "price": "10",
      "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true",
      "category": "starters"
    },
    {
      "id": 2,
      "title": "Lemon Desert",
      "description": "Traditional homemade Italian Lemon Ricotta Cake.",
      "price": "10",
      "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/lemonDessert%202.jpg?raw=true",
      "category": "desserts"
    },
    {
      "id": 3,
      "title": "Grilled Fish",
      "description": "Our Bruschetta is made from grilled bread that has been smeared with garlic and seasoned with salt and olive oil.",
      "price": "10",
      "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/grilledFish.jpg?raw=true",
      "category": "mains"
    },
    {
      "id": 4,
      "title": "Pasta",
      "description": "Penne with fried aubergines, cherry tomatoes, tomato sauce, fresh chilli, garlic, basil & salted ricotta cheese.",
      "price": "10",
      "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/pasta.jpg?raw=true",
      "category": "mains"
    },
    {
      "id": 5,
      "title": "Bruschetta",
      "description": "Oven-baked bruschetta stuffed with tomatos and herbs.",
      "price": "10",
      "image": "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/bruschetta.jpg?raw=true",
      "category": "starters"
    }
  ]
}*/


struct Product: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
}



struct Menu: Codable {
    let menu: [Product]
}

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = [] // Tous les produits récupérés
    @Published var filteredProducts: [Product] = [] // Produits filtrés pour la recherche
    @Published var categories : [String] = []
    @Published var searchText: String = "" { // Texte de recherche
        didSet {
            applySearchFilter()
        }
    }
    @Published var selectedCategory: String? {
        didSet {
            applySearchFilter()
        }
    }
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func fetchProducts() {
        guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json") else {
            errorMessage = "Invalid URL"
            return
        }
        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error {
                    self.errorMessage = "Erreur réseau: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.errorMessage = "Aucune donnée reçue"
                    return
                }

                do {
                    let menu = try JSONDecoder().decode(Menu.self, from: data)
                    self.products = menu.menu
                    self.filteredProducts = self.products // Par défaut, tous les produits
                    self.extractCategories()
                    
                } catch {
                    self.errorMessage = "Erreur de décodage: \(error.localizedDescription)"
                }
            }

        }.resume()
    }

    private func extractCategories()  {
        categories = Array(Set(products.map {$0.category} )).sorted()
    }

    private func applySearchFilter() {
        filteredProducts = products.filter { products in
            let matchesSearch = searchText.isEmpty || products.title.lowercased().contains(searchText.lowercased())
            let matchesCategory = selectedCategory == nil || products.category == selectedCategory
            return matchesSearch && matchesCategory
            
        }
    }
}

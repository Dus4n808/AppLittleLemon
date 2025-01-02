//
//  Cart.swift
//  Restaurant
//
//  Created by Dusan Fama on 28.12.2024.
//

import SwiftUI

class Cart: ObservableObject {
    @Published var items: [Product] = [] // Produits dans le panier
    @Published var quantities: [Product: Int] = [:] // Quantités par produit

    // Ajouter un produit au panier
    func addToCart(product: Product) {
        if let currentQuantity = quantities[product] {
            quantities[product] = currentQuantity + 1
        } else {
            items.append(product)
            quantities[product] = 1
        }
        objectWillChange.send() // Synchronisation avec SwiftUI
    }
    
    func quantityForProduct(product: Product) -> Int {
          return quantities[product] ?? 0
      }

    // Réduire la quantité ou supprimer le produit si quantité = 1
    func removeFromCart(product: Product) {
        guard let currentQuantity = quantities[product], currentQuantity > 0 else { return }
        if currentQuantity == 1 {
            removeProductComplete(product: product)
        } else {
            quantities[product] = currentQuantity - 1
        }
        objectWillChange.send() // Synchronisation avec SwiftUI
    }

    // Supprimer complètement un produit
    func removeProductComplete(product: Product) {
        items.removeAll { $0.id == product.id }
        quantities[product] = nil
        objectWillChange.send() // Synchronisation avec SwiftUI
    }

    // Quantité totale de produits dans le panier
    func totalQuantity() -> Int {
        return quantities.values.reduce(0, +)
    }

    // Prix total des produits dans le panier
    func totalPrice() -> Double {
        items.reduce(0.0) { total, item in
            let quantity = Double(quantities[item] ?? 0)
            let price = Double(item.price) ?? 0.0
            return total + quantity * price
        }
    }
}

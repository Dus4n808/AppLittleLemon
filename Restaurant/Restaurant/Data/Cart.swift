//
//  Cart.swift
//  Restaurant
//
//  Created by Dusan Fama on 28.12.2024.
//

import SwiftUI


class Cart: ObservableObject {
    @Published var items: [Product] = []
    @Published var quantities: [Product: Int] = [:]
    
    func addToCart(product: Product) {
        if let currentQuantity = quantities[product] {
            quantities[product] = currentQuantity + 1
        } else {
            items.append(product)
            quantities[product] = 1
        }
        objectWillChange.send()
        
    }
    
    func removeFromCart(product: Product) {
        guard let currentQuantity = quantities[product], currentQuantity > 0 else { return }
        if currentQuantity == 1 {
            items.removeAll{ $0.id == product.id }
            quantities[product] = nil
        } else {
            quantities[product] = currentQuantity - 1
        }
        objectWillChange.send()
        
    }
    func quantityForProduct(product: Product) -> Int {
        return quantities[product] ?? 0
    }
    
    func totalQuantity() -> Int {
        return quantities.values.reduce(0, +)
    }
    
    func totalPrice() -> Double {
        items.reduce(0.0) { total, item in
            let quantity = Double(quantities[item] ?? 0)
            let price = Double(item.price) ?? 0.0
            return total + quantity * price
        }
    }
    
}

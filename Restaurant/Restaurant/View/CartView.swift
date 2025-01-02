//
//  CartView.swift
//  Restaurant
//
//  Created by Dusan Fama on 29.12.2024.
//

import SwiftUI


struct CartView: View {
    @EnvironmentObject var cart: Cart
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            if cart.items.isEmpty {
                Text("Votre panier est vide.")
                    .font(.headline)
                    .padding()
            } else {
                List {
                    ForEach(cart.items, id: \.id) { item in
                        HStack(alignment: .center, spacing: 16) {
                            // Image du produit
                            AsyncImage(url: URL(string: item.image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else if phase.error != nil {
                                    Color.red // Placeholder en cas d'erreur
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            }

                            // Détails du produit
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title)
                                    .font(.headline)
                                    .foregroundColor(Color("CustomBlack"))
                                Text("Quantité : \(cart.quantityForProduct(product: item))")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            // Prix total
                            Text("$\(String(format: "%.2f", Double(cart.quantityForProduct(product: item)) * (Double(item.price) ?? 0)))")
                                .font(.headline)
                                .foregroundColor(Color("CustomBlack"))
                        }
                        .padding(10)
                        .swipeActions (edge: .trailing){
                            Button(role: .destructive) {
                                cart.removeProductComplete(product: item)
                            } label : {
                                Label("Supprimer", systemImage: "trash")
                            }
                            Button {
                                cart.removeFromCart(product: item)
                            } label : {
                                Label("Réduire", systemImage: "minus.circle")
                            }
                            .tint(.orange)
                            
                            
                        }
                        
                    }
                   
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal)
            }
            if !cart.items.isEmpty {
                Button(action: {
                    showAlert = true
                }) {
                    HStack{
                        Text("Commander - Total : $\(String(format: "%.2f", cart.totalPrice()))")
                            .font(.headline)
                            .foregroundStyle(Color("CustomGreen"))
                            
                            
                        Image("Delivery van")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("CustomYellow"))
                    .cornerRadius(10)
                    .padding()
                }
            }
            }
        .navigationBarTitle("Mon panier")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Commande effectuée"), message: Text("Votre commande est en cours de préparation."))
        }
        
        
    }
    private func deleteItem(offsets: IndexSet) {
        for index in offsets {
            let item = cart.items[index]
            cart.removeFromCart(product: item)
        }
        
    }
}






extension Product {
    static let example = Product(
        id: 1,
        title: "Salade Grecque",
        description: "Une salade fraîche et savoureuse avec des légumes croquants.",
        price: "10",
        image: "https://example.com/salad.jpg",
        category: "Entrées"
    )
}

// Prévisualisation de la vue CartView avec un produit exemple
#Preview {
    let cart = Cart()
    cart.addToCart(product: Product.example) // Ajouter le produit d’exemple au panier
    
    return CartView()
        .environmentObject(cart)
}


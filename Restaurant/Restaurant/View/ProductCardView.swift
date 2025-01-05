//
//  ProductCardView.swift
//  Restaurant
//
//  Created by Dusan Fama on 05.01.2025.
//

import SwiftUI
import SwiftData

struct ProductCard: View {
    let product: Product
    
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        VStack {
            HStack{
                VStack (alignment: .leading){
                    Text(product.title)
                        .font(.headline)
                    
                    Text(product.description)
                        .font(.subheadline)
                        .padding(.top, 5)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.6)
                Spacer()
                
                
                AsyncImage(url: URL(string: product.image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else if phase.error != nil {
                        Color.red
                            .frame(width: 150,height: 150)
                    } else {
                        ProgressView()
                            .frame(width: 150,height: 150)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            HStack {
                Text("$\(product.price)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("CustomBlack"))
                    .padding(.top, 5)
                Spacer()
                if cart.quantityForProduct(product: product) == 0 {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            cart.addToCart(product: product)
                        }
                    }) {
                        Text("Ajouté au panier")
                            .foregroundColor(Color("CustomGreen"))
                            .padding(10)
                            .background(Color("CustomYellow"))
                            .cornerRadius(8)
                    }
                } else {
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                cart.removeFromCart(product: product)
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                        
                        Text("\(cart.quantityForProduct(product: product))")
                            .font(.headline)
                            .padding(.horizontal, 8)
                        
                        Button(action: {
                            withAnimation(.easeInOut) {
                                cart.addToCart(product: product)
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundColor(.green)
                        }
                    }
                    .frame(width: 150)
                }
            }
            Divider()
                .background(Color("CustomGreen"))
                .padding(.top, 8)
          //  .transition(.scale)
        }
    }
}





                
                
        
    



extension ProductViewModel {
    static func mock() -> ProductViewModel {
        let viewModel = ProductViewModel()
        viewModel.products = [
            Product(id: 1, title: "Sushi Saumon", description: "Délicieux sushi au saumon", price: "15.00", image: "https://via.placeholder.com/150", category: "Sushi"),
            Product(id: 2, title: "Maki Avocat", description: "Maki frais avec avocat", price: "12.50", image: "https://via.placeholder.com/150", category: "Maki")
        ]
        return viewModel
    }
}

#Preview {
    let viewModel = ProductViewModel.mock()
    List(viewModel.products) { product in
        ProductCard(product: product)
            .environmentObject(Cart()) // Passer un environnement simulé si nécessaire
    }
}

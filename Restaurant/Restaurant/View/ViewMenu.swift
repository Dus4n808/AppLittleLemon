//
//  Menu.swift
//  Restaurant
//
//  Created by Dusan Fama on 27.12.2024.
//

import SwiftUI

struct ViewMenu: View {
    @StateObject private var viewModel = ProductViewModel()
    @EnvironmentObject var cart: Cart
    @State private var scale: Bool = false
   

    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Chargement...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    VStack(spacing: 16) {
                        ForEach(viewModel.products) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                ProductCard(product: product)
                            }
                            .buttonStyle(PlainButtonStyle()) // Supprime le style par défaut
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartView()) {
                        ZStack {
                            Image(systemName: "cart")
                                .font(.title2) // Taille du panier
                                .foregroundStyle(Color("CustomGreen"))

                            if cart.totalQuantity() > 0 {
                                Text("\(cart.totalQuantity())")
                                    .font(.caption) // Taille du texte pour le numéro
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 15, y: 9) // Positionner le numéro
                                    .scaleEffect(scale ? 1.2 : 1.0)
                                    .animation(.easeInOut(duration: 0.2), value: scale)
                                    .onChange(of: cart.totalQuantity()) {
                                        withAnimation {
                                            scale = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            withAnimation {
                                                scale = false
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: UserProfile()) {
                        Image(systemName: "person.circle")
                            .font(.title2)
                            .foregroundStyle(Color("CustomGreen"))
                    }
                }
            }
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}


struct ProductCard: View {
    let product: Product

    @EnvironmentObject var cart: Cart
    
    var body: some View {
        VStack (alignment: .leading) {
            AsyncImage(url: URL(string: product.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else if phase.error != nil {
                    Color.red
                        .frame(height: 150)
                } else {
                    ProgressView()
                        .frame(height: 150)
                }
            }
            
            HStack{
                VStack (alignment: .leading){
                    Text(product.title)
                        .font(.headline)
                        .padding(.top, 5)
                    Text("$\(product.price)")
                        .font(.subheadline)
                        .foregroundColor(Color("CustomBlack"))
                }
                .padding()
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
                }
            }
            .transition(.scale)
        }
        .background(Color.white)
        .cornerRadius(8)
        
    }
}

struct ProductDetailView: View {
    let product: Product
    @State private var quantity: Int = 0
    
    var body: some View {
        VStack (alignment: .leading){
            AsyncImage(url: URL(string: product.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 400, height: 400)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else if phase.error != nil {
                    Color.red
                        .frame(width: 300, height: 300)
                } else {
                    ProgressView()
                        .frame(width: 300, height: 300)
                }
            }
            HStack {
                Text(product.title)
                    .font(.title)
                Spacer()
                Text("$\(product.price)")
                    .font(.title2)
            }
            .padding()
            Text(product.description)
                .font(.body)
                .padding()
            Spacer()
            

            
        }
    }
}




struct ProductRow: View {
    let product: Product

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else if phase.error != nil {
                    Color.red // En cas d'erreur
                        .frame(width: 50, height: 50)
                } else {
                    ProgressView() // Chargement
                        .frame(width: 50, height: 50)
                }
            }


            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text("$\(product.price)")
                    .font(.headline)
                    .foregroundColor(.gray)
            }

        }
    }
}

#Preview {
    ViewMenu()
        .environmentObject(ProductViewModel())
        .environmentObject(Cart())
}

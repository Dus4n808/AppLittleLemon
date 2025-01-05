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
                // Bloc regroupé
                VStack(spacing: 10) {
                    HeroView(searchText: $viewModel.searchText)
                        .padding(.top, 10)
                    
                    // Barre des catégories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            // Bouton pour réinitialiser le filtre de catégorie
                            Button(action: {
                                withAnimation {
                                    viewModel.selectedCategory = nil
                                }
                            }) {
                                Text("All")
                                    .padding()
                                    .background(viewModel.selectedCategory == nil ? Color("CustomGreen") : Color.gray.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                            // Boutons pour chaque catégorie
                            ForEach(viewModel.categories, id: \.self) { category in
                                Button(action: {
                                    withAnimation {
                                        viewModel.selectedCategory = category
                                    }
                                }) {
                                    Text(category.capitalized)
                                        .padding()
                                        .background(viewModel.selectedCategory == category ? Color("CustomGreen") : Color.gray.opacity(0.2))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Titre "Menu"
                    Text("Menu")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
                .background(Color.white) // Couleur de fond optionnelle
                .padding(.bottom, 10) // Espacement entre le bloc et le reste
                
                // Liste des produits
                if viewModel.isLoading {
                    ProgressView("Chargement...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    VStack(spacing: 16) {
                        ForEach(viewModel.filteredProducts) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                ProductCard(product: product)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartView()) {
                        ZStack {
                            Image(systemName: "cart")
                                .font(.title2)
                                .foregroundStyle(Color("CustomGreen"))

                            if cart.totalQuantity() > 0 {
                                Text("\(cart.totalQuantity())")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 15, y: 9)
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
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: UserProfile()) {
                        Image("Profile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color("CustomGreen"), lineWidth: 2))
                    }
                }
            }
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}











#Preview {
    ViewMenu()
        .environmentObject(ProductViewModel())
        .environmentObject(Cart())
}

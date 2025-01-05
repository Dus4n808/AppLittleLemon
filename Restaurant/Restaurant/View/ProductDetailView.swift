//
//  ProductDetailView.swift
//  Restaurant
//
//  Created by Dusan Fama on 05.01.2025.
//

import SwiftUI
import SwiftData

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

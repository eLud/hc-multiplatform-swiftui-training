//
//  RestaurantDetailsView.swift
//  
//
//  Created by Ludovic Ollagnier on 27/06/2023.
//

import SwiftUI

public struct RestaurantDetailsView: View {

    let restaurant: Restaurant
    @State private var showImage = true

    public init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }

    public var body: some View {
        VStack {
            header
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.title)
                Text(restaurant.address)
                    .font(.subheadline)
            }
            .animation(.easeInOut, value: showImage)
            .onTapGesture {
                withAnimation {
                    showImage.toggle()
                }
            }
            Spacer()
        }
        .navigationTitle(restaurant.name)
    }

    @ViewBuilder
    private var header: some View {
        if showImage {
            AsyncImage(url: restaurant.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "cup.and.saucer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .animation(.easeInOut, value: showImage)
            .transition(.opacity.combined(with: .move(edge: .top)))
        }
    }
}

struct RestaurantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailsView(restaurant:
                                Restaurant(name: "Demo restaurant",
                                           address: "1 Infinite Loop,\nCupertino",
                                           restaurantType: .both,
                                           foodStyle: .burger))
    }
}

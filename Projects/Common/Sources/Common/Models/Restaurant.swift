//
//  Restaurant.swift
//  FouDeFood
//
//  Created by Ludovic Ollagnier on 27/06/2023.
//

import Foundation

public struct Restaurant: Codable, Identifiable, Hashable {

    public enum RestaurantType: String, Codable, CaseIterable, Identifiable {
        case takeAway
        case onSite
        case both

        public var id: RestaurantType { self }
    }

    public enum FoodStyle: String, Codable, CaseIterable, Identifiable {
        case japanese
        case indian
        case european
        case italian
        case burger

        public var id: FoodStyle { self }
    }

    public var id: UUID
    public var name: String
    public var address: String
    public var restaurantType: RestaurantType
    public var foodStyle: FoodStyle
    public var imageURL: URL?

    public init(name: String, address: String, restaurantType: Restaurant.RestaurantType, foodStyle: Restaurant.FoodStyle) {
        self.id = UUID()
        self.name = name
        self.address = address
        self.restaurantType = restaurantType
        self.foodStyle = foodStyle
    }
}

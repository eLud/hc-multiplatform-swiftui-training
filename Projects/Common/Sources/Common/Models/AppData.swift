//
//  AppData.swift
//  FouDeFood
//
//  Created by Ludovic Ollagnier on 27/06/2023.
//

import Foundation

public class AppData: ObservableObject {

    @Published public private(set) var restaurants: [Restaurant]
    @Published public var isLoading = false

    public init(fakeData: Bool = false) {
        isLoading = true
        if fakeData {
            let numberOfFakes = 10
            var fake: [Restaurant] = []
            for i in 0..<numberOfFakes {
                let rest = Restaurant(name: "Restaurant \(i)", address: "Address \(i)", restaurantType: .allCases.randomElement() ?? .onSite, foodStyle: .allCases.randomElement() ?? .european)
                fake.append(rest)
            }
            restaurants = fake
        } else {
            restaurants = []
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.isLoading = false
        }
    }

    public func addRestaurant(_ restaurant: Restaurant) {
        restaurants.append(restaurant)
    }
}

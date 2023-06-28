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

    public let requester = Requester(baseURL: URL(string: "http://192.168.1.155:8080")!)

    public init(fakeData: Bool = false) {
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
            Task { @MainActor in
                self.isLoading = true
                restaurants = await requester.getAllRestaurants()
                self.isLoading = false
            }
        }

    }

    public func addRestaurant(_ restaurant: Restaurant) async -> Restaurant? {
        guard let response = await requester.add(restaurant: restaurant) else { return nil }
        restaurants.append(response)
        return response
    }

    @MainActor
    public func refreshData() async {
        let response = await requester.getAllRestaurants()
        restaurants = response
    }

    public func addImage(_ image: Data, to restaurant: Restaurant) async {
        if let response = await requester.setImage(image, to: restaurant),
            let index = restaurants.firstIndex(where: {$0.id == response.id}) {
            restaurants[index].imageURL = response.imageURL
        }
    }
}

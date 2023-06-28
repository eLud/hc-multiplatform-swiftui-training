//
//  RestaurantCreationFormView.swift
//  FouDeFood
//
//  Created by Ludovic Ollagnier on 27/06/2023.
//

import SwiftUI

public struct RestaurantCreationFormView: View {

    @EnvironmentObject private var data: AppData
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var address: String = ""
    @State private var foodStyle: Restaurant.FoodStyle = .japanese
    @State private var restaurantType: Restaurant.RestaurantType = .onSite
    @State private var setImageOnCreation = false

    public init() { }

    public var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Address", text: $address)
            Picker("Food Style", selection: $foodStyle) {
                ForEach(Restaurant.FoodStyle.allCases) { style in
                    Text(style.rawValue)
                        .tag(style)
                }
            }
            Picker("Restaurant type", selection: $restaurantType) {
                ForEach(Restaurant.RestaurantType.allCases) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            Section {
                Button("Create restaurant") {
                    let resto = Restaurant(name: name, address: address, restaurantType: restaurantType, foodStyle: foodStyle)
                    Task {
                        _ = await data.addRestaurant(resto)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct RestaurantCreationFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RestaurantCreationFormView()
        }
    }
}

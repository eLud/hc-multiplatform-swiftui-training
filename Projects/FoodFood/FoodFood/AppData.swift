//
//  AppData.swift
//  FoodFood
//
//  Created by Ludovic Ollagnier on 26/06/2023.
//

import Foundation

class AppData: ObservableObject {

    // Publish the new value automatically on change
    @Published var username: String = "Ludovic"
    @Published var score: Int = 10

    private var something = ""

    func updateUsername(_ username: String) {
        // Publish the new value when called on change
        objectWillChange.send()
        self.username = username
    }
}

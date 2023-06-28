//
//  FouDeFoodTVApp.swift
//  FouDeFoodTV
//
//  Created by Ludovic Ollagnier on 28/06/2023.
//

import SwiftUI
import Common

@main
struct FouDeFoodTVApp: App {

    @StateObject private var data = AppData()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environmentObject(data)
        }
    }
}

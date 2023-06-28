//
//  FouDeFoodApp.swift
//  FouDeFood
//
//  Created by Ludovic Ollagnier on 27/06/2023.
//

import SwiftUI
import Common

@main
struct FouDeFoodApp: App {

    @StateObject private var data = AppData(fakeData: true)

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationSplitView {
                    FoodListView()
                } detail: {
                    Label("Select a restaurant", systemImage: "fork.knife.circle")
                }
                .navigationSplitViewStyle(.balanced)
                .tabItem {
                    Label("Food", systemImage: "fork.knife.circle")
                }
                FoodOrderView()
                    .tabItem {
                        Label("Order", systemImage: "takeoutbag.and.cup.and.straw")
                    }
            }
                .environmentObject(data)
        }
    }
}

//
//  FoodFoodApp.swift
//  FoodFood
//
//  Created by Ludovic Ollagnier on 26/06/2023.
//

import SwiftUI

@main
struct FoodFoodApp: App {

    @StateObject private var data = AppData()
    @State private var selected: String = "1"

    var body: some Scene {
        WindowGroup {
            TabView(selection: $selected) {
                ObjectDemo()
                    .tabItem {
                        Label("ObjectDemo", systemImage: "pencil.circle")
                    }
                    .tag("0")
                Text("A")
                    .tag("1")
                    .tabItem {
                        Label("A", systemImage: "a.circle")
                    }
                Button("B") {
                    selected = "3"
                }
                .sheet(isPresented: .constant(true), content: {
                    Text("Modal")
                        .presentationDetents([.fraction(0.3), .large])
                })
                .tabItem {
                    Label("B", systemImage: "b.circle")
                }
                .tag("2")
                NavigationStack {
                    VStack {
                        TextField("Text", text: .constant("hghg"))
                        NavigationLink(destination: ContentView(), label: { Text("Navigate") })
                    }
                    .navigationTitle("C")
                    .toolbar {
                        ToolbarItem {
                            Button("Leading Bar button") {

                            }
                        }
                        ToolbarItem {
                            Button("Trailing Bar button") {

                            }
                        }
                        ToolbarItem(placement: .keyboard) {
                            Button("Keyboard") {

                            }
                        }
                        ToolbarItem {
                            Button("Bottom") {

                            }
                        }
                        ToolbarItem(placement: .status) {
                            Button("Status") {

                            }
                        }
                }
                }
                .tabItem {
                    Label("C", systemImage: "c.circle")
                }
                    .tag("3")
            }
            .environmentObject(data)
        }
    }
}

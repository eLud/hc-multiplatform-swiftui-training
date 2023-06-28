//
//  FoodListView.swift
//  FouDeFood
//
//  Created by Ludovic Ollagnier on 27/06/2023.
//

import SwiftUI
import Common

struct FoodListView: View {

    @EnvironmentObject private var data: AppData
    @State private var showForm = false

    var body: some View {
            if data.isLoading {
                ProgressView()
            } else {
                List(data.restaurants, id: \.name) { r in
                    NavigationLink {
                        RestaurantDetailsView(restaurant: r)
                    } label: {
                        ImageAndSubtitleView(title: r.name, subtitle: r.address, image: Image("meat"), imageURL: r.imageURL)
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button(action: toggleForm) {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
                .navigationTitle("Foodies")
                .sheet(isPresented: $showForm) {
                    RestaurantCreationFormView()
                        .presentationDetents([.medium])
                }
            }
    }

    private func toggleForm() {
        showForm.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
            .environmentObject(AppData(fakeData: true))
    }
}

//
//  ContentView.swift
//  FouDeFoodTV
//
//  Created by Ludovic Ollagnier on 28/06/2023.
//

import SwiftUI
import Common

struct ContentView: View {

    @EnvironmentObject private var data: AppData
    let columns: [GridItem] = [GridItem()]

    @State private var showPanel = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Last restaurants")
                    .font(.headline)
                lastRestaurantsScrollView

                Text("Last restaurants")
                    .font(.headline)
                lastRestaurantsScrollView
            }
            .overlay(alignment: .trailing) {
                if showPanel {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.thinMaterial)
                        .frame(width: 400)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                        .edgesIgnoringSafeArea(.trailing)
                }
            }
        }
    }

    private var lastRestaurantsScrollView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns) {
                ForEach(data.restaurants) { r in
                    RestaurantImageCell(restaurant: r)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppData())
    }
}

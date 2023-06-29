//
//  FoodListView.swift
//  FouDeFood
//
//  Created by Ludovic Ollagnier on 27/06/2023.
//

import SwiftUI

public struct FoodListView: View {

    @EnvironmentObject private var data: AppData
    @State private var showForm = false

    #if os(macOS)
    @Environment(\.openWindow) var openWindow
    #endif

    public init() {}

    public var body: some View {
            if data.isLoading {
                ProgressView()
            } else {
                List(data.restaurants, id: \.name) { r in
                    NavigationLink {
                        RestaurantDetailsView(restaurant: r)
                    } label: {
                        ImageAndSubtitleView(title: r.name, subtitle: r.address, image: Image("meat", bundle: Bundle.module), imageURL: r.imageURL)
                            .contextMenu(ContextMenu(menuItems: {
                                Button("Open in new window…") {
                                    openWindow(value: r)
                                }
                            }))
                    }
                }
                #if os(watchOS)
                .listStyle(.carousel)
                #endif
                .toolbar {
                    ToolbarItem {
                        Button(action: toggleForm) {
                            Label("Add", systemImage: "plus")
                        }
                #if os(macOS) || os(iOS)
                        .keyboardShortcut(.init("n"), modifiers: [.command, .shift])
                #endif
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
        #if os(macOS)
        openWindow(id: "new-resto-window")
        #else
        showForm.toggle()
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
            .environmentObject(AppData(fakeData: true))
    }
}

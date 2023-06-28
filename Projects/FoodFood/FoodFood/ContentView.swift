//
//  ContentView.swift
//  FoodFood
//
//  Created by Ludovic Ollagnier on 26/06/2023.
//

import SwiftUI

struct ContentView: View {

    @State private var message = "Initial value"
    @State private var isOn = false

//    Value type
//    @State // La source
//    @Binding // View qui peut modifier la source
//
//    @Environment
//
//    Class
//    @StateObject
//    @ObservedObject
//
//    @EnvironmentObject

    var body: some View {
        VStack {
            Toggle("", isOn: $isOn)
            Text("message from ContentView : \(message)")
            header
            BadgedButton(text: $message)
            footer
        }
    }

    private var header: some View {
        TextField("Type something", text: $message)
            .textFieldStyle(.roundedBorder)
            .padding()
    }

    private var footer: some View {
        Button("Button ContentView", action: buttonAction)
    }

    private func buttonAction() {
        message = "Hello World!"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}

struct BadgedButton: View {

    @Binding var text: String

    var body: some View {
        VStack {
            Text(text)
                .badgedView()
            Button("BadgedButton Button") {
                text = ""
            }
                .badgedView(foregroundColor: .red)
        }
    }
}

extension View {
    func badgedView(foregroundColor: Color = .white) -> some View {
        self
            .foregroundColor(foregroundColor)
            .bold()
            .padding()
            .background {
                Color.blue
            }
            .cornerRadius(12)
            .shadow(radius: 8.0)
    }
}

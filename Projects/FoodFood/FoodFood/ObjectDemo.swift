//
//  ObjectDemo.swift
//  FoodFood
//
//  Created by Ludovic Ollagnier on 26/06/2023.
//

import SwiftUI

struct ObjectDemo: View {

    @EnvironmentObject private var data: AppData
    @SceneStorage("username") private var desiredUsername = ""
    @AppStorage("appstorage") private var appStorage = ""

    var body: some View {
        VStack {
            UsernameView(data: data)
                .environment(\.colorScheme, .dark)
            ScoreView()
            TextField("Desired Username", text: $desiredUsername)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Change username") {
                data.username = desiredUsername
            }
            TextField("AppStorage", text: $appStorage)
                .textFieldStyle(.roundedBorder)
                .padding()
            CustomShape()
        }
    }
}

struct CustomShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        return path
    }
}

struct UsernameView: View {

    @ObservedObject var data: AppData
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Text(data.username)
            .foregroundColor(colorScheme == .dark ? .red : .blue)
    }
}

struct ScoreView: View {

    @EnvironmentObject private var data: AppData

    var body: some View {
        Text("\(data.score)")
            .bold()
            .environment(\.username, "ludovic")
    }
}

struct ObjectDemo_Previews: PreviewProvider {
    static var previews: some View {
        ObjectDemo()
            .environmentObject(AppData())
    }
}

// Store custom values in Environment
struct UsernameValue: EnvironmentKey {
    static var defaultValue: String = ""
}

extension EnvironmentValues {
    var username: String {
        get {
            self[UsernameValue.self]
        }

        set {
            self[UsernameValue.self] = newValue
        }
    }
}

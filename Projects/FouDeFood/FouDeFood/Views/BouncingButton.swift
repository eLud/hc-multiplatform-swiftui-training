//
//  BouncingButton.swift
//  FouDeFood
//
//  Created by Ludovic Ollagnier on 27/06/2023.
//

import SwiftUI

struct BouncingButton: View {

    @State var bounce = false

    var body: some View {
        Button {
            bounce = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)) {
                bounce = false
            }
        } label: {
            Image(systemName: "heart.fill")
                .imageScale(.large)
                .font(.largeTitle)
                .scaleEffect(bounce ? 1.2 : 1.0)
        }
        .animation(.spring().repeatCount(4), value: bounce)
        .padding()
    }
}

struct BouncingButton_Previews: PreviewProvider {
    static var previews: some View {
        BouncingButton()
    }
}

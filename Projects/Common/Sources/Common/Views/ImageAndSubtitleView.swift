//
//  ImageAndSubtitleView.swift
//  FouDeFood
//
//  Created by Ludovic Ollagnier on 27/06/2023.
//

import SwiftUI

public struct ImageAndSubtitleView: View {

    let title: String
    let subtitle: String
    let image: Image?
    let imageURL: URL?

    public init(title: String, subtitle: String, image: Image?, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.imageURL = imageURL
    }

    public var body: some View {
        HStack {
            imageView
                .frame(height: 60.0)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }

    @ViewBuilder
    private var imageView: some View {
        if let imageURL {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)

            } placeholder: {
                placeholder
                    .resizable()
                    .cornerRadius(8)
                    .padding(4)
            }
        } else if let image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .padding(4)
        }
    }

    private var placeholder: Image {
        image ?? Image(systemName: "cup.and.saucer")
    }
}

struct ImageAndSubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ImageAndSubtitleView(title: "Title", subtitle: "Subtitle", image: nil, imageURL: nil)
            ImageAndSubtitleView(title: "Title", subtitle: "Subtitle", image: Image("meat", bundle: Bundle.module), imageURL: nil)
        }
            .previewLayout(.sizeThatFits)
    }
}

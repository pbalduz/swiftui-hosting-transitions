//
//  DetailsScreen.swift
//  MatchedTransitions
//
//  Created by Igor Kharytaniuk on 20.07.24.
//

import SwiftUI

struct DetailsScreen: View {
    let book: Book
    var body: some View {
        VStack(alignment: .center,spacing: 32) {
            if let imagePath = book.data.image {
                if let cachedImage = DataManager.shared.imageCache[imagePath] {
                    cachedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .matchedGeometry(id: "image_\(book.id)", isSource: false)
                } else {
                    AsyncImage(url: URL(string: imagePath)) { image in
                        DataManager.shared.imageCache[imagePath] = image
                        return image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 250, height: 250)
                    .matchedGeometry(id: "image_\(book.id)", isSource: false)
                }
            } else {
                Image(systemName: "photo")
                    .matchedGeometry(id: "image_\(book.id)", isSource: false)
            }
            Text(book.title)
                .font(.largeTitle)
                .matchedGeometry(id: "title_\(book.id)", isSource: false)
            HStack {
                Text("Downloads:")
                    .matchedGeometry(id: "downloads_label_\(book.id)", isSource: false)
                Text(String(book.downloads))
                    .matchedGeometry(id: "downloads_value_\(book.id)", isSource: false)
            }
            .font(.title3)
            .foregroundColor(.gray)
            Spacer()
        }
        .padding(.all, 16)
    }
}

#Preview {
    DetailsScreen(book: Book(id: 1513,
                             title: "Romeo and Juliet",
                             downloads: 54135,
                             data: BookDataformat(image: "https://www.gutenberg.org/cache/epub/145/pg145.cover.medium.jpg")))
    .environmentObject(MatchedGeometryState())
}

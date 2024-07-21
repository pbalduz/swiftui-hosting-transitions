//
//  ListScreen.swift
//  MatchedTransitions
//
//  Created by Igor Kharytaniuk on 20.07.24.
//

import SwiftUI

struct ListScreen: View {
    @State var booksList: [Book] = []
    
    var body: some View {
        List(booksList) { book in
            HStack(spacing: 16) {
                if let imagePath = book.data.image {
                    if let cachedImage = DataManager.shared.imageCache[imagePath] {
                        cachedImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .matchedGeometry(id: "image_\(book.id)", isSource: true)
                    } else {
                        AsyncImage(url: URL(string: imagePath)) { image in
                            DataManager.shared.imageCache[imagePath] = image
                            return image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .matchedGeometry(id: "image_\(book.id)", isSource: true)
                    }
                } else {
                    Image(systemName: "photo")
                        .matchedGeometry(id: "image_\(book.id)", isSource: true)
                }
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.title3)
                        .matchedGeometry(id: "title_\(book.id)", isSource: true)
                    HStack {
                        Text("Downloads:")
                            .matchedGeometry(id: "downloads_label_\(book.id)", isSource: true)
                        Text(String(book.downloads))
                            .matchedGeometry(id: "downloads_value_\(book.id)", isSource: true)
                            
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                }
            }
            .onTapGesture { [self, book] in
                showBookDetailsScreen(book)
            }
        }
        .task {
            booksList = (try? await DataManager.shared.fetchBooks()) ?? []
        }
    }
    
    private func showBookDetailsScreen(_ book: Book) {
        guard let navigationViewController = UIApplication.shared
            .connectedScenes
            .compactMap({
                ($0 as? UIWindowScene)?.keyWindow
            })
            .first?
            .rootViewController as? UINavigationController else {
                return
            }
        
        guard let listViewController = navigationViewController.topViewController as? ListViewController else {
            return
        }
        
        let detailsViewController = DetailsViewController(book: book, state: listViewController.state)
        detailsViewController.navigationItem.title = "Details"
        navigationViewController.pushViewController(detailsViewController, animated: true)
    }
}

#Preview {
    ListScreen()
        .environmentObject(MatchedGeometryState())
}

//
//  ContentView.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 4/21/25.
//

import SwiftUI
import UIKit

struct MoviesView: View {
    
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        List(viewModel.movies) { movie in
            HStack {
                AsyncImage(url: movie.posterURL) { poster in
                    poster.resizable().aspectRatio(contentMode: .fill)
                        .frame(width: 100)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100)
                }
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.overview)
                        .font(.caption)
                        .lineLimit(3)
                }
            }
        }
        .searchable(text: $viewModel.searchQuery)
        .onAppear {
            viewModel.fetchInitialData()
        }
    }
}

#Preview {
    MoviesView()
}

class VC: UIViewController {
    
}

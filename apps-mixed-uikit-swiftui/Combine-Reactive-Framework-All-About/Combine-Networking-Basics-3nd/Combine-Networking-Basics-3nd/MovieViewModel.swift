//
//  MovieViewModel.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 5/5/25.
//

import Foundation

final class MovieViewModel: ObservableObject {
    @Published var movie: [Movie] = []
    
    func fetchInitialData() {
        fetchMovies()
            .map(\.results)
            .receive(on: DispatchQueue.main)
    }
}

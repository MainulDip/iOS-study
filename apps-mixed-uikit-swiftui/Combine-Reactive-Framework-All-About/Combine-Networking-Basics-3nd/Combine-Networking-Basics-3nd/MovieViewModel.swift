//
//  MovieViewModel.swift
//  Combine-Networking-Basics-3nd
//
//  Created by Mainul Dip on 5/5/25.
//

import Foundation
import Combine

final class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    var cancellables: Set<AnyCancellable> = []
    
    func fetchInitialData() {
        fetchMovies()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .catch { error in
                print("Error: \(error)")
                return Empty<[Movie], Never>()
            }
            .assign(to: \.movies, on: self)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    print("Network Fetching Success and Completes")
//                case .failure(let failure):
//                    print("Network Request Failed: \(failure)")
//                }
//            }, receiveValue: { [weak self] movies in
//                self?.movies = movies
//            })
            .store(in: &cancellables)
    }
}

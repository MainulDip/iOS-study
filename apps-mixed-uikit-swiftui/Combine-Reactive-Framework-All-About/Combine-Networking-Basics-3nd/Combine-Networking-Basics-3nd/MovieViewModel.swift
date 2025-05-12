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
    @Published var searchResult: [Movie] = []
    @Published var searchQuery = ""
    @Published var sth = "Hello World"
    @Published var sthArr = [1,2,3]
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        let a = $searchQuery
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
        let b = a.map { searchText in
                let q = searchMovies(for: searchText)
                    .replaceError(with: MovieResponse(results: []))
                
                return q
            }
        /*
         let q: Publishers.ReplaceError<some Publisher<MovieResponse, any Error>>
         
         .switchToLatest
         Available when Failure is Never, Output conforms to Publisher, and Output.Failure is Never.
         */
        let _ = b.switchToLatest()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .assign(to: &$searchResult)
    }
    
    func fetchInitialData() {
        
        
        $sth.sink { conplition in
             switch conplition {
             case .finished:
                 print("")
             }
        } receiveValue: { value in
            print("value")
        }
        .store(in: &cancellables)

        
        fetchMovies()
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .catch { error in
                print("Error in Catch: \(error)")
                return Empty<[Movie], Never>()
            }
//            .replaceEmpty(with: [])
            .assign(to: &$movies)
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
//            .store(in: &cancellables)
    }
}

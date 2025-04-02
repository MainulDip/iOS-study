//
//  ContentView.swift
//  Async-Await-API-SwiftUI-Second
//
//  Created by Mainul Dip on 4/1/25.
//

import SwiftUI

enum NetworkError: Error {
    case invalidURLError
    case serverError
    case decodingError
}

struct CourseModel: Codable, Identifiable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    let numberOfLessons: Int
}

// @MainActor
class ContentViewModel: ObservableObject, @unchecked Sendable {
    /* @unchecked Sendable https://stackoverflow.com/questions/74450039/how-come-a-mainactor-isolated-mutable-stored-property-gives-a-sendable-error
     */
    
    @Published var isFetching = false
    @Published var courses: [CourseModel] = []
    
    init() {
        // fetch data will be called here
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isFetching = true
        }
    }
    
    // @MainActor
    func fetchData() async throws {
        // build url using guard let
        guard let url = URL(string: K.endpoint) else { throw NetworkError.invalidURLError }
        
        // create session and Request
        let sharedSession = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        // call session with the url and get (data, urlResponse)
        
        let (data, urlResponse) = try await sharedSession.data(for: urlRequest)
        
        // guard the urlResponse and if the reponsecode is 200
        guard let urlResponse = urlResponse as? HTTPURLResponse, urlResponse.statusCode == 200 else { throw NetworkError.serverError }
        
        // creace JSONDecoder() instance and guard and decode the api reponse based on model and populate this class prop which is published
        let jsonDecoder = JSONDecoder()
        // cusomize decoding policy if necessary
        
        //        do {
        let courses = try jsonDecoder.decode([CourseModel].self, from: data)
        
        // DispatchQuequ requires `Sendable` protocol conformation
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.courses = courses
            print("Data Updates")
        }
        
        // @MainActor will also work, anotate the ViewModel class or `the function that updates the UI `with @MainActor
        // So we don't need the `@unchecked Sendable` + `DispatchQueue.main` block
        
        //        } catch {
        //            throw NetworkError.decodingError
        //        }
        
    }
    
}

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isFetching {
                    Text("is fetching data from internet")
                }
                
                Text("All available courses")
                
                ForEach(viewModel.courses) { course in
                    AsyncImage(url: URL(string: course.imageUrl)) { image in
                        image.resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }

                    Text(course.name)
                }
            }
            .navigationTitle("Courses")
            .navigationBarItems(trailing: refreshButton)
            
        }
        .task {
            await fetchData()
        }
        
    }
    
    private var refreshButton: some View {
        Button {
            Task {
                viewModel.courses.removeAll()
                await fetchData()
            }
        } label: {
            Text("Refresh")
        }
    }
    
    private func fetchData() async {
        do {
            try await viewModel.fetchData()
        } catch {
            consoleNetworkError(err: error as! NetworkError)
        }
    }
    
    private func consoleNetworkError(err: NetworkError) {
        switch err {
        case .invalidURLError:
            print("InvalidURL Error")
        case .serverError:
            print("Server Error, not 200")
        case .decodingError:
            print("JSON to Model Decoding Error")
        }
    }
}

#Preview {
    ContentView()
}


class K {
    static let endpoint = "https://api.letsbuildthatapp.com/jsondecodable/courses"
}

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

class ContentViewModel: ObservableObject, Sendable {
    @Published var isFetching = false
    @Published var courses: [CourseModel] = []
    
    init() {
        // fetch data will be called here
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isFetching = true
        }
    }
    
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
        
//        do {
            let courses = try jsonDecoder.decode([CourseModel].self, from: data)
            
            // DispatchQuequ requires `Sendable` protocol conformation
            DispatchQueue.main.async {
                self.courses = courses
            }
            
            // @MainActor will also work, anotate the ViewModel class with @MainActor
            //
            
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
                    Text(course.name)
                }
            }
            .navigationTitle("Courses")
        }
        .task {
            do {
                try await viewModel.fetchData()
            } catch {
                switch error as! NetworkError {
                    
                case .invalidURLError:
                    print("InvalidURL Error")
                case .serverError:
                    print("Server Error, not 200")
                case .decodingError:
                    print("JSON to Model Decoding Error")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


class K {
    static let endpoint = "https://api.letsbuildthatapp.com/jsondecodable/courses"
}

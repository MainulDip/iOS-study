//
//  ContentView.swift
//  Async-Await-API-SwiftUI-First
//
//  Created by Mainul Dip on 3/27/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var githubUser: GithubUser?
    
    var body: some View {
        
        VStack {
            VStack (spacing: 20) {
                
                AsyncImage(url: URL(string: githubUser?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .foregroundColor(.gray)
                }
                .frame(width: 120, height: 120)

                
                Text(githubUser?.name ?? "Name not found")
                    .bold()
                    .font(.title)
                
                Text(githubUser?.bio ?? "This is for bio")
                    .padding()
                
                Spacer()
            }
            .padding()
        }
//        .onAppear {
//            runTask()
//        }
        .task {
            do {
                githubUser = try await fetchGithubUser()
                print(githubUser!.name)
            } catch {
                switch error as! NetworkError {
                case .urlBuildingError:
                    print("urlBuildingError")
                case .serverResponseError:
                    print("serverResponseError")
                case .decodingError:
                    print("decodingError")
                }
            }
        }
    }
    
    func runTask() {
         Task {
            do {
                let user = try await fetchGithubUser()
                DispatchQueue.main.async {
                    self.githubUser = user
                }
            } catch {
                switch error as! NetworkError {
                case .urlBuildingError:
                    print("urlBuildingError")
                case .serverResponseError:
                    print("serverResponseError")
                case .decodingError:
                    print("decodingError")
                }
            }
        }
    }
    
    func fetchGithubUser() async throws -> GithubUser {
        // buld URL
        guard let url = URL(string: K.githubUserEndPoint) else {
            throw NetworkError.urlBuildingError
        }
        
        // get shared session
        let sharedSession = URLSession.shared
        
        let (data, urlResponse) = try await sharedSession.data(from: url)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.serverResponseError
        }
        
        // when reponse is 200, now decode
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
             return try decoder.decode(GithubUser.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

#Preview {
    ContentView()
}

struct GithubUser: Codable {
    var name: String
    var avatarUrl: String
    var bio: String
}

class K {
    static let githubUserEndPoint = "https://api.github.com/users/MainulDip"
}

enum NetworkError: Error {
    case urlBuildingError
    case serverResponseError
    case decodingError
}


// TODO: Networking Async/Await First
/*
 - https://api.github.com/users/MainulDip
 - list all followers of a user https://api.github.com/users/MainulDip/followers
 
 - Build a screen with Profile Picture, Username and bio
 - Search `from where to call Network Request in SwiftUI`
 - struct GithubUser: Codable {
    let login: String
    let avatarUrl: String // json keys are `snake-case` but swift usages camelCase as convension
    let bio: String
 */

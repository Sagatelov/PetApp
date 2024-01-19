//
//  NetworkService.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.12.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getAllUsers(completionHandler: @escaping (Result<[UsersModel], Error>) -> Void) -> Void
    func getPostBy(userId: Int, completionHandler: @escaping (Result<[PostsModel], Error>) -> Void) -> Void
    func getCommentsBy(postId: Int, completionHandler: @escaping (Result<[CommentsModel], Error>) -> Void) -> Void
}

class NetworkService {
    
    enum HTTPMetod: String {
        case GET
        case PUT
        case POST
        case DELETE
        case PATCH
    }
    
    enum APIs: String {
        case posts
        case comments
        case users
    }
    
    let url = "https://jsonplaceholder.typicode.com/"
}

extension NetworkService: NetworkServiceProtocol {
    
    //MARK: - get all users from server
    
    func getAllUsers(completionHandler: @escaping (Result<[UsersModel], Error>) -> Void) {
        guard let url = URL(string: url + APIs.users.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler( .failure(error))
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                
                do {
                    let users = try JSONDecoder().decode([UsersModel].self, from: data)
                    completionHandler(.success(users))
                    
                } catch {
                    completionHandler(.failure(error))
                }
            }
        } .resume()
        
    }
    
    
    func editingUser(user: UsersModel, completionHandler: @escaping (Result<UsersModel, Error>) -> Void) {
        guard let url = URL(string: url + APIs.users.rawValue + "/" + String(user.id)),
              let data = try? JSONEncoder().encode(user) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMetod.PATCH.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            } else if let response = response as? HTTPURLResponse, 
                        self.successfulStatusCodes.contains(response.statusCode),
                        let data = data {
                do {
                    let data = try JSONDecoder().decode(UsersModel.self, from: data)
                    completionHandler(.success(data))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
    
    //MARK: - get posts by selected user
    
    func getPostBy(userId: Int, completionHandler: @escaping (Result<[PostsModel], Error>) -> Void) {
        guard let url = URL(string: url + APIs.posts.rawValue) else {return}
        
        var UrlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        UrlComponents?.queryItems = [URLQueryItem(name: "userId", value: "\(userId)")]
        
        guard let queryUrl = UrlComponents?.url else { return }
    
        URLSession.shared.dataTask(with: queryUrl) { data, response, error in
            if let error = error {
                completionHandler( .failure(error))
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                
                do {
                    let posts = try JSONDecoder().decode([PostsModel].self, from: data)
                    completionHandler(.success(posts))
                    
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
    
    
    //MARK: - get comments by selected post
    
    func getCommentsBy(postId: Int, completionHandler: @escaping (Result<[CommentsModel], Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        var urlComponets = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponets?.queryItems = [URLQueryItem(name: "postId", value: "\(postId)")]
        
        guard let queryUrl = urlComponets?.url else { return }
        
        URLSession.shared.dataTask(with: queryUrl) { data, response, error in
            if let error = error{
                completionHandler( .failure(error))
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                
                do {
                    let comments = try JSONDecoder().decode([CommentsModel].self, from: data)
                    completionHandler(.success(comments))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
    
  
    
}



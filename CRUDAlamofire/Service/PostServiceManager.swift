//
//  PostServiceManager.swift
//  CRUDAlamofire
//
//  Created by Rafael Gonzalez on 02/05/25.
//
import Foundation
import Alamofire

class PostServiceManager {
    static let shared = PostServiceManager()
    private var posts : [Post] = []
    
    private init() {}
    
    func countPosts() -> Int {
        return posts.count
    }
    
    func getPost(index: Int) -> Post {
        return posts[index]
    }
    
    func getPost(id: Int) -> Post? {
        return posts.first(where: { $0.id == id })
    }
    
    // CREATE - Create a new post
    func createPost(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        let url = Endpoint.createPost.url
        
        AF.request(url, method: .post, parameters: post, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: Post.self) { response in
                switch response.result {
                case .success(let post):
                    completion(.success(post))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // READ - Get all post
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = Endpoint.getPosts.url
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: [Post].self) { response in
                switch response.result {
                case .success(let posts):
                    completion(.success(posts))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // READ - Get a post by id
    func fetchPost(id: Int, completion: @escaping (Result<Post, Error>) -> Void) {
        let url = Endpoint.getPost(id).url
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: Post.self) { response in
                switch response.result {
                case .success(let post):
                    completion(.success(post))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // UPDATE - update a existing post
    func updatePost(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        guard let id = post.id else {
            completion(.failure(NSError(domain: "APIError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Post ID is required for update"])))
            return
        }
        
        let url = Endpoint.updatePost(id).url
        
        AF.request(url, method: .put, parameters: post, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: Post.self) { response in
                switch response.result {
                case .success(let updatedPost):
                    completion(.success(updatedPost))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // DELETE - Eliminar un post
    func deletePost(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = Endpoint.deletePost(id).url
        
        AF.request(url, method: .delete)
            .validate()
            .response { response in
                if let error = response.error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
}

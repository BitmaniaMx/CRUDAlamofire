//
//  Endpoint.swift
//  WSCRUD
//
//  Created by Rafael Gonzalez on 25/04/25.
//

import Foundation

enum Endpoint {
    static let baseURLString = "https://jsonplaceholder.typicode.com/"
    
    case createPost
    case updatePost(Int)
    case deletePost(Int)
    case getPosts
    case getPost(Int)
    
    var url: URL {
        switch self {
        case .createPost:
            return URL(string: "\(Endpoint.baseURLString)/posts")!
        case .updatePost(let id):
            return URL(string: "\(Endpoint.baseURLString)posts/\(id)")!
        case .deletePost(let id):
            return URL(string: "\(Endpoint.baseURLString)posts/\(id)")!
        case .getPosts:
            return URL(string: "\(Endpoint.baseURLString)posts/")!
        case .getPost(let id):
            return URL(string: "\(Endpoint.baseURLString)posts/\(id)")!
        }
    }
}

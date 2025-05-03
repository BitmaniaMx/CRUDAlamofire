//
//  Post.swift
//  CRUDAlamofire
//
//  Created by Rafael Gonzalez on 02/05/25.
//


struct Post: Codable {
    let id: Int? //optional because it is assigned from API
    let userId: Int
    let title: String
    let body: String
    
    init (id : Int? = nil, userId: Int, title: String, body: String) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
    }
}

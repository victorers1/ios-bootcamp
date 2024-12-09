//
//  PostData.swift
//  H4X0R
//
//  Created by Victor Emanuel Ribeiro Silva - VEM on 06/12/24.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}

//
//  PhotoResults.swift
//  unspashApp
//
//  Created by Sergey Simashov on 03.09.2022.
//

struct PhotoResults: Decodable {
    let total: Int
    let results: [Photos]
}

struct Photos: Decodable {
    let id: String
    let width: Int
    let height: Int
    let urls: urls
}

struct urls: Decodable {
    let small: String
}


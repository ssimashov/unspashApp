//
//  SearchPhotoResults.swift
//  unspashApp
//
//  Created by Sergey Simashov on 03.09.2022.
//

struct SearchPhotoResults: Codable {
    let results: [Photos]
}

struct Photos: Codable {
    let id: String
    let width: String
    let heihgt: String
    let urls: UrlResponce
}

struct UrlResponce: Codable {
    let small: String
}

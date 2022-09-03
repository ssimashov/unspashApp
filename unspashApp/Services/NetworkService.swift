//
//  NetworkService.swift
//  unspashApp
//
//  Created by Sergey Simashov on 03.09.2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    func searchPhoto (searchText: String, completion: @escaping ([Photos]) -> Void){
        let url = "https://api.unsplash.com/search/photos"
        let params: Parameters = [
            "query": searchText]
        AF.request(url, method: .get, parameters: params).responseData { response in
            guard let data = response.value else { return }
            do {
                let photos = try JSONDecoder().decode(SearchPhotoResults.self, from: data).results
                completion(photos)
            }
            catch {
                print(error)
            }
        }
    }
    
//    func getPhoto (photoId: String, completion: @escaping (GetPhotoResults) -> Void){
//        let url = "https://api.unsplash.com/photos/\(photoId)"
//
//        AF.request(url, method: .get).responseData { response in
//            guard let data = response.value else { return }
//            do {
//                let photo = try JSONDecoder().decode(GetPhotoResults.self, from: data).results
//                completion(photo)
//            }
//            catch {
//                print(error)
//            }
//        }
//    }
    
}

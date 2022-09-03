//
//  NetworkService.swift
//  unspashApp
//
//  Created by Sergey Simashov on 03.09.2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    func searchPhotos(searchText: String, completion: @escaping ([Photos]) -> Void) {
        
        let url = "https://api.unsplash.com/search/photos"
        
        let header: HTTPHeaders = [
            "Authorization": "Client-ID eTMuOjYsTqucqjFME7pde2fYjID_wYPsNXK02c4S4ps"
        ]
        
        let params: Parameters = [
            "query": searchText,
            "per_page": "20"
        ]
        
        AF.request(url, method: .get, parameters: params,
                   headers: header).responseData { response in
            guard let data = response.value else { return }
            do {
                let photos = try JSONDecoder().decode(SearchPhotosResults.self, from: data).results
                completion(photos)
            } catch {
                print(error)
            }
        }
    }
    
    
    func getPhoto (photoId: String, completion: @escaping (GetPhotoResults) -> Void){
        let url = "https://api.unsplash.com/photos/\(photoId)"
        
        let header: HTTPHeaders = [
            "Authorization": "Client-ID eTMuOjYsTqucqjFME7pde2fYjID_wYPsNXK02c4S4ps"
        ]
        
        AF.request(url, method: .get, headers: header).responseData { response in
            guard let data = response.value else { return }
            do {
                let photo = try JSONDecoder().decode(GetPhotoResults.self, from: data)
                completion(photo)
            } catch {
                print(error)
            }
        }
        
    }
}

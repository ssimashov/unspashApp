//
//  RealmService.swift
//  unspashApp
//
//  Created by Sergey Simashov on 04.09.2022.
//

import Foundation
import RealmSwift

class RealmService {
    
    static func saveData (_ data: DetailedPhotoResults) {
        do {
            let config = Realm.Configuration.defaultConfiguration
            
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(data)
            }
            print(realm.configuration.fileURL!)
        } catch {
            print(error)
        }
    }
    
    static func deleteData (_ data: DetailedPhotoResults) {
        
        guard let location = data.location else { return }
        guard let urls = data.urls else { return }
        guard let user = data.user else { return }
        
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(data)
                realm.delete(location)
                realm.delete(urls)
                realm.delete(user)
            }
            print("OBJECT DELETED", realm.configuration.fileURL!)
        } catch {
            print(error)
        }
    }
}


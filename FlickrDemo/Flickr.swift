//
//  Flickr.swift
//  FlickrDemo
//
//  Created by Nier on 2020/2/23.
//  Copyright © 2020 Nier. All rights reserved.
//

import Foundation

class Flickr {
    
    static let shared: Flickr = Flickr()
    
    var myFavorite: [String: [String: String]] = UserDefaults.standard.dictionary(forKey: "myFavorite") as? [String: [String: String]] ?? [:]
    
    func addMyFavorite(_ key: String, _ value: FlickrPhoto.Photo) {
        var data: [String: String] = [:]
        
        data["id"] = value.id
        data["owner"] = value.owner
        data["secret"] = value.secret
        data["server"] = value.server
        data["farm"] = String(value.farm)
        data["title"] = value.title
        data["ispublic"] = String(value.ispublic)
        data["isfriend"] = String(value.isfriend)
        data["isfamily"] = String(value.isfamily)
        
        myFavorite[key] = data
        UserDefaults.standard.set(myFavorite, forKey: "myFavorite")
        UserDefaults.standard.synchronize()
    }
    
    func removeMyFavorite(_ key: String) {
        myFavorite[key] = nil
        UserDefaults.standard.set(myFavorite, forKey: "myFavorite")
        UserDefaults.standard.synchronize()
    }
    
}

struct FlickrPhoto: Codable {
    
    var photos: FlickrResponse

    struct FlickrResponse: Codable {
        var page: Int
        var pages: Int
        var perpage: Int
        var total: String
        var photo: [Photo]
    }
    
    struct Photo: Codable {
        var id: String
        var owner: String
        var secret: String
        var server: String
        var farm: Int
        var title: String
        var ispublic: Int
        var isfriend: Int
        var isfamily: Int
    }
    
}

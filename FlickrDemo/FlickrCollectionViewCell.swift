//
//  FlickrCollectionViewCell.swift
//  FlickrDemo
//
//  Created by Nier on 2020/2/22.
//  Copyright © 2020 Nier. All rights reserved.
//

import UIKit

class FlickrCollectionViewCell: UICollectionViewCell {
    
    var flickrID: String!
    var flickrPhotoData: FlickrPhoto.Photo!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.borderWidth = 1
    }
    
    func getFlickrImage(_ photo: FlickrPhoto.Photo) {
        flickrID = String(photo.farm) + "-" + photo.server + "-" + photo.id + "-" + photo.secret
        flickrPhotoData = photo
        imageLabel.text = photo.title
        
        if Flickr.shared.myFavorite[flickrID] != nil {
            favoriteButton.isHidden = false
        } else {
            favoriteButton.isHidden = true
        }
        
        do {
            let url: URL = URL(string: "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")!
            let data: Data = try Data(contentsOf: url)
            
            imageView.image = UIImage(data: data)
        } catch {
            print(error)
        }
    }
    
    func getFlickrImage(_ key: String) {
        flickrID = key
        imageLabel.text = Flickr.shared.myFavorite[key]!["title"]!
        
        favoriteButton.isHidden = false
        
        do {
            let photo: [String] = key.components(separatedBy: "-")
            let url: URL = URL(string: "https://farm\(photo[0]).staticflickr.com/\(photo[1])/\(photo[2])_\(photo[3]).jpg")!
            let data: Data = try Data(contentsOf: url)
            
            imageView.image = UIImage(data: data)
        } catch {
            print(error)
        }
    }
    
    func addFavorite() {
        favoriteButton.isHidden = false
        Flickr.shared.addMyFavorite(flickrID, flickrPhotoData)
    }
    
    func removeFavorite() {
        favoriteButton.isHidden = true
        Flickr.shared.removeMyFavorite(flickrID)
    }
}

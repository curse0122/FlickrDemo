//
//  FlickrCollectionViewCell.swift
//  FlickrDemo
//
//  Created by Nier on 2020/2/22.
//  Copyright © 2020 Nier. All rights reserved.
//

import UIKit

class FlickrCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageLabel: UILabel!
    
    func getFlickrImage(_ photo: FlickrResponse.PhotoObject) {
        imageLabel.text = photo.title
        
        do {
            let url: URL = URL(string: "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")!
            let data: Data = try Data(contentsOf: url)
            
            imageView.image = UIImage(data: data)
        } catch {
            print(error)
        }
    }
}

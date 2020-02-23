//
//  FavoritePhotoVC.swift
//  FlickrDemo
//
//  Created by Nier on 2020/2/23.
//  Copyright © 2020 Nier. All rights reserved.
//

import UIKit

class FavoritePhotoVC: UIViewController {
    
    var favoriteImage: UIImage!
    var favoriteImageKey: String!

    @IBOutlet var favoritePhoto: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var ownerLabel: UILabel!
    @IBOutlet var secretLabel: UILabel!
    @IBOutlet var serverLabel: UILabel!
    @IBOutlet var farmLabel: UILabel!
    @IBOutlet var ispublicLabel: UILabel!
    @IBOutlet var isfriendLabel: UILabel!
    @IBOutlet var isfamilyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoritePhoto.image = favoriteImage
        titleLabel.text = Flickr.shared.myFavorite[favoriteImageKey]!["title"]
        idLabel.text = Flickr.shared.myFavorite[favoriteImageKey]!["id"]
        ownerLabel.text = Flickr.shared.myFavorite[favoriteImageKey]!["owner"]
        secretLabel.text = Flickr.shared.myFavorite[favoriteImageKey]!["secret"]
        serverLabel.text = Flickr.shared.myFavorite[favoriteImageKey]!["server"]
        farmLabel.text = Flickr.shared.myFavorite[favoriteImageKey]!["farm"]
        ispublicLabel.text = Flickr.shared.myFavorite[favoriteImageKey]!["ispublic"]
        isfriendLabel.text = Flickr.shared.myFavorite[favoriteImageKey]!["isfriend"]
        isfamilyLabel.text = Flickr.shared.myFavorite[favoriteImageKey]!["isfamily"]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func removeMyFavorite(_ sender: Any) {
        Flickr.shared.removeMyFavorite(favoriteImageKey)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

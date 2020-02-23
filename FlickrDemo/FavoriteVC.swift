//
//  FavoriteVC.swift
//  FlickrDemo
//
//  Created by Nier on 2020/2/23.
//  Copyright © 2020 Nier. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet var myFavoriteCollectView: UICollectionView!
    @IBOutlet var myFavoriteCollectViewLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myFavoriteCollectView.reloadSections([0])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let favoritePhotoVC: FavoritePhotoVC = segue.destination as! FavoritePhotoVC
        let flickrCollectionViewCell: FlickrCollectionViewCell = sender as! FlickrCollectionViewCell
        
        favoritePhotoVC.favoriteImage = flickrCollectionViewCell.imageView.image
        favoritePhotoVC.favoriteImageKey = flickrCollectionViewCell.flickrID
    }

}

extension FavoriteVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Flickr.shared.myFavorite.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flickrCell", for: indexPath) as! FlickrCollectionViewCell
        let key = Array(Flickr.shared.myFavorite.keys)[indexPath.row]
        
        cell.getFlickrImage(key)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lenght: CGFloat = (self.view.bounds.width - myFavoriteCollectViewLayout.sectionInset.left - 20) / 2

        return CGSize(width: lenght, height: lenght)
    }
    
}

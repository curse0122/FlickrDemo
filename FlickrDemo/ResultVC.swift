//
//  ResultVC.swift
//  FlickrDemo
//
//  Created by Nier on 2020/2/22.
//  Copyright © 2020 Nier. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    let flickrAPIKey: String = "2d01aba74db18a11527a108434aa7a9d"
    
    var condition: String!
    var countNumber: String!
    var collectionViewData: [FlickrPhoto.Photo] = []

    @IBOutlet var flickrCollectionView: UICollectionView!
    @IBOutlet var flickrCollectionViewLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getImageFromFlickr()
        // Do any additional setup after loading the view.
    }
    
    func getImageFromFlickr() {
        let url: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=" + flickrAPIKey + "&text=" + condition + "&per_page=" + countNumber + "&format=json&nojsoncallback=1"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            let response: HTTPURLResponse = response as! HTTPURLResponse
        
            if response.statusCode == 200 {
                do {
                    self.collectionViewData = try JSONDecoder().decode(FlickrPhoto.self, from: data!).photos.photo
                    DispatchQueue.main.async {
                        self.flickrCollectionView.reloadSections([0])
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
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

extension ResultVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flickrCell", for: indexPath) as! FlickrCollectionViewCell
        
        cell.getFlickrImage(collectionViewData[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lenght: CGFloat = (self.view.bounds.width - flickrCollectionViewLayout.sectionInset.left - 20) / 2
        
        return CGSize(width: lenght, height: lenght)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FlickrCollectionViewCell
        
        if Flickr.shared.myFavorite[cell.flickrID] != nil {
            cell.removeFavorite()
        } else {
            cell.addFavorite()
        }
    }
    
}

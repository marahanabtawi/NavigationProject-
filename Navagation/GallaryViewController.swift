//
//  GallaryViewController.swift
//  Navagation
//
//  Created by marah anabtawi on 22/08/2021.
//

import UIKit

class GallaryViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate{

  @IBOutlet weak var collectionView: UICollectionView!
  
  var imageArray = [Gallary]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    passPhotos()
  }
  
  func passPhotos(){
    imageArray = []
    let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      
      if error == nil{
        
        do{
          let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
          let firstFive = fetchData.prefix(6)
          for eachFetch in firstFive{
            let eachPhoto = eachFetch as! [String : Any]
            let url = eachPhoto["url"] as! String
            let thumbnailUrl = eachPhoto["thumbnailUrl"] as! String
          
            self.imageArray.append(Gallary(url: url, thumbnailUrl: thumbnailUrl))
          }
          DispatchQueue.main.async {
            self.collectionView.reloadData()
          }
        } catch {
           print("error")
         }
        
      }
      
    }.resume()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPhoto", for: indexPath) as! CollectionViewCell
    
    let imageLink = imageArray[indexPath.row].thumbnailUrl
    cell.photo.downloaded(from: imageLink)
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? ShowImageViewController{
      let cell = sender as! UICollectionViewCell
      let indexPath = collectionView.indexPath(for: cell)
      let selectedData = imageArray[(indexPath?.row)!]
      destination.image = selectedData
    }
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/2)
 }
  
}

class Gallary: Decodable{
  
  let url: String
  let thumbnailUrl: String
  
  init(url: String,thumbnailUrl: String) {
    self.url = url
    self.thumbnailUrl = thumbnailUrl
  }
}

extension UIImageView {
  func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
      else { return }
      DispatchQueue.main.async() { [weak self] in
        self?.image = image
      }
    }.resume()
  }
  
  func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
    guard let url = URL(string: link) else { return }
    downloaded(from: url, contentMode: mode)
  }
}

//
//  ShowImageViewController.swift
//  Navagation
//
//  Created by marah anabtawi on 22/08/2021.
//

import UIKit

class ShowImageViewController: UIViewController {
    
  @IBOutlet weak var fullPhoto: UIImageView!
  
  var image: Gallary?

    override func viewDidLoad() {
      super.viewDidLoad()
      fullPhoto.downloaded(from: image!.url)
    }

}

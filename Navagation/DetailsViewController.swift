//
//  DetailsViewController.swift
//  Navagation
//
//  Created by marah anabtawi on 20/08/2021.
//

import UIKit

class DetailsViewController: UIViewController, UIGestureRecognizerDelegate {
  
  var userDetails: User?
  
  @IBOutlet weak var userNameLable: UILabel!
  
  @IBOutlet weak var emailLable: UILabel!
  
  @IBOutlet weak var fullNameLable: UILabel!
  
  @IBOutlet weak var phoneNumberLable: UILabel!
  
  @IBOutlet weak var websiteLable: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userNameLable.text = userDetails?.userName
    emailLable.text = userDetails?.email
    fullNameLable.text = userDetails?.fullName
    phoneNumberLable.text = userDetails?.phoneNumber
    websiteLable.text = userDetails?.website
    phoneNumberLable.isUserInteractionEnabled = true
    
    let tap = UITapGestureRecognizer.init(target: self, action: #selector(DetailsViewController.clickLable))
    phoneNumberLable.isUserInteractionEnabled = true
    phoneNumberLable.addGestureRecognizer(tap)
    
    
    let tapEmail = UITapGestureRecognizer.init(target: self, action: #selector(DetailsViewController.openEmail))
    emailLable.isUserInteractionEnabled = true
    emailLable.addGestureRecognizer(tapEmail)
    
  }
  
  @objc func clickLable(){
    print(phoneNumberLable.text!)
    if let phoneUrl = URL(string: "tel://\(phoneNumberLable.text!)"){
      if UIApplication.shared.canOpenURL(phoneUrl) {
        UIApplication.shared.open(phoneUrl)
      } 
    }
  }
  
  @objc func openEmail(){
    print(emailLable.text!)
    if let emailUrl = URL(string: "mailto://\(emailLable.text!)") {
      if UIApplication.shared.canOpenURL(emailUrl){
        if #available(iOS 10.0, *) {
        UIApplication.shared.open(emailUrl)
        }else{
          UIApplication.shared.openURL(emailUrl)
        }
      }
    }
  }
  
  
}

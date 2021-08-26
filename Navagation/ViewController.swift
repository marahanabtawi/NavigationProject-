//
//  ViewController.swift
//  Navagation
//
//  Created by marah anabtawi on 18/08/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
   
  var fetchUser = [User]()
  var filterData = [User]()
  
  @IBOutlet var userTableView: UITableView!
  
  var searchController: UISearchController = UISearchController(searchResultsController: nil)
  
  func filterContentForSearchText(searchText: String){
    filterData = fetchUser.filter({ (user: User) -> Bool in
      return user.userName.lowercased().contains(searchText.lowercased())
    })
    userTableView.reloadData()
  }
  
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isFiltering() -> Bool{
    return searchController.isActive && !isSearchBarEmpty
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    parseData()
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
    
  public func numberOfSections(in tableView: UITableView) -> Int
  {
      return 1
  }
    
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    if isFiltering(){
      return filterData.count
    }
    return fetchUser.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
    let cell = userTableView.dequeueReusableCell(withIdentifier: "cell")
    let currentUser: User
    if isFiltering(){
      currentUser = filterData[indexPath.row]
    }else{
      currentUser = fetchUser[indexPath.row]
    }
    cell?.textLabel?.text = currentUser.userName
    cell?.detailTextLabel?.text = currentUser.email

    return cell!
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
     // Delete the row from the data source
     fetchUser.remove(at: indexPath.row)
     tableView.deleteRows(at: [indexPath], with: .fade)
   }
 }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDetails", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? DetailsViewController{
      destination.userDetails = fetchUser[(userTableView.indexPathForSelectedRow?.row)!]
    }
  }
    
  func parseData(){
    
    fetchUser = []
    
    let url = "https://jsonplaceholder.typicode.com/users"
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "GET"
    
    let configration =  URLSessionConfiguration.default
    let session = URLSession(configuration: configration, delegate: nil, delegateQueue: OperationQueue.main)
    
    let task = session.dataTask(with: request) { (data, response, error) in
      if error != nil{
        print("ERROR")
      }else{
        do{
          let fetchData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
          for eachFetchUser in fetchData{
            let eachUser = eachFetchUser as! [String : Any]
            let username = eachUser["username"] as! String
            let email = eachUser["email"] as! String
            let fullName =  eachUser["name"] as! String
            let phoneNumber = eachUser["phone"] as! String
            let website = eachUser["website"] as! String
            
            self.fetchUser.append(User(userName: username, email: email,fullName: fullName, phoneNumber: phoneNumber, website: website))
            
          }
          self.userTableView.reloadData()
        }
        catch {
          print("Error")
        }
      }
    }
    task.resume()
  }
  
}

class User{
  
  let userName: String
  let email: String
  let fullName: String
  let phoneNumber: String
  let website: String
  
  init(userName: String,email: String,fullName: String,phoneNumber: String,website: String){
    self.userName = userName
    self.email = email
    self.fullName = fullName
    self.phoneNumber = phoneNumber
    self.website = website
    
  }
}

extension ViewController: UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchText: searchBar.text!)
    
  }
}

extension ViewController: UISearchResultsUpdating{
  
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchText: searchBar.text!)
  }
}




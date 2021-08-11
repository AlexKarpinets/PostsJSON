//
//  PostsTableViewController.swift
//  PostsJSON
//
//  Created by Karpinets Alexander on 08.08.2021.
//

import UIKit
import Alamofire

class PostsTableViewController: UITableViewController {
    
    // MARK: - Private properties
    private var posts: [Post] = []
    private var filteredPosts: [Post] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.rowHeight = 80
        alamofireFetchPost()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPosts.count
        }
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostCell
        var post: Post
        
        if isFiltering {
            post = filteredPosts[indexPath.row]
        } else {
            post = posts[indexPath.row]
        }
        cell.configur(with: post)
        
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let post: Post
        if isFiltering {
            post = filteredPosts[indexPath.row]
        } else {
            post = posts[indexPath.row]
        }
        detailVC.post = post
    }
    
    // MARK: - IBActions
    @IBAction func exitButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func creditsButton(_ sender: UIBarButtonItem) {
        creditsTapped()
    }
    
    // MARK: - Private func
    private func alamofireFetchPost() {
        AlamofireNetwork.shared.sendRequest { posts in
            DispatchQueue.main.async {
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    
    private func creditsTapped() {
        DispatchQueue.main.async {
            let creditsAlert = UIAlertController(title: "Данные поступают из", message: "https://jsonplaceholder.typicode.com/posts", preferredStyle: .alert)
            creditsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(creditsAlert, animated: true)
        }
    }
}

// MARK: - Extensions
extension PostsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filteredContentForSearchText(_ searchText: String) {
        filteredPosts = posts.filter({ (post: Post) -> Bool in
            return
                post.title.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

//// MARK: - Networking (without NetworkManager)
//extension PostsTableViewController {
//    private func fetchPost() {
//        guard let url = URL(
//                string: "https://jsonplaceholder.typicode.com/posts") else { return }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                self.showError()
//                return
//            }
//
//            do {
//                self.posts = try JSONDecoder().decode([Post].self, from: data)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            } catch let error {
//                print(error)
//            }
//        }.resume()
//    }
//}

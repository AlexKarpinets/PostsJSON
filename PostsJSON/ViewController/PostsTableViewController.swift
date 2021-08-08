//
//  PostsTableViewController.swift
//  PostsJSON
//
//  Created by Karpinets Alexander on 08.08.2021.
//

import UIKit

class PostsTableViewController: UITableViewController {
    
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        tableView.rowHeight = 80
        fetchPost()
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configur(with: post)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let post = posts[indexPath.row]
        detailVC.post = post
    }
    
    @IBAction func exitButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: - Private func
    private func showError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ошибка загрузки данных",
                                          message: "Возникла проблема с загрузкой; пожалуйста проверьте соединение и повторите попытку позже.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - Networking
extension PostsTableViewController {
    private func fetchPost() {
        guard let url = URL(
                string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                self.showError()
                return
            }
            
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

//
//  NetworkManager.swift
//  PostsJSON
//
//  Created by Karpinets Alexander on 10.08.2021.
//
import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchPost(_ complition: @escaping ([Post]) -> Void) {
        guard let url = URL(
                string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let post = try JSONDecoder().decode([Post].self, from: data)
                
                DispatchQueue.main.async {
                    complition(post)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

class AlamofireNetwork {
    
    static let shared = AlamofireNetwork()
    
    private init() {}
    
    func sendRequest(_ complition: @escaping ([Post]) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        AF.request(url, method: .get)
            .validate()
            .responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let posts = Post.getPosts(from: value)
                complition(posts)
            case .failure(let error):
                print(error)
            }
        }
    }
}

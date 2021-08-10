//
//  NetworkManager.swift
//  PostsJSON
//
//  Created by Karpinets Alexander on 10.08.2021.
//
import UIKit

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

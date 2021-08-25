//
//  DataManager.swift
//  PostsJSON
//
//  Created by Karpinets Alexander on 25.08.2021.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(_ completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "done") {
            
            UserDefaults.standard.set(true, forKey: "done")
            
            let testPost = PostAdd()
            testPost.title = "Temp"
            testPost.body = "Hello!"
            
            DispatchQueue.main.async {
                StorageManager.shared.save(postAdd: testPost)
                completion()
            }
        }
    }
}

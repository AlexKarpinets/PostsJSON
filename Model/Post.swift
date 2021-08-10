//
//  Post.swift
//  PostsJSON
//
//  Created by Karpinets Alexander on 08.08.2021.
//

struct Post: Codable {
    var id: Int
    var title: String
    var body: String
    
    init(postData: [String: Any]) {
        id = postData["id"] as? Int ?? 0
        title = postData["title"] as? String ?? ""
        body = postData["body"] as? String ?? ""
    }
    
    static func getPosts(from value: Any) -> [Post] {
        guard let postsData = value as? [[String: Any]] else { return [] }
        return postsData.compactMap { Post(postData: $0)}
    }
}

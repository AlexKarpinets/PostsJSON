//
//  PostRealm.swift
//  PostsJSON
//
//  Created by Karpinets Alexander on 25.08.2021.
//

import RealmSwift

class PostAdd: Object {
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    @objc dynamic var isComplete = false
    let postsList = List<PostAdd>()
}


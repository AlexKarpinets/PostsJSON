//
//  StorageManager.swift
//  PostsJSON
//
//  Created by Karpinets Alexander on 25.08.2021.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func delete(postAdd: PostAdd) {
        write {
            realm.delete(postAdd)
        }
    }
    
    func edit(postAdd: PostAdd, title: String, body: String) {
        write {
            postAdd.title = title
            postAdd.body = body
        }
    }
    
    func done(postAdd: PostAdd) {
        write {
            postAdd.isComplete.toggle()
        }
    }
    
    func save(postAdd: PostAdd) {
        write {
            postAdd.postsList.append(postAdd)
        }
    }
    
    private func write(_ comletion: () -> Void) {
        do {
            try realm.write {
               comletion()
            }
        } catch let error {
            print(error)
        }
    }
}


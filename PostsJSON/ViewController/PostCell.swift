//
//  PostCell.swift
//  PostsJSON
//
//  Created by Karpinets Alexander on 08.08.2021.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func configur(with post: Post) {
        idLabel.text = "ID: \(String(post.id))"
        titleLabel.text = "Title: \(post.title)"
        bodyLabel.text = "Body: \(post.body)"
    }
}



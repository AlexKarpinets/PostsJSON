//
//  DetailViewController.swift
//  PostsJSON
//
//  Created by Karpinets Alexander on 08.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var iDLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var post: Post!
    
    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }
    
    private func setup() {
        DispatchQueue.main.async {
            self.iDLabel.text = "ID: \(String(self.post.id))"
            self.titleLabel.text = "Title: \(self.post.title)"
            self.bodyLabel.text = "Body: \(self.post.body)"
        }
    }
}


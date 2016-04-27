//
//  PostCell.swift
//  neomadgic-showcase
//
//  Created by Vu Dang on 4/22/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell
{
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var screenImg: UIImageView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var post: Post!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
    
    override func drawRect(rect: CGRect)
    {
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg.clipsToBounds = true
        
        screenImg.clipsToBounds = true
        
    }
    
    func configureCell(post: Post)
    {
        self.post = post
        
        self.likesLbl.text = "\(post.likes)"
        self.descriptionText.text = post.postDescription
    }

}

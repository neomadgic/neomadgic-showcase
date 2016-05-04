//
//  PostCell.swift
//  neomadgic-showcase
//
//  Created by Vu Dang on 4/22/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PostCell: UITableViewCell
{
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var screenImg: UIImageView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likeImage: UIImageView!
    
    var post: Post!
    var request: Request?
    var likeRef: Firebase!

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
    
    func configureCell(post: Post, img: UIImage?)
    {
        self.post = post
        likeRef = DataService.ds.REF_USER_CURRENT.childByAppendingPath("likes").childByAppendingPath(post.postKey)
        self.likesLbl.text = "\(post.likes)"
        self.descriptionText.text = post.postDescription
        
        if post.imageUrl != nil
            {
                if img != nil
                    {
                        self.screenImg.image = img
                    }
                else
                    {
                        request = Alamofire.request(.GET, post.imageUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                            
                                if err == nil
                                    {
                                        //normally use if let, but too lazy this time around
                                        let img = UIImage(data: data!)!
                                        self.screenImg.image = img
                                        FeedVC.imgCache.setObject(img, forKey: self.post.imageUrl!)
                                    }
                            
                            })
                    }
            }
        else
            {
                self.screenImg.hidden = true
            }
        
        likeRef.observeSingleEventOfType(.Value, withBlock:
            { snapshot in
                
                //If Data does not exist, then data is NSNull
                //If there is no data in snapshot.value, then you will get an NSNull.
                
                if let didNotExist = snapshot.value as? NSNull
                    {
                        self.likeImage.image = UIImage(named: "hearts-empty")
                    }
                else
                    {
                        self.likeImage.image = UIImage(named: "hearts-full")
                    }
            })
        
    }

}

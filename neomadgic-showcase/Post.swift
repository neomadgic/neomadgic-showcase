//
//  Post.swift
//  neomadgic-showcase
//
//  Created by Vu Dang on 4/26/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import Foundation
import Firebase

class Post
{
    private var _postDescription: String!
    private var _imageUrl: String?
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    private var _postRef: Firebase!
    
    var postDescription: String
        {
            return _postDescription
        }
    
    var imageUrl: String?
        {
            return _imageUrl
        }
    
    var likes: Int
        {
            return _likes
        }
    
    var username: String
        {
            return _username
        }
    
    var postKey: String
        {
            return _postKey
        }
    
    init(postDescription: String, imageUrl: String?, username: String)
        {
            self._postDescription = postDescription
            self._imageUrl = imageUrl
            self._username = username
        }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>)
        {
            self._postKey = postKey
            
            if let likes = dictionary["likes"] as? Int
                {
                    self._likes = likes
                }
            
            if let imgUrl = dictionary["imageUrl"] as? String
                {
                    self._imageUrl = imgUrl
                }
            
            if let desc = dictionary["description"] as? String
                {
                    self._postDescription = desc
                }
            
            self._postRef = DataService.ds.REF_POSTS.childByAppendingPath(self._postKey)
            
        }
    
    func adjustLiks(addLike: Bool)
    {
        if addLike
            {
                _likes = _likes + 1
            }
        else
            {
                _likes = _likes - 1
            }
        
        _postRef.childByAppendingPath("likes").setValue(_likes)
    }
    
    
    
}
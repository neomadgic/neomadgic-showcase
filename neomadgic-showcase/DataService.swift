//
//  DataService.swift
//  neomadgic-showcase
//
//  Created by Vu Dang on 4/18/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://neomadgic-showcase.firebaseio.com"

class DataService
{
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    
    var REF_BASE: Firebase
    {
        return _REF_BASE
    }
    
    var REF_USERS: Firebase
    {
        return _REF_USERS
    }
    
    var REF_POSTS: Firebase
    {
        return _REF_POSTS
    }
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>)
    {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
}
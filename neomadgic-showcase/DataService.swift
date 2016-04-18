//
//  DataService.swift
//  neomadgic-showcase
//
//  Created by Vu Dang on 4/18/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import Foundation
import Firebase

class DataService
{
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "https://neomadgic-showcase.firebaseio.com/")
    
    var REF_BASE: Firebase
    {
        return _REF_BASE
    }
    
}
//
//  FeedVC.swift
//  neomadgic-showcase
//
//  Created by Vu Dang on 4/22/16.
//  Copyright © 2016 Vu Dang. All rights reserved.
//

import UIKit

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        return tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
    }
    
}

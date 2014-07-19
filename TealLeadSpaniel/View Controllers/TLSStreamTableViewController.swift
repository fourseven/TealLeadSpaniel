//
//  TLSStreamTableViewController.swift
//  TealLeadSpaniel
//
//  Created by Matt Nydam on 19/07/14.
//  Copyright (c) 2014 Matt Nydam. All rights reserved.
//

import UIKit

class TLSStreamTableViewController: UITableViewController {

    let allPosts:NSMutableArray? = NSMutableArray()
    
    convenience init() {
        self.init(style: .Plain)
        self.title = "Stream"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var post:TLSPost? = TLSPost(author: "Matt", content: "HELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP USHELP US")
        allPosts?.addObject(post)
    }


    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return allPosts!.count
    }

    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
    {

        var post:TLSPost = allPosts?.objectAtIndex(indexPath.row) as TLSPost
        return TLSStreamTableViewCell.heightForContent(post)
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell:TLSStreamTableViewCell? = TLSStreamTableViewCell()
        
        if(!cell) {
            cell = TLSStreamTableViewCell(style:.Default, reuseIdentifier: "cellidentifier")
        }
        
        var post:TLSPost = allPosts?.objectAtIndex(indexPath.row) as TLSPost
        cell?.configureWithPost(post)
        
        return cell
    }


}

//
//  TLSStreamTableViewController.swift
//  TealLeadSpaniel
//
//  Created by Matt Nydam on 19/07/14.
//  Copyright (c) 2014 Matt Nydam. All rights reserved.
//

import UIKit

class TLSStreamTableViewController: UITableViewController {

    
    convenience init() {
        self.init(style: .Plain)
        self.title = "Stream"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return 1
    }

    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
    {
        return 60.0
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell:TLSStreamTableViewCell? = TLSStreamTableViewCell()
        
        if(!cell) {
            cell = TLSStreamTableViewCell(style:.Default, reuseIdentifier: "cellidentifier")
        }
        
        let post:TLSPost? = TLSPost(author: "Matt", content: "HELP US")
        cell?.configureWithPost(post!)
        
        return cell
    }


}

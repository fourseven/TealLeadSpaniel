//
//  TLSStreamTableViewController.swift
//  TealLeadSpaniel
//
//  Created by Matt Nydam on 19/07/14.
//  Copyright (c) 2014 Matt Nydam. All rights reserved.
//

import UIKit

class TLSStreamTableViewController: UITableViewController, TLSCreatePostViewDelegate {
    
    var keyboardBottom:CGFloat = 0
    
    @lazy var createPostView : TLSCreatePostView =
    {
        var postView : TLSCreatePostView = TLSCreatePostView(frame: CGRectZero)
        postView.delegate = self
        return postView
    }()
    
    let allPosts:NSMutableArray? = NSMutableArray()

    convenience init() {
        self.init(style: .Plain)
        self.title = "Stream"
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        keyboardBottom = self.view.bounds.height
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasHidden:", name: UIKeyboardDidHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("notificationWasReceived:"), name: "postReceived", object: nil)
        
        self.navigationController.view.addSubview(createPostView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var createPostFrame:CGRect = CGRectZero
        createPostFrame.size.height = 200.0
        createPostFrame.size.width = self.view.bounds.width
        createPostFrame.origin.y = keyboardBottom - createPostFrame.height;
        createPostView.frame = createPostFrame;
    }

    // #pragma mark - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
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

    // Create Post View Delegate
    func createPostViewWasTouched() {

    }
    
    func doneKeyWasPressed(content: NSString) {
        var post:TLSPost = TLSPost(author: "Matt", content: content)
        allPosts?.addObject(post)
        var delegate = UIApplication.sharedApplication().delegate as AppDelegate
        delegate.session?.send(post)
        tableView.reloadData()
    }
    
    func notificationWasReceived(notification: NSNotification) {
        var post = notification.object as TLSPost
        allPosts?.addObject(post)
        tableView.reloadData()
    }
    
    func keyboardWasShown(notification:NSNotification)
    {
        var keyboardSize:CGSize = (notification.userInfo[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue().size
        keyboardBottom = keyboardSize.height
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            
            self.createPostView.frame.origin.y = keyboardSize.height - self.createPostView.frame.height
            
            }), completion:nil)

    }
    
    func keyboardWasHidden(notification:NSNotification)
    {
        keyboardBottom = self.view.bounds.height
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
            
            self.createPostView.frame.origin.y = self.view.bounds.height - self.createPostView.frame.height
            
            }), completion: nil)
    }
    
    
}

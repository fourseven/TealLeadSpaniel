//
//  ViewController.swift
//  TealLeadSpaniel
//
//  Created by Matt Nydam on 19/07/14.
//  Copyright (c) 2014 Matt Nydam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var session :SessionService?
    
    @IBOutlet var incommingLog: UILabel
    
    @IBOutlet var justLog: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doStuff(sender: AnyObject) {
        session?.start()
    }

    @IBAction func sendHello(sender: AnyObject) {
        if let realSession = session{
            realSession.send("Hello")
        }
        
    }
}


//
//  TLSCreatePostView.swift
//  TealLeadSpaniel
//
//  Created by Matt Nydam on 19/07/14.
//  Copyright (c) 2014 Matt Nydam. All rights reserved.
//

import UIKit

protocol TLSCreatePostViewDelegate {
    func createPostViewWasTouched()
    func doneKeyWasPressed(content:NSString)
}

class TLSCreatePostView: UIView, UITextFieldDelegate {

    var delegate: TLSCreatePostViewDelegate?
    
    @lazy var invisibleButton : UIButton =
    {
        var temporaryButton : UIButton = UIButton()
        temporaryButton.addTarget(self, action: "invisibleButtonWasPresed", forControlEvents: .TouchUpInside)
        return temporaryButton
    }()
    
    @lazy var contentTextView : UITextField =
    {
        var tempTextView : UITextField = UITextField()
        tempTextView.delegate = self
        return tempTextView
    }()
    
    var isEnteringText:Bool = false;
    
    init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(invisibleButton)
        self.backgroundColor = UIColor.clearColor()
        invisibleButton.backgroundColor = UIColor.orangeColor()
        contentTextView.backgroundColor = UIColor.purpleColor()
    }
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        invisibleButton.frame = self.bounds
        contentTextView.frame = self.bounds
    }
    
    func invisibleButtonWasPresed() {
        
        isEnteringText = !isEnteringText
        self.addSubview(contentTextView)
        invisibleButton.removeFromSuperview()
        contentTextView.becomeFirstResponder()
        delegate?.createPostViewWasTouched()
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        isEnteringText = !isEnteringText
        contentTextView.resignFirstResponder()
        contentTextView.removeFromSuperview()
        self.addSubview(invisibleButton)
        
        if (contentTextView.text != "") {
            delegate?.doneKeyWasPressed(contentTextView.text)
        }
        
        contentTextView.text = ""
        
        return true
    }

}

//
//  TLSStreamTableViewCell.swift
//  TealLeadSpaniel
//
//  Created by Matt Nydam on 19/07/14.
//  Copyright (c) 2014 Matt Nydam. All rights reserved.
//

import UIKit

class TLSStreamTableViewCell: UITableViewCell {

    let kPadding:CGFloat = 10.0
    let kLineWidth:CGFloat = 2.0
    let kLineInset:CGFloat = 10.0
    
    @lazy var authorLabel : UILabel =
    {
        var temporaryLabel : UILabel = UILabel(frame: CGRectZero)
        temporaryLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        temporaryLabel.textColor = UIColor.redColor()
        return temporaryLabel
    }()
    
    @lazy var contentLabel : UILabel =
    {
        var temporaryLabel : UILabel = UILabel(frame: CGRectZero)
        temporaryLabel.numberOfLines = 0

        return temporaryLabel
    }()
    
    @lazy var colorLine : UIView =
    {
        var colorLine : UIView = UIView()
        colorLine.backgroundColor = UIColor.redColor()
        return colorLine
    }()
    
    func configureWithPost(post:TLSPost) {
        self.authorLabel.text = post.author
        self.contentLabel.text = post.content
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(colorLine)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        authorLabel.frame = CGRectMake(kPadding, 10.0, self.bounds.width, 20.0)
        
        colorLine.frame = CGRectMake(kPadding, authorLabel.frame.height + kLineInset, kLineWidth, self.bounds.height  - (authorLabel.frame.height + kLineInset) - kPadding - kLineInset)
        
        contentLabel.frame = CGRectMake(colorLine.frame.width + kPadding * 2, colorLine.frame.origin.y, self.bounds.width, 20.0)
        contentLabel.sizeToFit()
        
    }

    class func heightForContent(post:TLSPost) -> CGFloat
    {
        let postCell:TLSStreamTableViewCell = TLSStreamTableViewCell()
        postCell.configureWithPost(post)
        postCell.layoutSubviews()
        return postCell.contentLabel.frame.origin.y + postCell.contentLabel.frame.height + 20.0
        
    }
}

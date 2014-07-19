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
    
    @lazy var authorLabel : UILabel =
    {
        var temporaryLabel : UILabel = UILabel()
        
        return temporaryLabel
    }()
    
    @lazy var contentLabel : UILabel =
    {
        var temporaryLabel : UILabel = UILabel()
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
        authorLabel.frame = CGRectMake(kPadding, kPadding, self.bounds.width, 20.0)
        contentLabel.frame = CGRectMake(kPadding, kPadding, self.bounds.width, 20.0)
        colorLine.frame = CGRectMake(kPadding, kPadding, kLineWidth, 20.0)
    }

}

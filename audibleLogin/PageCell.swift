//
//  PageCell.swift
//  audibleLogin
//
//  Created by Alex Lombry on 25/09/2016.
//  Copyright © 2016 Alex Lombry. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .yellow
        iv.image = UIImage(named: "page1")
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        
        tv.text = "Sample for now"
        tv.isEditable = false
        
        return tv
    }()
    
    func setupViews() {
    
        addSubview(imageView)
        addSubview(textView)
        
        imageView.anchorToTop(
            top: topAnchor,
            left: leftAnchor,
            bottom: textView.topAnchor,
            right: rightAnchor
        )
        
        textView.anchorToTop(
            top: nil,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

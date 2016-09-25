//
//  PageCell.swift
//  audibleLogin
//
//  Created by Alex Lombry on 25/09/2016.
//  Copyright © 2016 Alex Lombry. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let page = page else {
                return
            }
            
            imageView.image = UIImage(named: page.imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            let attributedText = NSMutableAttributedString(
                string: page.title,
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium),
                    NSForegroundColorAttributeName: color
                ])
            
            textView.attributedText = attributedText
            //textView.text = page.title + "\n\n" + page.message
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    // Create view layout
    let imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .yellow
        iv.image = UIImage(named: "page1")
        iv.clipsToBounds = true
        
        return iv
    }()
    
    // Create text view layout
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

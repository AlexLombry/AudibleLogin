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
            
            // handle image name if device is landscape or not
            var imageName = page.imageName
            if UIDevice.current.orientation.isLandscape {
                imageName = "\(imageName)_landscape"
            }
            
            imageView.image = UIImage(named: imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            // set title and message text and format them
            let attributedText = NSMutableAttributedString(
                string: page.title,
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium),
                    NSForegroundColorAttributeName: color
                ]
            )
            
            attributedText.append(
                NSAttributedString(string: "\n\n\(page.message)",
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium),
                    NSForegroundColorAttributeName: color
                ])
            )
            
            // place the current paragraph to the center
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let length = attributedText.string.characters.count
            attributedText.addAttribute(
                NSParagraphStyleAttributeName,
                value: paragraphStyle,
                range: NSRange(location: 0, length: length)
            )
            
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
        
        // Padding
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        
        
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(white: 0.0, alpha: 1)
        
        return view
    }()
    
    func setupViews() {
    
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
        
        imageView.anchorToTop(
            topAnchor,
            left: leftAnchor,
            bottom: textView.topAnchor,
            right: rightAnchor
        )
        
        textView.anchorWithConstantsToTop(
            nil,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            topConstant: 0,
            leftConstant: 16,
            bottomConstant: 0,
            rightConstant: 16
        )
        
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        lineSeparatorView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

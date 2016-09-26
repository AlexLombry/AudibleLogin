//
//  ViewController.swift
//  audibleLogin
//
//  Created by Alex Lombry on 25/09/2016.
//  Copyright © 2016 Alex Lombry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellFirst = "first"

    let pages: [Page] = {
        let firstPage = Page(
            title: "Share a great listen",
            message: "It's free to send your books to the people in your life. Every recipient's first book is on us.",
            imageName: "page1"
        )
        
        let secondPage = Page(
            title: "Send from your library",
            message: "Tap the more menu next to any book. Choose \"Send this Book\".",
            imageName: "page2"
        )
        
        
        let thirdPage = Page(
            title: "Send from the player",
            message: "Tap the More menu in the upper corner. Choose \"Send this Book\".",
            imageName: "page3"
        )
        
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    // Creation d'une collection view en code et non en storyboard
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        coll.backgroundColor = .white
        coll.dataSource = self
        coll.delegate = self
        coll.isPagingEnabled = true
        
        return coll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        // place the collection view
        collectionView.anchorToTop(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellFirst)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellFirst, for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        
        cell.page = page
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
}


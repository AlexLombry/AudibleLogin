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
    let loginCellId = "loginCellId"
    
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
    
    // lazy var to use self. (impossible with a let in this case)
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        
        pc.numberOfPages = self.pages.count + 1
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = orangeButtonColor
        
        return pc
    }()
    
    let skipButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(orangeButtonColor, for: .normal)
        
        return btn
    }()
    
    let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(orangeButtonColor, for: .normal)
        
        return btn
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
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        // do not use the return from anchor method.
        _ = pageControl.anchor(
            nil,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 40
        )
        
        _ = skipButton.anchor(
            view.topAnchor,
            left: view.leftAnchor,
            bottom: nil,
            right: nil,
            topConstant: 16,
            leftConstant: 5,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 60,
            heightConstant: 50
        )
        
        _ = nextButton.anchor(
            view.topAnchor,
            left: nil,
            bottom: nil,
            right: view.rightAnchor,
            topConstant: 16,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 5,
            widthConstant: 60,
            heightConstant: 50
        )

        // place the collection view
        collectionView.anchorToTop(
            view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        registerCells()
    }

    // use this to know with pagination where we are
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = targetContentOffset.pointee.x / view.frame.width
        
        pageControl.currentPage = Int(pageNumber)
    }
    
    
    fileprivate func registerCells() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellFirst)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Avoid crashes for pages.count + 1
        // needed for login page
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath)
            
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellFirst, for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        
        cell.page = page
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
}


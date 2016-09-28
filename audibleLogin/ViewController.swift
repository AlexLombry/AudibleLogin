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
    
    // each page
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
    
    // lazy var to use self. (impossible with a let in this case)  kk
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        
        pc.numberOfPages = self.pages.count + 1
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = orangeButtonColor
        
        return pc
    }()
    
    lazy var skipButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(orangeButtonColor, for: .normal)
        btn.addTarget(self, action: #selector(skip), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var nextButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(orangeButtonColor, for: .normal)
        btn.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
        return btn
    }()
    
    // go to the next page
    func nextPage() {
        // we are on the last page
        if pageControl.currentPage == pages.count {
            return
        }
        
        // second last page
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstraintsOfScreen()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: nil)
            
        }
        
        // get the current indexpath
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        pageControl.currentPage += 1
    }
    
    // skip all page
    func skip() {
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    
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
    
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifications()
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        // do not use the return from anchor method.
        pageControlBottomAnchor = pageControl.anchor(
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
        )[1]
        
        skipButtonTopAnchor = skipButton.anchor(
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
        ).first
        
        nextButtonTopAnchor = nextButton.anchor(
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
        ).first

        // place the collection view
        collectionView.anchorToTop(
            view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
        
        // register PageCell and UICollectionView for login page
        registerCells()
    }

    // looking for notification from keyboard, to up the login button
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            
            }, completion: nil)
    }
    
    func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
            }, completion: nil)
    }
    
    // use this to know with pagination where we are
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        
        pageControl.currentPage = pageNumber
        
        // on the last page
        if pageNumber == pages.count {
            moveControlConstraintsOfScreen()
        } else {
            // back to other page (not login one)
            restoreControlConstraintsOfScreen()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    /// MARK: Move all control constraint
    fileprivate func moveControlConstraintsOfScreen() {
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant = -40
        nextButtonTopAnchor?.constant = -40
    }
    
    fileprivate func restoreControlConstraintsOfScreen() {
        pageControlBottomAnchor?.constant = 0
        skipButtonTopAnchor?.constant = 16
        nextButtonTopAnchor?.constant = 16
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    fileprivate func registerCells() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellFirst)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
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
    
    // To handle transition (rotation of the device)
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print(UIDevice.current.orientation)
        
        //let orientation = UIDevice.current.orientation
        
        collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        // scroll indexPath after rotation is launched
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            // refresh the cell
            self.collectionView.reloadData()
        }
    }
    
    
}


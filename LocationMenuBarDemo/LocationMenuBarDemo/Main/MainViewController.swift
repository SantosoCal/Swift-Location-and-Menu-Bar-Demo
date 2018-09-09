//
//  MainViewController.swift
//  Location Menu Bar Demo
//
//  Created by Andrew Santoso on 8/28/18.
//  Copyright © 2018 Andrew Santoso. All rights reserved.
//

import UIKit

// NOTES:
// - menuBar inspired by Brian Voong
// - custom map inspired by Ray Wenderlich
// - XCODE Simulator does not get laptop's actual location (defaults to Cupertino). This demo does get the user's location on iPhone devices, however.

class MainViewController: UIViewController {

    lazy var menuBar: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: menuBarHeight)
        let menuBar = UICollectionView(frame: frame, collectionViewLayout: layout)
        menuBar.register(MenuBarCell.self, forCellWithReuseIdentifier: "menuBarCell")
        menuBar.delegate = self
        menuBar.dataSource = self
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        menuBar.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        
        return menuBar
    }()
    
    lazy var horizontalBar: UIView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 4)
        let horizontalBar = UIView(frame: frame)
        horizontalBar.backgroundColor = .blue
        return horizontalBar
    }()
    
    lazy var pagingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - menuBarHeight - 4)
        let pagingCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        pagingCollectionView.register(Map.self, forCellWithReuseIdentifier: "map")
        pagingCollectionView.register(List.self, forCellWithReuseIdentifier: "list")
        pagingCollectionView.isPagingEnabled = true
        pagingCollectionView.bounces = false
        pagingCollectionView.delegate = self
        pagingCollectionView.dataSource = self
        return pagingCollectionView
    }()
    
    let menuBarHeight: CGFloat = 50
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    var eventsToPass: [Event]?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(menuBar)
        
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: menuBarHeight).isActive = true
        
        view.addSubview(horizontalBar)
        
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        horizontalBar.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        horizontalBarLeftAnchorConstraint = horizontalBar.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBar.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        horizontalBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        view.addSubview(pagingCollectionView)
        
        pagingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pagingCollectionView.topAnchor.constraint(equalTo: horizontalBar.bottomAnchor).isActive = true
        pagingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pagingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pagingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        pagingCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
        if scrollView.contentOffset.x == 0 {
            let selectedIndexPath = IndexPath(item: 0, section: 0)
            menuBar.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        }
        self.view.layoutIfNeeded()
    }
}

extension MainViewController: PushDataDelegate {
    func finishPush(event: Event) {
        let nextViewController = InformationViewController()
        nextViewController.event = event
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension MainViewController: PassDataDelegate {
    func passData(events: [Event]) {
        eventsToPass = events
        pagingCollectionView.reloadItems(at: [IndexPath(row: 1, section: 0)])
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == menuBar {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuBarCell", for: indexPath) as! MenuBarCell
            let titles = ["Map", "Events"]
            cell.menuLabel.text = titles[indexPath.row]
            return cell
        } else { // if collectionView == pagingCollectionView
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "map", for: indexPath) as! Map
                cell.pushDataDelegate = self
                cell.passDataDelegate = self
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "list", for: indexPath) as! List
                cell.pushDataDelegate = self
                if let eventsToPass = eventsToPass {
                    if eventsToPass.count > 0 {
                        cell.events = eventsToPass
                    }
                }
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuBar {
            scrollToMenuIndex(menuIndex: indexPath.item)
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == menuBar {
            return CGSize(width: view.frame.width / 2, height: menuBarHeight)
        } else { // if pagingCollectionView
            return CGSize(width: pagingCollectionView.frame.width, height: pagingCollectionView.frame.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

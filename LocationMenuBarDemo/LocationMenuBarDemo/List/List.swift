//
//  List.swift
//  MDB Demo
//
//  Created by Andrew Santoso on 8/28/18.
//  Copyright © 2018 Andrew Santoso. All rights reserved.
//

import UIKit

class List: UICollectionViewCell {
    
    lazy var eventsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let eventsCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        eventsCollectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        eventsCollectionView.register(EventCell.self, forCellWithReuseIdentifier: "eventCell")
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        return eventsCollectionView
    }()
    
    var events: [Event]? {
        didSet {
            eventsCollectionView.reloadData()
        }
    }
    
    var pushDataDelegate: PushDataDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }

    private func setupViews() {
        
        addSubview(eventsCollectionView)
        eventsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}

extension List: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
        cell.event = events?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EventCell
        if let event = cell.event {
            self.pushDataDelegate?.finishPush(event: event)
        }
    }
}

extension List: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 250)
    }
}


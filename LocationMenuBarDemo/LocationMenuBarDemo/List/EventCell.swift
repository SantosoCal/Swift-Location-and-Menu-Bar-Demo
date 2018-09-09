//
//  EventCell.swift
//  MDB Demo
//
//  Created by Andrew Santoso on 8/28/18.
//  Copyright © 2018 Andrew Santoso. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: imageViewHeight)
        let imageView = UIImageView(frame: frame)
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabelFrame = CGRect(x: 0, y: 0, width: eventInfoView.frame.width, height: eventInfoView.frame.height / 2)
        let nameLabel = UILabel(frame: nameLabelFrame)
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        return nameLabel
    }()
    
    lazy var infoLabel: UILabel = {
        let infoLabelFrame = CGRect(x: 0, y: 0, width: eventInfoView.frame.width, height: eventInfoView.frame.height / 2)
        let infoLabel = UILabel(frame: infoLabelFrame)
        infoLabel.font = UIFont.systemFont(ofSize: 13)
        return infoLabel
    }()
    
    lazy var eventInfoView: UIView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: eventInfoViewHeight)
        let eventInfoView = UIView(frame: frame)
        eventInfoView.backgroundColor = .white
        return eventInfoView
    }()
    
    var event: Event? {
        didSet {
            if let event = event {
                nameLabel.text = event.title
                infoLabel.text = "\(event.date) \(event.locationName)"
                imageView.image = UIImage(named: event.imageName)
            }
        }
    }
    
    var imageViewHeight: CGFloat = 175
    var eventInfoViewHeight: CGFloat = 75
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        
        addSubview(eventInfoView)
        eventInfoView.translatesAutoresizingMaskIntoConstraints = false
        //eventInfoView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        eventInfoView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        eventInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        eventInfoView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        eventInfoView.heightAnchor.constraint(equalToConstant: eventInfoViewHeight).isActive = true
        
        
        eventInfoView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: eventInfoView.leadingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: eventInfoView.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: eventInfoView.topAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: eventInfoView.frame.height / 2).isActive = true
        
        eventInfoView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.leadingAnchor.constraint(equalTo: eventInfoView.leadingAnchor, constant: 8).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: eventInfoView.trailingAnchor).isActive = true
        infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: eventInfoView.frame.height / 2).isActive = true
        
        print("imageViewframeheight: \(imageView.frame.height)")
        print("eventInfoViewframeheight: \(eventInfoView.frame.height)")
    }
    
}

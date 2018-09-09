//
//  MenuBarCell.swift
//  Location Menu Bar Demo
//
//  Created by Andrew Santoso on 8/28/18.
//  Copyright © 2018 Andrew Santoso. All rights reserved.
//

import UIKit

class MenuBarCell: UICollectionViewCell {
    
    var menuLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews() {
        
        self.backgroundColor = .white
        menuLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        menuLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
        menuLabel.textAlignment = .center
        addSubview(menuLabel)
    }
    
    override var isHighlighted: Bool {
        didSet {
            menuLabel.textColor = isSelected ? .blue : .lightGray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            menuLabel.textColor = isSelected ? .blue : .lightGray
        }
    }
}

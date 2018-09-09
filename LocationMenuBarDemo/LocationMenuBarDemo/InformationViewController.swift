//
//  InformationViewController.swift
//  Location Menu Bar Demo
//
//  Created by Andrew Santoso on 8/28/18.
//  Copyright © 2018 Andrew Santoso. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: imageViewHeight)
        let imageView = UIImageView(frame: frame)
        return imageView
    }()
    
    lazy var textView: UITextView = {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: textViewHeight)
        let textView = UITextView(frame: frame)
        return textView
    }()
    
    var imageViewHeight: CGFloat = 300
    
    var textViewHeight: CGFloat = 200
    
    var event: Event? {
        didSet {
            if let event = event {
                setupViews()
                self.title = event.title
                imageView.image = UIImage(named: event.imageName)
                setupTextView(event: event)
            }
        }
    }
    
    private func setupTextView(event: Event) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributes = [NSAttributedStringKey.paragraphStyle : style]
        let info = "\(event.title) \n\(event.date) \n\(event.locationName)"
        textView.attributedText = NSAttributedString(string: info, attributes: attributes)
        textView.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.constraint(equalToConstant: textViewHeight).isActive = true
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

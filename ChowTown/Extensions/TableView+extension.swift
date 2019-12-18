//
//  TableView+extension.swift
//  VisitorsApp
//
//  Created by Jordain Gijsbertha on 6/19/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    
    
    func setEmptyViewWithImage(title: String, message: String, messageImage: UIImage) {
        let emptyView = UIView(frame: CGRect(x: center.x, y: center.y, width: bounds.size.width, height: bounds.size.height))
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        // emptyView.backgroundColor = .red
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "Overpass-Bold", size: 16)
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "Overpass-Regular", size: 15)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(messageLabel)
        //        emptyView.borderColor = UIColor.black
        //        emptyView.borderWidth = 10
        //        messageImageView.borderColor = UIColor.black
        
        messageImageView.center = CGPoint(x: emptyView.frame.size.width  / 2,
                                          y: emptyView.frame.size.height / 2)
        //        messageImageView.backgroundColor = UIColor.black
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -50).isActive = true
        //        messageImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true // adjust image width
        //        messageImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true // adjust image height
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = messageImage
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        backgroundView = emptyView
        separatorStyle = .none
    }
    
    func restore() {
        backgroundView = nil
        separatorStyle = .none
        if let viewWithTag = self.viewWithTag(20) {
                   viewWithTag.removeFromSuperview()
                   
               backgroundView = nil
           }
    }
    
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor(named: "BlackToOrange")!
        titleLabel.font = UIFont(name: "Nunito-Bold", size: 16)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "Nunito-SemiBold", size: 15)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        titleLabel.textAlignment = .center
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        backgroundView = emptyView
        separatorStyle = .none
    }
    
    func showLoadingIndicator() {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        backgroundView = emptyView
       // let activityIndicator = MaterialLoadingIndicator(radius: 14, color: UIColor.softBlue)
           let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = UIColor.black
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: backgroundView!.frame.width / 2, y: backgroundView!.frame.height / 2)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tag = 20
        self.addSubview(activityIndicator)
       // backgroundView?.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: backgroundView!.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: backgroundView!.centerYAnchor, constant: -50).isActive = true
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator(){
        if let viewWithTag = self.viewWithTag(20) {
            viewWithTag.removeFromSuperview()
            
        backgroundView = nil
    }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red) / 255
        let newGreen = CGFloat(green) / 255
        let newBlue = CGFloat(blue) / 255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

extension UIAlertController {
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.tintColor = UIColor.softBlue
    }
}

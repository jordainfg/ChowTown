//
//  LoginViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 13/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit


enum loginDataType {
    case header
    case body
    case footer
    
}
class LoginViewController: UIViewController, UITextFieldDelegate , MyCustomCellDelegator{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewcellTypes: [[loginDataType]] {
        
        let types: [[loginDataType]] = [[.header,.body]]
        
        return types
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupTableView()
        // Do any additional setup after loading the view.
        registerForKeyboardWillShowNotification(tableView)
               registerForKeyboardWillHideNotification(tableView)
     
    }
    func setUpView(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

          self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: LoginHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LoginHeaderTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: LoginBodyTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LoginBodyTableViewCell.reuseIdentifier())
    }
    func textFieldShouldReturn(_: UITextField) -> Bool {
           view.endEditing(true)
           return false
       }
    //MARK: - MyCustomCellDelegator Methods

    func callSegueFromCell(segueIdentifier : String, index : Int, selected : Any) {
      //try not to send self, just to avoid retain cycles(depends on how you handle the code on the next controller)
        self.performSegue(withIdentifier: segueIdentifier, sender: nil )

    }
    
  
    
    
}

extension LoginViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        return tableViewcellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewcellTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: LoginHeaderTableViewCell.reuseIdentifier()) as! LoginHeaderTableViewCell
            return cell
        case .body:
            let cell = tableView.dequeueReusableCell(withIdentifier: LoginBodyTableViewCell.reuseIdentifier()) as! LoginBodyTableViewCell
           
             cell.delegate = self
            return cell
        case .footer:
            let cell = tableView.dequeueReusableCell(withIdentifier: LoginHeaderTableViewCell.reuseIdentifier()) as! LoginHeaderTableViewCell
            return cell
            
        }
    }
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
            
        case .header:
            return tableView.frame.size.height  / 4
        case .body:
            return tableView.frame.size.height  / 3
        case .footer:
            return 100
            
        }
    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //      //  let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCellIdentifier") as! HeaderForTableViewCell
    //        switch section {
    //
    //        default:
    //
    //        }
    //    }
    //
    //    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        switch section {
    ////        case 0:
    ////            return 44
    ////        case 1:
    ////            return 1
    ////        default:
    ////            return 0
    //        }
    
    
    
    
    
    
    
}

extension UIViewController {

    func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: keyboardSize.height, right: scrollView.contentInset.right)

            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }

    func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: 0, right: scrollView.contentInset.right)

            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }
}

extension UIScrollView {

    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
}

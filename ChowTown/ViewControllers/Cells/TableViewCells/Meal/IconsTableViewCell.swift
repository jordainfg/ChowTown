//
//  AllergensTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class IconsTableViewCell: UITableViewCell {
    
    var delegate: MSPeekCollectionViewDelegateImplementation!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var iconSetName: UILabel!
    var iCons : [Int] = [1,2,3,4,5,6,7,8,9]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCollectionView()
    }
    
    
    
    
    func setUpCollectionView(){
        collectionView.dataSource = self
        
        // delegate = MSPeekCollectionViewDelegateImplementation(cellSpacing: 10)
//        delegate = MSPeekCollectionViewDelegateImplementation(cellPeekWidth: 20)
//        collectionView.configureForPeekingDelegate()
//        collectionView.delegate = delegate
        collectionView.register(UINib.init(nibName: "iconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "iconCollectionViewCellID")
        guard let collectionView = collectionView else { fatalError() }
        //collectionView.decelerationRate = .fast // uncomment if necessary
        
        
        collectionView.contentInsetAdjustmentBehavior = .always
        // hide the scroll indicator
        collectionView.showsHorizontalScrollIndicator = false
        
        
    }
    
    
     // Reuser identifier
     class func reuseIdentifier() -> String {
         return "IconsTableViewCellID"
     }
     
     // Nib name
     class func nibName() -> String {
         return "IconsTableViewCell"
     }
    
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}

extension IconsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    private func calculateSectionInset() -> CGFloat {
        let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
        let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
        let cellBodyWidth: CGFloat = 236 + (cellBodyViewIsExpended ? 174 : 0)
        let buttonWidth: CGFloat = 50
        let inset = (collectionViewLayout.collectionView!.frame.width - cellBodyWidth + buttonWidth) / 4
        return inset
    }
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset() // This inset calculation is some magic so the next and the previous cells will peek from the sides. Don't worry about it
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        collectionViewLayout.itemSize = CGSize(width: collectionViewLayout.collectionView!.frame.size.width - inset * 2, height: collectionViewLayout.collectionView!.frame.size.height)
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return iCons.count
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCollectionViewCellID", for: indexPath) as! iconCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.iConNumber = iCons[indexPath.row]
        cell.updateIcons()
        cell.cornerRadius = 15
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60  , height: 50  )
    }
    
    
}

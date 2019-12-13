//
//  CollectionTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class MealCollectionTableViewCell: UITableViewCell {
    var behavior: MSCollectionViewPeekingBehavior = MSCollectionViewPeekingBehavior(cellPeekWidth: 20)
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCollectionView()
    }
    func setUpCollectionView(){
        collectionView.dataSource = self
  collectionView.configureForPeekingBehavior(behavior: behavior)
       // delegate = MSPeekCollectionViewDelegateImplementation(cellSpacing: 10)
     
        collectionView.configureForPeekingBehavior(behavior: behavior)
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "FeaturedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturedCollectionViewCellID")
        guard let collectionView = collectionView else { fatalError() }
        //collectionView.decelerationRate = .fast // uncomment if necessary
        
        
        collectionView.contentInsetAdjustmentBehavior = .always
        // hide the scroll indicator
        collectionView.showsHorizontalScrollIndicator = false
        
        
    }
    
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "MealCollectionTableViewCell"
    }
    
    // Nib name
    class func nibName() -> String {
        return "MealCollectionTableViewCell"
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension MealCollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
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
        return 10
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCellID", for: indexPath) as! FeaturedCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        cell.cornerRadius = 15
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width  , height: 400  )
    }
    
    
}



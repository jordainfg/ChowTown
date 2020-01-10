//
//  FavoriteEstablishmentTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 15/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class FavoriteEstablishmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    var behavior: MSCollectionViewPeekingBehavior = MSCollectionViewPeekingBehavior(cellPeekWidth: 30)
    
    var delegate:searchViewControllerCellDelegator!
    
    var favorites : [FavoriteRestaurant]? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setUpCollectionView()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    
    func setUpCollectionView(){
        
        //collectionView.configureForPeekingBehavior(behavior: behavior)
       // delegate = MSPeekCollectionViewDelegateImplementation(cellPeekWidth: 20)
       // delegate = MSPeekCollectionViewDelegateImplementation(numberOfItemsToShow: 1)
           collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
         collectionView.decelerationRate = .fast // uncomment if necessary
          collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(UINib.init(nibName: "FavoriteEstablishmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteEstablishmentCollectionViewCellID")
        //  guard let collectionView = collectionView else { fatalError() }
        //collectionView.decelerationRate = .fast // uncomment if necessary
    }
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "FavoriteEstablishmentTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "FavoriteEstablishmentTableViewCell"
    }
    
}

extension FavoriteEstablishmentTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return favorites!.count
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteEstablishmentCollectionViewCellID", for: indexPath) as! FavoriteEstablishmentCollectionViewCell
       cell.backgroundColor = UIColor.white
        
        cell.configure(with: favorites?[indexPath.row])
      
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedFavorite = favorites?[indexPath.row]{
            self.delegate.prepareForSequeFromFavCollectionViewCell(segueIdentifier: "toRestaurant", restaurant: selectedFavorite)
        }
      
        
    }
   
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//            behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width  , height: collectionView.frame.size.height  )
    }
    
    
}

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
    var delegate: MSPeekCollectionViewDelegateImplementation!
    
    var favorites : [Restaurant]? = nil
    
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
        
        delegate = MSPeekCollectionViewDelegateImplementation(cellSpacing: 0,cellPeekWidth: 30,numberOfItemsToShow: 1)
       // delegate = MSPeekCollectionViewDelegateImplementation(cellPeekWidth: 20)
       // delegate = MSPeekCollectionViewDelegateImplementation(numberOfItemsToShow: 1)
        collectionView.configureForPeekingDelegate()
        collectionView.delegate = delegate
        collectionView.dataSource = self
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
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width  , height: collectionView.frame.size.height  )
    }
    
    
}

//
//  ReservationTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 04/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import FirebaseUI
class ReservationTableViewCell: UITableViewCell {
    
    let viewModel = ViewModel()
    
    var meals : [Meal] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedSpecial = 0
    
    
    let flowLayout = ZoomAndSnapFlowLayout()
    
    var delegate:MyCustomCellDelegator!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "ReservationTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "ReservationTableViewCell"
    }
    
    
    func setupCollectionView(){
        guard let collectionView = collectionView else { fatalError() }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "ReservationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReservationCollectionViewCellID")
        
        collectionView.decelerationRate = .fast // uncomment if necessary
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        // hide the scroll indicator
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    
    
    
}

extension ReservationTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
   
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReservationCollectionViewCellID", for: indexPath) as! ReservationCollectionViewCell
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      self.delegate.callSegueFromCell(segueIdentifier: "toReservationDetails", selectedMeal: nil, selected: "")
             
    }
  
    //makes sure the first cell is centerd
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth : CGFloat = collectionView.frame.size.width / 1.8

        let numberOfCells = floor(self.frame.size.width / cellWidth)
        let edgeInsets = (self.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
    

    return UIEdgeInsets(top: 15, left: edgeInsets, bottom: 0, right: edgeInsets)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 1.8  , height: collectionView.frame.size.height  / 1.4
            
        )
    }
    
    
}

//
//  MenuSpecialsTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 18/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class MenuSpecialsTableViewCell: UITableViewCell {
    
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
        return "MenuSpecialsTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "MenuSpecialsTableViewCell"
    }
    func setupCollectionView(){
        guard let collectionView = collectionView else { fatalError() }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "SpecialCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SpecialCollectionViewCellID")
        
        collectionView.decelerationRate = .fast // uncomment if necessary
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        // hide the scroll indicator
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    
    
    
}

extension MenuSpecialsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialCollectionViewCellID", for: indexPath) as! SpecialCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.coverImageView.hero.id = "specialHeroID\(indexPath.row)"
        cell.infoView.hero.id = "specialHeroID\(indexPath.row)"
        cell.specialName.hero.id = "specialNameHeroID\(indexPath.row)"
        cell.specialDetail.hero.id = "specialDetailHeroID\(indexPath.row)"
        cell.cornerRadius = 15
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // selectedSpecial = indexPath.ro
        self.delegate.callSegueFromCell(segueIdentifier: "toMeal", index: indexPath.row)
        
        //performSegue(withIdentifier: "bla", sender: nil)
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

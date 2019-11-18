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
        collectionView.dataSource = self
             collectionView.delegate = self
             collectionView.register(UINib.init(nibName: "SpecialCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SpecialCollectionViewCellID")
             guard let collectionView = collectionView else { fatalError() }
             //collectionView.decelerationRate = .fast // uncomment if necessary
             
             collectionView.collectionViewLayout = flowLayout
             collectionView.contentInsetAdjustmentBehavior = .always
             // hide the scroll indicator
             collectionView.showsHorizontalScrollIndicator = false
             collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
        cell.specialName.hero.id = "specialNameHeroID\(indexPath.row)"
        cell.specialDetail.hero.id = "specialDetailHeroID\(indexPath.row)"
        cell.cornerRadius = 15
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSpecial = indexPath.row
        //performSegue(withIdentifier: "bla", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 1.8  , height: collectionView.frame.size.height  / 1.4
            
        )
    }
    
    
}

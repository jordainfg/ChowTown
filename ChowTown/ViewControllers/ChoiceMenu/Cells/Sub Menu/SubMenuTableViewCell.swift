//
//  CollectionTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class SubMenuTableViewCell: UITableViewCell {
    var delegate: MSPeekCollectionViewDelegateImplementation!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    let flowLayout = ZoomAndSnapFlowLayout()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }
    
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "SubMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubMenuCollectionViewCellID")
        guard let collectionView = collectionView else { fatalError() }
        collectionView.contentInsetAdjustmentBehavior = .always
        // hide the scroll indicator
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "SubMenuTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "SubMenuTableViewCell"
    }
    

    
}
extension SubMenuTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubMenuCollectionViewCellID", for: indexPath) as! SubMenuCollectionViewCell
        cell.backgroundColor = UIColor.clear
        let color = UIColor.randomm
        cell.cardView.backgroundColor = color
        cell.cardImage.backgroundColor = color
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2.3  , height: collectionView.frame.size.height  / 1.4
            
        )
    }
    
    
}


extension UIColor {
    static var randomm: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}

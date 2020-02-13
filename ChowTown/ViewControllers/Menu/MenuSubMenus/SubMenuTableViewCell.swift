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
   // var delegate: MSPeekCollectionViewDelegateImplementation!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    let flowLayout = ZoomAndSnapFlowLayout()
    let viewModel = ViewModel()
    var menus : [Menu] = []
    var tint : UIColor =  UIColor.clear
    
    var delegate : MyCustomCellDelegator!
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
      //  collectionView.contentInsetAdjustmentBehavior = .always
        // hide the scroll indicator
        collectionView.showsHorizontalScrollIndicator = false
      
    }
    func setMenus(menus : Array<Menu>){
        self.menus = menus
        collectionView.reloadData()
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
        return menus.count
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubMenuCollectionViewCellID", for: indexPath) as! SubMenuCollectionViewCell
        cell.cardImage.image = UIImage(named: menus[indexPath.row].iCon)
        //cell.cardImage.backgroundColor = UIColor.clear
        //cell.cardImage.tintColor = UIColor.hexStringToUIColor(hex: menus[indexPath.row].color)
       // cell.cardView.backgroundColor = UIColor.hexStringToUIColor(hex: Menus[indexPath.row].color)
        cell.backgroundColor = UIColor.clear
        cell.subMenuName.text = menus[indexPath.row].title
        cell.subMenuSubTitle.setTitle(menus[indexPath.row].detail, for: .normal)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.callSegueFromCell(segueIdentifier: "toSubMenuMealsAndDrinks", selectedMeal: nil, selected: menus[indexPath.row])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3.5  , height: collectionView.frame.size.height 
            
        )
    }
    
    
}




//
//  SubMenuMealsAndDrinksFilteringTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 02/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

protocol filteringDelegate: class {
    func didSelectFilterOptions()
}
class SubMenuMealsAndDrinksFilteringTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filteringOptions = ["All","Vegan", "Vegiterian", "Gluten-free" , "Halal"]
    
    weak var delegate: filteringDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCollectionView()
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        collectionView.register(UINib.init(nibName: SubMenuMealsAndDrinksFilterItemCollectionViewCell.nibName(), bundle: nil), forCellWithReuseIdentifier: SubMenuMealsAndDrinksFilterItemCollectionViewCell.reuseIdentifier())
        
        guard let collectionView = collectionView else { fatalError() }
        //  collectionView.contentInsetAdjustmentBehavior = .always
        // hide the scroll indicator
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "SubMenuMealsAndDrinksFilteringTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "SubMenuMealsAndDrinksFilteringTableViewCell"
    }
    
}

extension SubMenuMealsAndDrinksFilteringTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return filteringOptions.count
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
        self.collectionView(self.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubMenuMealsAndDrinksFilterItemCollectionViewCellID", for: indexPath) as! SubMenuMealsAndDrinksFilterItemCollectionViewCell
        cell.label.text = filteringOptions[indexPath.row]
        cell.array = filteringOptions
        cell.configure(isActive: false)
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SubMenuMealsAndDrinksFilterItemCollectionViewCell
        deselectAllItems()
        cell?.configure(isActive: true)
        delegate?.didSelectFilterOptions()
    }
    
    
    func deselectAllItems() {
        for i in 0...filteringOptions.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = collectionView.cellForItem(at: indexPath) as? SubMenuMealsAndDrinksFilterItemCollectionViewCell
             cell?.configure(isActive: false)
        }
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubMenuMealsAndDrinksFilterItemCollectionViewCellID", for: indexPath) as! SubMenuMealsAndDrinksFilterItemCollectionViewCell
    //
    //        return CGSize(width: cell.designableView.frame.size.width  , height: 30 )
    //    }
    
    
}

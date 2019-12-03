//
//  SubMenuMealsAndDrinksFilterItemCollectionViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 02/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SubMenuMealsAndDrinksFilterItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var designableView: UIView!
    @IBOutlet weak var isActiveIndicator: DesignableView!
    var array = [""]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "SubMenuMealsAndDrinksFilterItemCollectionViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "SubMenuMealsAndDrinksFilterItemCollectionViewCell"
    }
    
    
    func configure(isActive : Bool){
        
        if isActive{
            
            UIView.transition(with: self.label, duration: 0.7, options: .transitionCrossDissolve, animations:
                { self.label.textColor = UIColor.systemIndigo
            }, completion: nil)
                UIView.animate(withDuration: 0.7, animations: {
                self.isActiveIndicator.backgroundColor = UIColor.systemIndigo
            })
        } else{
            UIView.animate(withDuration: 0.2, animations: {
                self.isActiveIndicator.backgroundColor = UIColor.clear
                self.label.textColor = UIColor.paleGrey
            })
            
        }
        
    }
    
    var isHeightCalculated: Bool = false
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
}



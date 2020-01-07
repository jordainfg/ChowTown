//
//  SpecialCollectionViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 29/10/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SpecialCollectionViewCell: UICollectionViewCell {
    
    
    let viewModel = ViewModel()
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var specialName: UILabel!
    @IBOutlet weak var specialDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(meal : Meal){
        specialName.text = meal.name
        specialDetail.text = meal.detail
        
        let placeholderImage = UIImage(named: "placeHolder")
        let httpsReference =   viewModel.storage.reference(forURL: meal.imageRef)
        
        coverImageView.sd_setImage(with: httpsReference, placeholderImage: placeholderImage)
      
    }
}

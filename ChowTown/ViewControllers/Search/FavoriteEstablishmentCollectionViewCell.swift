//
//  FavoriteEstablishmentCollectionViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 15/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class FavoriteEstablishmentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var establishmentName: UILabel!
    
    @IBOutlet weak var establishmentAddress: UIButton!
    
   
    @IBOutlet weak var establishmentPhone: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
      //  image.makeRounded()
    }
    
    // Reuser identifier
           class func reuseIdentifier() -> String {
               return "FavoriteEstablishmentCollectionViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "FavoriteEstablishmentCollectionViewCell"
           }
    
    func configure(with establishment: Establishment?){
        establishmentName.text = establishment?.name
        establishmentAddress.setTitle(establishment?.address, for: .normal)
        establishmentPhone.setTitle("20203093", for: .normal)
    }

}

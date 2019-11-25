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
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var address: UIButton!
    

    @IBOutlet weak var about: UIButton!
    
    
    
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
    
    func configure(with establishment: Restaurant?){
        name.text = establishment?.name
        address.setTitle(establishment?.address, for: .normal)
        about.setTitle(establishment?.about, for: .normal)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
                        //check current value
                        if (sender.imageView?.image == UIImage(systemName: "star")) {
                            //set default
                            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
                        } else{
                            // set like
                            sender.setImage(UIImage(systemName: "star"), for: .normal)
                        }
        },
                       completion: { Void in()  }
        )
    }
    
    
}

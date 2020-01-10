//
//  EstablishmentTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 15/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class EstablishmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var icon: UIImageView!
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "EstablishmentTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "EstablishmentTableViewCell"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(restaurant: Restaurant){
        name.text = restaurant.name
        address.text = restaurant.address
        icon.tintColor = UIColor.hexStringToUIColor(hex: restaurant.color)
        icon.image = UIImage(systemName: "\(restaurant.name.first?.lowercased() ?? "z").circle.fill")
    }
    
    func configureFavorite(restaurant: FavoriteRestaurant){
        name.text = restaurant.name
        address.text = restaurant.address
        icon.tintColor = UIColor.systemIndigo
        icon.image = UIImage(systemName: "\(restaurant.name.first?.lowercased() ?? "z").circle.fill")
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
                        //check current value
                        if (sender.imageView?.image == UIImage(systemName: "star.fill")) {
                            //set default
                            sender.setImage(UIImage(systemName: "star"), for: .normal)
                        } else{
                            // set like
                            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
                        }
        },
                       completion: { Void in()  }
        )
        
    }
}

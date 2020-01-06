//
//  RewardPrizeTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class RewardPrizeTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var points: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Reuser identifier
      class func reuseIdentifier() -> String {
      return "RewardPrizeTableViewCellID"
      }
             
      // Nib name
      class func nibName() -> String {
      return "RewardPrizeTableViewCell"
      }
}

//
//  SpecialCollectionViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 29/10/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SpecialCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var specialName: UILabel!
    @IBOutlet weak var specialDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterialLight)
//             let blurEffectView = UIVisualEffectView(effect: blurEffect)
//             blurEffectView.frame = infoView.bounds
//                 blurEffectView.layer.cornerRadius = 15
//             blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//             infoView.insertSubview(blurEffectView, at: 0)
    }
    func addBlurTo(_ image: UIImage) -> UIImage? {
        if let ciImg = CIImage(image: image) {
            ciImg.applyingFilter("CIGaussianBlur")
            return UIImage(ciImage: ciImg)
        }
        return nil
    }
}

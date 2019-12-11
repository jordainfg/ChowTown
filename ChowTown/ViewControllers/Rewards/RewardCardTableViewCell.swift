//
//  RewardCardTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class RewardCardTableViewCell: UITableViewCell {

    @IBOutlet weak var qrImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        qrImage.image = generateQRCode(from: "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Reuser identifier
      class func reuseIdentifier() -> String {
      return "RewardCardTableViewCellID"
      }
             
      // Nib name
      class func nibName() -> String {
      return "RewardCardTableViewCell"
      }
    func generateQRCode(from string: String) -> UIImage? {
    // Get define string to encode
    let myString = "https://pennlabs.org"
    // Get data from the string
    let data = myString.data(using: String.Encoding.ascii)
    // Get a QR CIFilter
    guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
    // Input the data
    qrFilter.setValue(data, forKey: "inputMessage")
    // Get the output image
    guard let qrImage = qrFilter.outputImage else { return  nil}
    // Scale the image
    let transform = CGAffineTransform(scaleX: 10, y: 10)
    let scaledQrImage = qrImage.transformed(by: transform)
    // Do some processing to get the UIImage
    let context = CIContext()
    guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil }
    let processedImage = UIImage(cgImage: cgImage)
        return processedImage
    }
}

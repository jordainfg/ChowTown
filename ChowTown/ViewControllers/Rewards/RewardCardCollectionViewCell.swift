//
//  RewardCardCollectionViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class RewardCardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        qrCodeImageView.image = generateQRCode(from: "Hacking with Swift is the best iOS coding tutorial I've ever read!")
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
           let screenWidth = UIScreen.main.bounds.size.width
           widthConstraint.constant = screenWidth - (2 * 20)
    }

    // Reuser identifier
      class func reuseIdentifier() -> String {
      return "RewardCardCollectionViewCellID"
      }
             
      // Nib name
      class func nibName() -> String {
      return "RewardCardCollectionViewCell"
      }
    
    func generateQRCode(from string: String) -> UIImage? {
     // import UIKit
      // Get define string to encode
      let myString = "https://pennlabs.org"
      // Get data from the string
      let data = myString.data(using: String.Encoding.ascii)
      // Get a QR CIFilter
      guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
      // Input the data
      qrFilter.setValue(data, forKey: "inputMessage")
      // Get the output image
      guard let qrImage = qrFilter.outputImage else { return nil }
      // Scale the image
      let transform = CGAffineTransform(scaleX: 10, y: 10)
      let scaledQrImage = qrImage.transformed(by: transform)
      // Invert the colors
      guard let colorInvertFilter = CIFilter(name: "CIColorInvert") else { return nil }
      colorInvertFilter.setValue(scaledQrImage, forKey: "inputImage")
      guard let outputInvertedImage = colorInvertFilter.outputImage else { return nil }
      // Replace the black with transparency
      guard let maskToAlphaFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
      maskToAlphaFilter.setValue(outputInvertedImage, forKey: "inputImage")
      guard let outputCIImage = maskToAlphaFilter.outputImage else { return nil }
      // Do some processing to get the UIImage
      let context = CIContext()
      guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
      let processedImage = UIImage(cgImage: cgImage)
        return processedImage
    }
}

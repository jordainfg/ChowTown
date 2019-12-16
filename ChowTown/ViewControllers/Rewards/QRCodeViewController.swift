//
//  QRCodeViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 16/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import SPLarkController
class QRCodeViewController: UIViewController {

    @IBOutlet weak var qrcodeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        qrcodeImageView.image = generateQrcode()
        // Do any additional setup after loading the view.
        
        
    }
    
    func generateQrcode() -> UIImage?{
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
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

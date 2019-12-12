//
//  ScanViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 13/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var headerTextStackView: UIStackView!
    @IBOutlet weak var footerTextStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startQRScanner()
        // Do any additional setup after loading the view.
        
        let overlay = createOverlay(frame: view.frame,
                                    xOffset: view.frame.width / 2,
                                    yOffset: view.frame.height / 2,
                                    radius: 45)
       
        self.view.addSubview(overlay)
         self.view.bringSubviewToFront(cancelButton)
         self.view.bringSubviewToFront(headerTextStackView)
        self.view.bringSubviewToFront(footerTextStackView)
    }
    
 
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createOverlay(frame: CGRect,
                       xOffset: CGFloat,
                       yOffset: CGFloat,
                       radius: CGFloat) -> UIView {
        // Step 1
        var firstRect = CGRect(x:0 , y: 0, width: view.frame.width / 1.3, height: 300 )
        firstRect.center = self.view.center
        var secondRect = CGRect(x:1 , y: 1, width: view.frame.width / 1.3 + 2, height: 302 )
        secondRect.center = self.view.center
        let overlayView = UIView(frame: frame)
        
        let borderView = UIView(frame: secondRect  )
        borderView.cornerRadius = radius
        borderView.center = self.view.center
        borderView.backgroundColor = UIColor.white
        overlayView.addSubview(borderView)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Step 2 r
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: xOffset * 2, height: self.view.bounds.size.height), cornerRadius: 0)
        
        
        
        path.append(UIBezierPath(roundedRect: firstRect , cornerRadius: radius))
        
        path.usesEvenOddFillRule = true
        
        
        
        // Step 3
        
        
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path.cgPath
        
        
        // For Swift 4.0
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        // For Swift 4.2
        maskLayer.fillRule = .evenOdd
        // Step 4
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        
        return overlayView
    }
    func startQRScanner() {
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back) else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.upce, AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.aztec, AVMetadataObject.ObjectType.itf14, AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.code128, AVMetadataObject.ObjectType.pdf417, AVMetadataObject.ObjectType.interleaved2of5, AVMetadataObject.ObjectType.dataMatrix, AVMetadataObject.ObjectType.code39Mod43]
            
            //            // frame to highlight the QR code
            //            qrCodeFrameView = UIView()
            //            qrCodeFrameView!.layer.borderColor = UIColor.green.cgColor
            //            qrCodeFrameView!.layer.borderWidth = 2
            //            qrBackgroundView.addSubview(qrCodeFrameView!)
            //            qrBackgroundView.bringSubviewToFront(qrCodeFrameView!)
        } catch {
            return
        }
        
        startQRReader()
    }
    func startQRReader() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.frame = self.view.bounds
        previewLayer.connection?.videoOrientation = .portrait
        view.layer.addSublayer(previewLayer)
        
        //        qrBackgroundView.layer.addSublayer(videoPreviewLayer!)
        //        qrBackgroundView.bringSubviewToFront(qrScannerIndicatorImageView)
        //        qrScannerIndicatorImageView.isHidden = false
        //
        captureSession?.startRunning()
    }
    
    
    func stopQRreader() {
        captureSession?.stopRunning()
        //        qrScannerIndicatorImageView?.isHidden = true
        //        toggleTorch(switchOff: true)
        
        //          if qrCodeFrameView != nil {
        //              //  qrBackgroundView?.bringSubviewToFront(qrCodeFrameView!)
        //          }
    }
    
    // Business Logic
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //        qrBackgroundView.setNeedsLayout()
        //        qrBackgroundView.layoutIfNeeded()
        previewLayer?.frame = self.view.bounds
    }
    
    func metadataOutput(_: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from _: AVCaptureConnection) {
        //   setLoading()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        } else{
            let Alert = UIAlertController(title: "Check in failed", message: "Please try again or use our doorbel", preferredStyle: UIAlertController.Style.alert)
            Alert.addAction(UIAlertAction(title: "Okay", style: .default) { (_: UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            })
            self.present(Alert, animated: true)
        }
        
        // dismiss(animated: true)
    }
    
    func found(code: String) {
        
        
    }
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    // handel orrientation when view changes
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Update camera orientation
        let videoOrientation: AVCaptureVideoOrientation
        switch UIDevice.current.orientation {
        case .portrait:
            videoOrientation = .portrait
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
        case .landscapeLeft:
            videoOrientation = .landscapeRight
        case .landscapeRight:
            videoOrientation = .landscapeLeft
        default:
            videoOrientation = .portrait
        }
        previewLayer.connection?.videoOrientation = videoOrientation
    }
}




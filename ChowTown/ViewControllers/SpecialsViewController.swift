//
//  SpecialsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 29/10/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SpecialsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "SpecialCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SpecialCollectionViewCellID")
        // padding space = collection view width - cell width
        let leftPadding = (collectionView.frame.size.width - collectionView.frame.size.height) / 2.0
        let rightPadding = leftPadding
        collectionView.contentInset = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
        // hide the scroll indicator
           collectionView.showsHorizontalScrollIndicator = false
    }
    
    
}
extension SpecialsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // center X of collection View
        let centerX = self.collectionView.center.x
        
        // only perform the scaling on cells that are visible on screen
        for cell in self.collectionView.visibleCells {
            
            // coordinate of the cell in the viewcontroller's root view coordinate space
            let basePosition = cell.convert(CGPoint.zero, to: self.view)
            let cellCenterX = basePosition.x + self.collectionView.frame.size.height / 2.0
            
            let distance = abs(cellCenterX - centerX)
            
            let tolerance : CGFloat = 0.02
            var scale = 1.00 + tolerance - (( distance / centerX ) * 0.105)
            if(scale > 1.0){
                scale = 1.0
            }
            
            // set minimum scale so the previous and next album art will have the same size
            // I got this value from trial and error
            // I have no idea why the previous and next album art will not be same size when this is not set 😅
            if(scale < 0.860091){
                scale = 0.860091
            }
            
            //....
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            // change the alpha of the image view
            let coverCell = cell as! SpecialCollectionViewCell
            coverCell.coverImageView.alpha = changeSizeScaleToAlphaScale(scale)
        }
        
    }
    func changeSizeScaleToAlphaScale(_ x : CGFloat) -> CGFloat {
        let minScale : CGFloat = 0.86
        let maxScale : CGFloat = 1.0
        
        let minAlpha : CGFloat = 0.25
        let maxAlpha : CGFloat = 1.0
        
        return ((maxAlpha - minAlpha) * (x - minScale)) / (maxScale - minScale) + minAlpha
    }
    // for custom snap-to paging, when user stop scrolling
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        var indexOfCellWithLargestWidth = 0
        var largestWidth : CGFloat = 1
        
        for cell in self.collectionView.visibleCells {
            if cell.frame.size.width > largestWidth {
                largestWidth = cell.frame.size.width
                if let indexPath = self.collectionView.indexPath(for: cell) {
                    indexOfCellWithLargestWidth = indexPath.item
                }
            }
        }
        
        collectionView.scrollToItem(at: IndexPath(item: indexOfCellWithLargestWidth, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialCollectionViewCellID", for: indexPath) as! SpecialCollectionViewCell
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

           // Get tapped cell location
           let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell

           // Freeze highlighted state (or else it will bounce back)
           cell.freezeAnimations()

           // Get current frame on screen
           let currentCellFrame = cell.layer.presentation()!.frame

           // Convert current frame to screen's coordinates
           let cardPresentationFrameOnScreen = cell.superview!.convert(currentCellFrame, to: nil)

           // Get card frame without transform in screen's coordinates  (for the dismissing back later to original location)
           let cardFrameWithoutTransform = { () -> CGRect in
               let center = cell.center
               let size = cell.bounds.size
               let r = CGRect(
                   x: center.x - size.width / 2,
                   y: center.y - size.height / 2,
                   width: size.width,
                   height: size.height
               )
               return cell.superview!.convert(r, to: nil)
           }()

           let cardModel = cardModels[indexPath.row]

           // Set up card detail view controller
           let vc = storyboard!.instantiateViewController(withIdentifier: "cardDetailVc") as! CardDetailViewController
           vc.cardViewModel = cardModel.highlightedImage()
           vc.unhighlightedCardViewModel = cardModel // Keep the original one to restore when dismiss
           let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
                                              fromCardFrameWithoutTransform: cardFrameWithoutTransform,
                                              fromCell: cell)
           transition = CardTransition(params: params)
           vc.transitioningDelegate = transition

           // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
           vc.modalPresentationCapturesStatusBarAppearance = true
           vc.modalPresentationStyle = .custom

           present(vc, animated: true, completion: { [unowned cell] in
               // Unfreeze
               cell.unfreezeAnimations()
           })
       }

}

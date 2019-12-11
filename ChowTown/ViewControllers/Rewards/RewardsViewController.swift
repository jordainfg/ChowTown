//
//  RewardsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 10/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit



class RewardsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    
    func setupCollectionView(){
        guard let collectionView = collectionView else { fatalError() }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: PointsCollectionViewCell.nibName(), bundle: nil), forCellWithReuseIdentifier: PointsCollectionViewCell.reuseIdentifier())
        collectionView.register(UINib.init(nibName: RewardsHeaderCollectionViewCell.nibName(), bundle: nil), forCellWithReuseIdentifier: RewardsHeaderCollectionViewCell.reuseIdentifier())
          collectionView.register(UINib.init(nibName: RewardCardCollectionViewCell.nibName(), bundle: nil), forCellWithReuseIdentifier: RewardCardCollectionViewCell.reuseIdentifier())
        
        collectionView.decelerationRate = .fast // uncomment if necessary
        
//        collectionView.contentInsetAdjustmentBehavior = .always
        // hide the scroll indicator
        collectionView.showsHorizontalScrollIndicator = false
         if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   flowLayout.estimatedItemSize = CGSize(width: 1,height: 1)
               }
        
    }
    
    
}
extension RewardsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.rewardsTableViewcellTypes[section].count
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return viewModel.rewardsTableViewcellTypes.count
    }
    
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = viewModel.rewardsTableViewcellTypes[indexPath.section][indexPath.row]
           switch type {
           case .header:
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardsHeaderCollectionViewCellID", for: indexPath) as! RewardsHeaderCollectionViewCell
                   return cell
           case .rewardPoints:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PointsCollectionViewCellID", for: indexPath) as! PointsCollectionViewCell
                  
                  return cell
        
           case .rewardCard:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardCardCollectionViewCellID", for: indexPath) as! RewardCardCollectionViewCell
                            
                            return cell
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //    //makes sure the first cell is centerd
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        let cellWidth : CGFloat = collectionView.frame.size.width / 1.8
    //
    //        let numberOfCells = floor(self.frame.size.width / cellWidth)
    //        let edgeInsets = (self.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
    //
    //
    //    return UIEdgeInsets(top: 15, left: edgeInsets, bottom: 0, right: edgeInsets)
    //    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//       let type = viewModel.rewardsTableViewcellTypes[indexPath.section][indexPath.row]
//        switch type {
//        case .header:
//            return CGSize(width: collectionView.frame.size.width , height: 200 )
//        case .rewardPoints:
//           return CGSize(width: collectionView.frame.size.width , height: 50)
//     
//        }
//
//    }
    
    
}

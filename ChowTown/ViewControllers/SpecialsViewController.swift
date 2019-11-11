//
//  SpecialsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 29/10/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import Hero
class SpecialsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedSpecial = 0
    let flowLayout = ZoomAndSnapFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "SpecialCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SpecialCollectionViewCellID")
        guard let collectionView = collectionView else { fatalError() }
        //collectionView.decelerationRate = .fast // uncomment if necessary
        
//       collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        // hide the scroll indicator
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
           UIApplication.shared.statusBarStyle = .darkContent
       }
    
    // MARK: - Prepare for Segues
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        switch segue.identifier {
        case "bla":
            let secondVC = segue.destination as! SpecialsDetailViewController
            secondVC.specialHeroID = selectedSpecial
            //        case "":
            //
            //        case "":
            //
            //
            //        case "":
            
        default:
            return
        }
    }
    
    
}
extension SpecialsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialCollectionViewCellID", for: indexPath) as! SpecialCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.coverImageView.hero.id = "specialHeroID\(indexPath.row)"
        cell.specialName.hero.id = "specialNameHeroID\(indexPath.row)"
        cell.specialDetail.hero.id = "specialDetailHeroID\(indexPath.row)"
        cell.cornerRadius = 15
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSpecial = indexPath.row
        performSegue(withIdentifier: "bla", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 1.8  , height: collectionView.frame.size.height  / 1.8
            
        )
    }
    
    
}

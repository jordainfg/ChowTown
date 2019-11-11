//
//  ChoiceMenuViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

enum ChoiceMenuTableViewDataType {
    case Choice
    case Header
    //case Drinks
}
class ChoiceMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var tableViewcellTypes: [[ChoiceMenuTableViewDataType]] {
        let types: [[ChoiceMenuTableViewDataType]] = [[.Header],[ .Choice,.Choice,.Choice,.Choice]]
           
           return types
       }
    override func viewDidLoad() {
        super.viewDidLoad()
setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
           tableView.register(UINib(nibName: ChoiceMenuTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: ChoiceMenuTableViewCell.reuseIdentifier())
                tableView.register(UINib(nibName: ChoiceMenuHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: ChoiceMenuHeaderTableViewCell.reuseIdentifier())
           tableView.showsHorizontalScrollIndicator = false
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ChoiceMenuViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        return tableViewcellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewcellTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
        case .Choice:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChoiceMenuTableViewCell.reuseIdentifier()) as! ChoiceMenuTableViewCell
            return cell
        
        case .Header:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChoiceMenuHeaderTableViewCell.reuseIdentifier()) as! ChoiceMenuHeaderTableViewCell
                     return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "toMenu", sender: nil)
    }
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
        case .Choice:
        return 90
      
        case .Header:
            return 450
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 42
//    }
//        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//             let headerCell = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderTableViewCellID") as! MenuHeaderTableViewCell
//            switch section {
//            case 0:
//                headerCell.name.text = "Best Seller"
//                headerCell.view.backgroundColor = UIColor.softBlue
//                headerCell.iCon.image = UIImage(named: "iCbestseller")
//              return headerCell.contentView
//            case 1:
//                headerCell.name.text = "Vegan"
//
//                return headerCell.contentView
//
//
//            default:
//                return headerCell.contentView
//            }
//        }
    
    //    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        switch section {
    ////        case 0:
    ////            return 44
    ////        case 1:
    ////            return 1
    ////        default:
    ////            return 0
    //        }
    //    }
    
    
    
    
    
    
}

//
//  ChoiceMenuViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit


class ChoiceMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    
    private let imageView = UIImageView(image: UIImage(named: "58428cc1a6515b1e0ad75ab1"))
    
    private struct Const {
        /// Image height/width for Large NavBar state
        static let ImageSizeForLargeState: CGFloat = 75
        /// Margin from right anchor of safe area to right anchor of Image
        static let ImageRightMargin: CGFloat = 16
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
        static let ImageBottomMarginForLargeState: CGFloat = 12
        /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
        static let ImageBottomMarginForSmallState: CGFloat = 6
        /// Image height/width for Small NavBar state
        static let ImageSizeForSmallState: CGFloat = 42
        /// Height of NavBar for Small state. Usually it's just 44
        static let NavBarHeightSmallState: CGFloat = 44
        /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
        static let NavBarHeightLargeState: CGFloat = 96.5
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Nav Bar Image resizing
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            //   navBarAppearance.configureWithOpaqueBackground()
            //            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            //            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            // navBarAppearance.backgroundColor = UIColor.white
            navBarAppearance.shadowImage = UIImage()
            navBarAppearance.shadowColor = UIColor.clear
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
        }
        title = "Menu"
        
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    private func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    func setUpView(){
        
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: MealCollectionTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MealCollectionTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: ChoiceMenuHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: ChoiceMenuHeaderTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: MenuSpecialsTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MenuSpecialsTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForTableViewSection.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForTableViewSection.reuseIdentifier())
        tableView.register(UINib(nibName: SubMenuTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SubMenuHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuHeaderTableViewCell.reuseIdentifier())
        tableView.showsHorizontalScrollIndicator = false
    }
    
    
}
extension ChoiceMenuViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.choiceMenuTableViewCellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.choiceMenuTableViewCellTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.choiceMenuTableViewCellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
        case let .MenuFood(subMenu):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuTableViewCell.reuseIdentifier()) as! SubMenuTableViewCell
            //            cell.choiceName.text = choice.title
            //            cell.choiceDetail.text = choice.detail
            return cell
            
        case let .MenuDrinks(subMenu):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuTableViewCell.reuseIdentifier()) as! SubMenuTableViewCell
            //            cell.choiceName.text = choice.title
            //            cell.choiceDetail.text = choice.detail
            return cell
            
        case .MenuSpecials:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuSpecialsTableViewCell.reuseIdentifier()) as! MenuSpecialsTableViewCell
            return cell
        case .MenuHeader(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuHeaderTableViewCell.reuseIdentifier()) as! SubMenuHeaderTableViewCell
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toMenu", sender: nil)
        
    }
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.choiceMenuTableViewCellTypes[indexPath.section][indexPath.row]
        switch type {
        case .MenuFood:
            return 200
            
        case .MenuSpecials:
            return 300
        case .MenuDrinks(_):
            return 200
        case .MenuHeader(_):
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Popular Eatries"
            return headerCell.contentView
        case 1:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Menus"
            return headerCell.contentView
        case 2:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Drinks"
            return headerCell.contentView
        default:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = ""
            return headerCell.contentView
        }
    }
    
    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImage(for: height)
    }
    
    
    
    
    
}

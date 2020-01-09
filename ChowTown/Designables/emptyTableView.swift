//
//  emptyTableView.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 09/01/2020.
//  Copyright © 2020 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class emptyTableView: UIView {
 
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        commonInit()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("emptyTableView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }

}

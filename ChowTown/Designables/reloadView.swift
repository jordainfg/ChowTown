//
//  reloadView.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 08/01/2020.
//  Copyright © 2020 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class reloadView: UIView {

    @IBOutlet var contetView: UIView!
    override init(frame: CGRect) {
        super.init(frame : frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("reloadView", owner: self, options: nil)
        addSubview(contetView)
        contetView.frame = self.bounds
        contetView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
}

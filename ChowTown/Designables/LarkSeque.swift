//
//  LarkSeque.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 16/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation
import SPLarkController

public class LarkSeque: UIStoryboardSegue {
    
    public var transitioningDelegate: SPLarkTransitioningDelegate?
    
    override public func perform() {
        transitioningDelegate = transitioningDelegate ?? SPLarkTransitioningDelegate()
        transitioningDelegate?.customHeight = UIScreen.main.bounds.height / 2
        destination.transitioningDelegate = transitioningDelegate
        destination.modalPresentationStyle = .custom
        super.perform()
    }
}

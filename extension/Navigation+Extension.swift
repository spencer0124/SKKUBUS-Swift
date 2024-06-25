//
//  Navigation+Extension.swift
//  skkumap
//
//  Created by 조승용 on 6/25/24.
//

import Foundation
import UIKit

// extension for swipe-back gesture 
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return AppState.shared.swipeEnabled ?
                         viewControllers.count > 1 : false // << here !!
    }
}

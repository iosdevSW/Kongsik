//
//  CGFloat+.swift
//  Kongsik
//
//  Created by iOS신상우 on 3/24/24.
//

import UIKit.UIApplication

public extension CGFloat {
    
    static var halfScreenHeight: CGFloat {
        (UIApplication.shared.screenSize?.height ?? .zero) / 2
    }
    
    static var screenWidth: CGFloat {
        UIApplication.shared.screenSize?.width ?? .zero
    }
}


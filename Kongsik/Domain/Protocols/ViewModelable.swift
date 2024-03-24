//
//  ViewModelable.swift
//  Kongsik
//
//  Created by iOS신상우 on 3/24/24.
//

import Foundation
import Combine

protocol ViewModelable: ObservableObject {
    associatedtype Action

    func reduce(_ action: Action)
}

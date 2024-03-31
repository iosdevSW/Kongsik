//
//  KongjuRice.swift
//  KongjuRice
//
//  Created by iOS신상우 on 3/24/24.
//

import SwiftUI

@main
struct KongjuRice: App {
    
    init() {
        configurePageControl()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
    }
    
    private func configurePageControl() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.main
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.5)
    }
}

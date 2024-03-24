//
//  KongsikApp.swift
//  Kongsik
//
//  Created by iOS신상우 on 3/24/24.
//

import SwiftUI

@main
struct KongsikApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
    }
}

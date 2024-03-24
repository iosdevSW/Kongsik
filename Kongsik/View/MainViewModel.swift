//
//  MainViewModel.swift
//  Kongsik
//
//  Created by iOS신상우 on 3/24/24.
//

import Foundation

class MainViewModel: ViewModelable {
    private let soupManager = SwiftSoupManager()
    
    @Published var menus: [MealMenu] = []
    
    
    enum Action {
        case fetchMenu
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .fetchMenu:
            Task {
                do {
                    let menus = try await soupManager.fetchMealInfo(restaurant: .cheonanDormitory) // 임시
                    
                    DispatchQueue.main.async {
                        self.menus = menus
                    }
                } catch {
                    print(error) // TODO: Error 처리
                }
            }
        }
    }
}

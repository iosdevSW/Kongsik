//
//  MainViewModel.swift
//  KongjuRice
//
//  Created by iOS신상우 on 3/24/24.
//

import Foundation
import Combine

class MainViewModel: ViewModelable {
    private var cancellable = Set<AnyCancellable>()
    private let soupManager = SwiftSoupManager.shared
    
    @Published var menus: [MealMenu] = []
    
    @Published var isLoading = false
    @Published var selectedRestaurant: Restaurant?
    
    init() {
        let restaurantCode = UserDefaults.standard.string(forKey: KSKey.selectedRestaurant.rawValue)
        self.selectedRestaurant = Restaurant(rawValue: restaurantCode ?? "")
        
        $selectedRestaurant
            .compactMap { $0 }
            .sink { [weak self] restaurant in
                guard let self else { return }
                Task {
                    UserDefaults.standard.set(restaurant.rawValue, forKey: KSKey.selectedRestaurant.rawValue)
                    await self.reduce(.fetchMenu(restaurant))
                }
                
            }.store(in: &cancellable)
    }
    
    enum Action {
        case fetchMenu(Restaurant)
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .fetchMenu(let restaurant):
            Task(priority: .background) {
                do {
                    self.isLoading = true
                    
                    let menus = try await soupManager.fetchMealInfo(restaurant: restaurant) // 임시
                    
                    DispatchQueue.main.async() {
                        self.menus = menus
                        self.isLoading = false
                    }
                } catch {
                    self.isLoading = false
                    print(error) // TODO: Error 처리
                }
            }
        }
    }
}

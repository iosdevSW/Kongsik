//
//  SwiftSoupManager.swift
//  Kongsik
//
//  Created by iOS신상우 on 3/24/24.
//

import Foundation
import SwiftSoup

class SwiftSoupManager {
    static let shared = SwiftSoupManager()
    
    private init() { }
    
    func fetchMealInfo(restaurant: Restaurant) async throws -> [MealMenu] {
        if restaurant.isDormitory {
            return try await fetchDormitoryMealInfo(restaurant)
        } else {
            return try await fetchKongjuMealInfo(restaurant)
        }
    }
    
    // 학식, 직원식당
    private func fetchKongjuMealInfo(_ restaurant: Restaurant) async throws -> [MealMenu] {
        let urlString = Destination.dormitory(code: restaurant.rawValue).url
        let result: [MealMenu] = []
        
        guard let url = URL(string: urlString) else {
            return [] // TODO: 에러처리
        }
        
        // TODO: 학생 식당
        return result
    }
    
    // 기숙사
    private func fetchDormitoryMealInfo(_ restaurant: Restaurant) async throws -> [MealMenu] {
        let urlString = Destination.dormitory(code: restaurant.rawValue).url
        var result: [MealMenu] = []
        
        guard let url = URL(string: urlString) else {
            return [] // TODO: 에러처리
        }
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let document: Document = try SwiftSoup.parse(html)
            
            let foodInfo = try document
                .select("div#mqLayout")
                .select("div#mqSubCont")
                .select("div#mqCont_box")
                .select("div#mqCont")
                .select("div#food-info")
                .select("div.food-info-box")
            
            //                let title = try foodInfo
            //                    .select("p.food-head")
            //                    .select("span.head-cont").text()
            //
            let body = try foodInfo
                .select("table.table-board")
                .select("tbody")
            
            let datas = try body.select("tr").array()
            
            for data in datas {
                let infos = try data.select("td").array()
                let newMeal = MealMenu(dayType: "",
                                       breakfast: [],
                                       lunch: [],
                                       diner: [],
                                       date: "")
                for (index, info) in infos.enumerated() {
                    
                    if index == 0 {
                        newMeal.dayType = try info.text()
                    }
                    
                    if index == 1 {
                        newMeal.date = try info.text()
                    }
                    
                    if index == 2 {
                        newMeal.breakfast = try info.text().split(separator: " ").map { String($0) }.filter { !$0.isEmpty }
                    }
                    
                    if index == 3 {
                        newMeal.lunch = try info.text().split(separator: " ").map { String($0) }.filter { !$0.isEmpty }
                    }
                    
                    if index == 4 {
                        newMeal.diner = try info.text().split(separator: " ").map { String($0) }.filter { !$0.isEmpty }
                    }
                }
                
                result.append(newMeal)
            }
            
            return result
        } catch {
            print(error)
            return [] // TODO: 에러처리
        }
    }
}

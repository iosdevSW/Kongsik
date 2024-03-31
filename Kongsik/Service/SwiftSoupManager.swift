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
    
    // 학식, 직원식당 - 홈페이지 SSL 버전이 낮아서 도메인 ATS설정 따로 해줬음
        
    private func fetchKongjuMealInfo(_ restaurant: Restaurant) async throws -> [MealMenu] {
        let urlString = Destination.kongju(code: restaurant.rawValue).url
        var menus: [MealMenu] = []
        
        guard let url = URL(string: urlString) else {
            return [] // TODO: 에러처리
        }
        
        let html = try String(contentsOf: url, encoding: .utf8)
        let document: Document = try SwiftSoup.parse(html)
        
        let base = try document
            .select("div.wrap-contents")
            .select("div.container")
            .select("div.contents")
            .select("div#contentsEditHtml")
            .select("article#_contentBuilder")
            .select("div._objWidget")
            .select("div#_JW_diet_basic")
            .select("div.diet-menu")
            .select("form#viewForm")
            .select("div.diet-table")
            .select("table._fnTable")
            
        let body = try base.select("tbody")
        
        let header = try base.select("thead")
            
        let table = try body.select("tr").array()
        
        // date
        var heads = try header.select("th").array()
        heads.removeFirst()
        
        for (index, head) in heads.enumerated() {
            var dateComponent = try head.select("span").text().components(separatedBy: ".")
            var dayType = try head.select("p").text()
            
            // span, p로 안나누어진 경우 처리
            if dayType.isEmpty {
                let component = try head.text().components(separatedBy: " ")
                dateComponent = component.first?.components(separatedBy: ".") ?? []
                dayType = component.filter { $0.first?.isLetter == true }.first ?? ""
            }
            
            menus.append(.init())
            
            if dateComponent.count > 2 {
                let date = "\(dateComponent[1])월 \(dateComponent[2])일"
                
                menus[index].date = date
                menus[index].dayType = dayType.filter { $0.isLetter }
            } else {
                menus[index].date = "날짜 로딩 실패"
            }
        }
        
        // lunch
        if let lunchMenu = table.first {
            let lunchFoods = try lunchMenu.select("td").array()
            
            for (index, lunchFood) in lunchFoods.enumerated() {
                menus[index].lunch = try lunchFood.text().split(separator: " ").map { String($0) }.filter { !$0.isEmpty }
            }
        }
        
        // diner
        if let dinerMenu = table.first {
            let dinerFoods = try dinerMenu.select("td").array()
            
            for (index, dinerFood) in dinerFoods.enumerated() {
                menus[index].diner = try dinerFood.text().split(separator: " ").map { String($0) }.filter { !$0.isEmpty }
            }
        }
        
        // TODO: 학생 식당
        return menus
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
            
            let base = try document
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
            let body = try base
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

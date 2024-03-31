//
//  MealMenu.swift
//  KongjuRice
//
//  Created by iOS신상우 on 3/24/24.
//

import Foundation

class MealMenu: Codable {
    var dayType: String
    var breakfast: [String]
    var lunch: [String]
    var diner: [String]
    var date: String
    
    init(dayType: String, breakfast: [String], lunch: [String], diner: [String], date: String) {
        self.dayType = dayType
        self.breakfast = breakfast
        self.lunch = lunch
        self.diner = diner
        self.date = date
    }
    
    init() {
        self.dayType = ""
        self.breakfast = []
        self.lunch = []
        self.diner = []
        self.date = ""
    }
}

//
//  Restaurant.swift
//  KongjuRice
//
//  Created by iOS신상우 on 3/24/24.
//

import Foundation

enum Restaurant: String, CaseIterable {
    // 생활관
    case visionDormitory = "041301"
    case dreamDormitory = "041302"
    case cheonanDormitory = "041303"
    case yesanDormitory = "041304"
    
    // 학식
    case sodam = "13155"
    case nuelsom = "13156"
    case cheonanStudent = "13157"
    case cheonanEmploy = "13158"
    case yesanStudent = "13159"
    case yesanEmploy = "13160"
    
    var isDormitory: Bool {
        [Self.cheonanDormitory,
         Self.dreamDormitory,
         Self.visionDormitory,
         Self.yesanDormitory].contains(self)
    }
    
    var title: String {
        switch self {
        case .visionDormitory:
            "비전"
        case .dreamDormitory:
            "드림"
        case .cheonanDormitory:
            "천안 기숙사"
        case .yesanDormitory:
            "예산 기숙사"
        case .sodam:
            "소담"
        case .nuelsom:
            "늘솜"
        case .cheonanStudent:
            "천안학생식당"
        case .cheonanEmploy:
            "천안직원식당"
        case .yesanStudent:
            "예산학생식당"
        case .yesanEmploy:
            "예산직원식당"
        }
    }
}


/* 생활관 링크
 은행사,비전 https://dormi.kongju.ac.kr/HOME/sub.php?code=041301
 드림 https://dormi.kongju.ac.kr/HOME/sub.php?code=041302
 천안 https://dormi.kongju.ac.kr/HOME/sub.php?code=041303
 예산 https://dormi.kongju.ac.kr/HOME/sub.php?code=041304
 
 
 요런식으로 콜하네잉
 https://dormi.kongju.ac.kr/HOME/sub.php?code=041304&currentYear=2024&currentMonth=04&currentWeekNo=1&currentWeekStart=20240331&currentWeekEnd=20240406
 */
 
/*
 학식 링크
 신관 소담 https://www.kongju.ac.kr/kongju/13155/subview.do
 신관 늘솜 https://www.kongju.ac.kr/kongju/13156/subview.do
 
 천안 직원 https://www.kongju.ac.kr/kongju/13158/subview.do
 천안 학생 https://www.kongju.ac.kr/kongju/13157/subview.do
 천안 생활관 https://www.kongju.ac.kr/kongju/13163/subview.do
 
 예산 학생 https://www.kongju.ac.kr/kongju/13159/subview.do
 예산 직원 https://www.kongju.ac.kr/kongju/13160/subview.do
 
 요런식으로 콜
 https://www.kongju.ac.kr/kongju/13156/subview.do?enc=Zm5jdDF8QEB8JTJGZGlldCUyRmtvbmdqdSUyRjUlMkZ2aWV3LmRvJTNGbW9uZGF5JTNEMjAyNC4wMy4yNSUyNndlZWslM0RuZXh0JTI2
 */

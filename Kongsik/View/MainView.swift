//
//  MainView.swift
//  Kongsik
//
//  Created by iOS신상우 on 3/24/24.
//

import SwiftUI
import SwiftSoup

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                setScrollView()
            }
            .task {
                viewModel.reduce(.fetchMenu)
            }
            .toolbar {
                Button {
                    print("tap!")
                } label: {
                    Image.init(systemName: "gear")
                        .tint(.main)
                }
            }
            .background(Color.background)
        }
    }
    
    @ViewBuilder
    func setScrollView() -> some View {
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 32) {
                    ForEach(Array(viewModel.menus), id: \.date) { menuInfo in
                        setContent(menu: menuInfo, width: proxy.size.width - 32)
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.never)
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
        }
    }
    
    @ViewBuilder
    func setContent(menu: MealMenu, width: CGFloat) -> some View {
        VStack {
            Text("\(menu.date) (\(menu.dayType))")
                .font(.title)
                .padding()
            ScrollView {
                VStack(spacing: 20) {
                    
                    setMenuCell(title: "아침",
                                foods: menu.breakfast)
                    
                    setMenuCell(title: "점심",
                                foods: menu.lunch)
                    
                    setMenuCell(title: "저녁",
                                foods: menu.diner)
                    
                    Spacer()
                }
                .frame(width: width)
            }
        }
    }
    
    @ViewBuilder
    func setMenuCell(title: String, foods: [String]) -> some View {
        VStack {
            Text(title)
                .font(.title2)
            
            if foods.isEmpty {
                Text("식단 정보가 없습니다")
                    .font(.body)
                    .padding()
            } else {
                VStack {
                    ForEach(Array(foods.enumerated()), id: \.offset) { _, food in
                        Text(food)
                    }
                }
                .padding()
            }
        }
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}

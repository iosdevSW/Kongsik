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
                setToolbar()
                if let _ = viewModel.selectedRestaurant {
                    setScrollView()
                } else {
                    VStack {
                        Spacer()
                        Text("상단을 탭하여 원하는 식당을 선택해주세요")
                            .font(.body)
                            .foregroundStyle(Color.gray)
                        Spacer()
                    }
                }
                
            }
            .background(Color.background)
            .isLoading(viewModel.isLoading)
        }
    }
    
    @ViewBuilder
    func setScrollView() -> some View {
        GeometryReader { reader in
            let w = reader.size.width
            let h = reader.size.height
            
            TabView {
                ForEach(Array(viewModel.menus), id: \.date) { menuInfo in
                    self.setContent(menu: menuInfo)
                        .frame(width: w-32)
                }
            }
            .tabViewStyle(.page)
            .frame(width: w, height: h)
        }
    }
    
    @ViewBuilder
    func setContent(menu: MealMenu) -> some View {
        
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
                Section {
                    setMenuCell(title: "아침",
                                foods: menu.breakfast)
                    
                    setMenuCell(title: "점심",
                                foods: menu.lunch)
                    
                    setMenuCell(title: "저녁",
                                foods: menu.diner)
                    
                    Spacer()
                } header: {
                    HStack(alignment: .center, content: {
                        Text("\(menu.date) (\(menu.dayType))")
                            .font(.title2)
                            .padding()
                            .foregroundStyle(Color.black)
                    })
                }
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
        .foregroundStyle(Color.black)
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 12))
    }
    
    @ViewBuilder
    func setToolbar() -> some View {
        HStack {
            Spacer()
            
            NavigationLink(value: MainFlow.setting,
                           label: {
                Image.init(systemName: "gearshape")
                    .tint(.main)
            })
        }
        .padding(16)
        .frame(width: .screenWidth)
        .navigationDestination(for: MainFlow.self, destination: { _ in
            SettingView()
        })
        .overlay {
            Menu {
                ForEach(Restaurant.allCases, id: \.rawValue) { restaurant in
                    Button {
                        viewModel.selectedRestaurant = restaurant
                    } label: {
                        Text(restaurant.title)
                    }
                }
            } label: {
                HStack(spacing: 8) {
                    Image.init(systemName: "location.circle")
                    
                    Text(viewModel.selectedRestaurant?.title ?? "식당 선택")
                        .font(.title3)
                        .foregroundStyle(Color.black)
                        .lineLimit(1)
                }
            }
        }
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}

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
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(viewModel.menus), id: \.date) { info in
                        VStack {
                            HStack {
                                Text(info.date)
                                Text("(\(info.dayType))")
                            }
                            .font(.title2)
                            
                            ForEach(0..<info.lunch.count) { i in
                                Text(info.lunch[i])
                            }
                        }
                        .frame(minWidth: .screenWidth - 16)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 8)
                    }
                }
            }
        }
        .task {
            viewModel.reduce(.fetchMenu)
        }
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}

//
//  SettingView.swift
//  KongjuRice
//
//  Created by iOS신상우 on 3/31/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        setList()
            .navigationTitle("설정")
    }
    
    @ViewBuilder
    func setList() -> some View {
        List {
            Button {
                Utils.openExternalLink(urlStr: "https://forms.gle/BA7DTykeEQLSqVnW8")
            } label: {
                HStack {
                    Text("기능 및 버그문의")
                        .foregroundStyle(Color.black)
                    Spacer()
                    Image.init(systemName: "chevron.right")
                        .tint(Color.gray)
                }
            }
            
            HStack {
                Text("도움을 준 사람들")
                    .foregroundStyle(Color.black)
                Spacer()
                Text("장차곡🎨\n이코차👍")
                    .foregroundStyle(Color.gray)
            }
                
            HStack {
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                Text("버전")
                    .foregroundStyle(Color.black)
                Spacer()
                Text(version)
                    .foregroundStyle(Color.gray)
            }
            
        }
        .foregroundStyle(Color.black)
    }
}

#Preview {
    SettingView()
}

//
//  View+.swift
//  Kongsik
//
//  Created by iOS신상우 on 3/28/24.
//

import SwiftUI

extension View {
    @ViewBuilder func isLoading(_ state: Bool) -> some View {
        self
            .overlay {
                if state {
                    ProgressView()
                        .tint(Color.main)
                        .scaleEffect(1.6)
                }
            }
    }
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}

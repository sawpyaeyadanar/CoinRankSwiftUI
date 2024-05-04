//
//  RankHeaderView.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import SwiftUI

struct RankHeaderView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
                Text("Top 3 rank crypto")
                .foregroundColor(Color("LFont1"))
                .font(.custom("Roboto-Medium", size: 16.0))
                .padding(.leading, 16)
            HStack(spacing: 8) {
                    List {
                        HStack {
                            RankListRow()
                            RankListRow()
                            RankListRow()
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listStyle(.plain)
                }
           
        }
        //.scrollDisabled(true)
        .frame(height: 205)
        
    }
}

#Preview {
    RankHeaderView()
}
struct RankListRow: View {
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(12)
            EmptyView()
           // RandHeaderCellView()
        }
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color(red: 0, green: 0, blue: 0).opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

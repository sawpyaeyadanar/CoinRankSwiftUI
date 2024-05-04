//
//  RandHeaderCellView.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import SwiftUI

struct RankHeaderCellView: View {
    let coin: Coins
    @State private var isPresented: Bool = false
    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                CoinImageView(coin: coin)
                    .frame(width: 40,height: 40)
                    .padding(EdgeInsets(top: 16, leading: 35, bottom: 8, trailing: 35))
                Text(coin.symbol.uppercased())
                    .foregroundColor(Color("LFont1"))
                    .font(.custom("Roboto-Bold", size: 16.0))
                Text(coin.name)
                    .foregroundColor(Color("LFont2"))
                    .font(.custom("Roboto-Regular", size: 14.0))
                HStack(alignment: .center) {
                    Image(coin.changeStatus ? "arrow_green" : "arrow_red")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                        .padding(.top , 5)
                    Text(coin.positiveChange)
                        .foregroundColor( coin.changeStatus ? Color("LFont3") : Color("LFont4"))
                        .font(.custom("Roboto-Bold", size: 12.0))
                    .padding(.top, 9)
                }
                .padding(.bottom, 8)
            }
        }
        .onTapGesture {
            isPresented.toggle()
        }
        .popover(isPresented: $isPresented, content: {
            //CoinDetailsView2(isPresented: $isPresented)
            CoinDetailsView(viewModel: CoinDetailsViewModel(coin: coin), isPresented: $isPresented)
        })
        .frame(height: 180)
        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0, bottomRight: 8.0)
            .fill(Color.listTheme.background)
                    )
        .shadow(color: Color.listTheme.shadow, radius: 2, x: 0, y: 2)
    }
}

/*
#Preview {
    HStack {
        RandHeaderCellView()
        RandHeaderCellView()
        RandHeaderCellView()
    }
    
}
*/

//
//  MainView.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel : MainViewModel
    
    var body: some View {
        coinList
    }
}

extension MainView {
    private var coinList: some View {
        // NavigationStack {
       // ScrollView {
        VStack(alignment: .leading) {
           // RankHeaderCellView()
            
            Text("Buy, sell and hold crypto")
                .font(.custom("Roboto-Bold", size: 16.0))
                .foregroundColor(Color(red:0, green: 0,blue: 0, opacity: 1.0))
                .padding(.leading, 16)
                .padding(.bottom, 12)
            /*
            List {
                
                ForEach(viewModel.coins) { item in
                    
                    CoinListRow()
                        .listRowInsets(.init(top: 0, leading: 8, bottom: 12, trailing: 10))
                        .listRowSeparator(.hidden)
                        .edgesIgnoringSafeArea(.all)
                }
                
                ReferView()
                    .listRowInsets(.init(top: 0, leading: 8, bottom: 12, trailing: 10))
                    .listRowSeparator(.hidden)
                
                
            }
            .listStyle(.plain)
            */
            ScrollView {
                VStack {
                    
                    ForEach(viewModel.coins) { item in
                        
                        CoinListRow()
                            .listRowInsets(.init(top: 0, leading: 8, bottom: 12, trailing: 10))
                            .listRowSeparator(.hidden)
                            .edgesIgnoringSafeArea(.all)
                    }
                    
                    ReferView()
                        .listRowInsets(.init(top: 0, leading: 8, bottom: 12, trailing: 10))
                        .listRowSeparator(.hidden)
                    
                    
                }
                
            }
            Spacer()
        }
    //}  //scrollView
        .onAppear(perform: {
            viewModel.getCoinsList()
        })
    }
}

struct CoinListRow: View {
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(12)
            //CardContentView(coin: <#Coins#>)
        }
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: Color(red: 0, green: 0, blue: 0).opacity(0.1), radius: 4, x: 0, y: 2)
    }
}




#Preview {
    ReferView()
   // MainView(viewModel: MainViewModel(coinListService: CoinListService(coin: <#T##Coins#>)))
}

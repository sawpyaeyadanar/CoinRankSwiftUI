//
//  HomeView.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject var viewModel : HomeViewModel
    @State private var search: String = ""
    @State private var showDetails: Bool = false
    private let debounceTime = 1
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .center ) {
                            
                            searchBarView
                                .padding(.top, 20)
                            
                            Divider()
                            
                            if viewModel.searchCoin.isEmpty && !viewModel.coins.isEmpty && viewModel.isSearching {
                                EmptySearchView()
                                    .position(x: geo.size.width / 2, y: geo.size.height / 3)
                            } else {
                                if !viewModel.topCoins.isEmpty  {
                                    if !viewModel.isSearching {
                                        topRankView
                                    }
                                }
                                if viewModel.isFetching {
                                    ProgressView()
                                }
                                buySellList
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                    }  //scrollview
                } //vstack
                .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                .background(Color.white)
                .padding(.vertical, 30)
                
            } // Vstack
            .ignoresSafeArea()
            .refreshable(action: {
                viewModel.getCoinsList()
            })
        } //GeometryReader
    }
    
    private var searchBarView:  some View {
        HStack {
            Spacer()
            Image("icon_search")
                .resizable()
                .frame(width: 24, height: 24)
                .scaledToFit()
                .clipped()
                .padding(12)
            
            TextField("Search", text: $search)
                .onReceive(Just(search) .throttle(for: .seconds(debounceTime), scheduler: DispatchQueue.main, latest: true), perform: { newValue in
                    if newValue.isEmpty {
                        viewModel.finishSearch()
                    }
                    if newValue.count > 2 {
                        print("get new value \(newValue)")
                        self.viewModel.getSearchList(text: newValue)
                    }
                })
        } //Hstack
        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                   bottomRight: 8.0)
            .fill(Color.listTheme.search))
        .padding(16)
    }
    
    private var topRankView: some View {
        VStack(alignment: .leading, spacing: 0) {
            topRankingTitleView
                .padding(.vertical, 16)
            HStack(spacing: 8) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.topCoins) { coin in
                            RankHeaderCellView(coin: coin)
                                .padding(.horizontal, 5)
                        } //ForEach
                    } //LazyHStack
                } //ScrollView
            } //HStack
        }// VStack
        .padding(.horizontal, 16)
    }
    
    private var topRankingTitleView: some View {
        HStack {
            Text("Top")
                .font(.custom("Roboto-Bold", size: 16))
                .foregroundColor(Color.lFont1)
            
            Text("3")
                .font(.custom("Roboto-Bold", size: 18))
                .foregroundColor(Color.lFont5)
            
            Text("rank crypto")
                .font(.custom("Roboto-Medium", size: 16))
                .foregroundColor(Color.lFont1)
        } //HStack
    }
    
    private var buySellList: some View {
        VStack(alignment: .leading) {
            Text("Buy, sell and hold crypto")
                .font(.custom("Roboto-Bold", size: 16.0))
                .foregroundColor(Color(red:0, green: 0,blue: 0, opacity: 1.0))
                .padding(.leading, 16)
                .padding(.bottom, 12)
            
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        if viewModel.isSearching {
                            ForEach(Array(viewModel.searchCoin.enumerated()), id: \.element) { index, coin in
                                if viewModel.specialIndices.contains(index) {
                                    ReferView()
                                } else {
                                    CoinCellView(coin: coin)
                                }
                            } //foreach
                        } else {
                            ForEach(Array(viewModel.coins.enumerated()), id: \.element) { index, coin in
                                if viewModel.specialIndices.contains(index) {
                                    ReferView()
                                } else {
                                    CoinCellView(coin: coin)
                                }
                            } //foreach
                        }
                        
                    } //lazyVstack
                    .padding(.horizontal,8)
                } //scrollview
            }
        }
        .padding(.top, 20)
    }
}

struct CoinCellView: View {
    let coin: Coin
    @State var isPresented = false
    var body: some View {
        HStack(spacing: 0) {
            CoinImageView(coin: coin)
                .frame(width: 40, height: 40)
                .padding(.horizontal, 16)
            titleView
            Spacer()
            rightView
        } //HStack
        .popover(isPresented: $isPresented, content: {
            CoinDetailsView(viewModel: CoinDetailsViewModel(coin: coin), isPresented: $isPresented)
        })
        .frame(height: 82)
        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0, bottomRight: 8.0)
            .fill(Color.listTheme.background)
        )
        .shadow(color: Color.listTheme.shadow, radius: 2, x: 0, y: 2)
        .onTapGesture {
            isPresented.toggle()
        }
        
    }
    
    private var titleView: some View {
        VStack(alignment: .leading) {
            Text(coin.name)
                .lineLimit(1)
                .foregroundColor(Color("LFont1"))
                .font(.custom("Roboto-Bold", size: 16.0))
                .padding(.top, 21)
                .padding(.bottom, 6)
            Text(coin.symbol.uppercased())
                .foregroundColor(Color("LFont2"))
                .font(.custom("Roboto-Bold", size: 14.0))
                .padding(.bottom,20)
        } //VStack
    }
    
    private var rightView: some View {
        VStack(alignment: .trailing) {
            Text(coin.price.asCurrencyWith5Decimals())
                .foregroundColor(Color("LFont1"))
                .font(.custom("Roboto-Bold", size: 12.0))
            HStack(alignment: .center) {
                Image(coin.changeStatus ? "arrow_green" : "arrow_red")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                    .padding(.top , 6)
                Text(coin.positiveChange)
                    .foregroundColor( coin.changeStatus ? Color("LFont3") : Color("LFont4"))
                    .font(.custom("Roboto-Bold", size: 12.0))
                    .padding(.top, 9)
            } //HStack
        } //VStack
        .padding(.trailing, 16)
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct ReferView : View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.referBackground)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            HStack {
                VStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 1)
                            .background(Circle().foregroundColor(Color.white))
                        Image("Refer")
                            .frame(width: 22, height: 22)
                            .padding(9)
                    }
                    .padding()
                    .frame(width: 40, height: 40)
                    
                } //VStack
                .padding(EdgeInsets(top: 21, leading: 16, bottom: 21, trailing: 0))
                
                Text(labeledAttributedString)
                    .onTapGesture {
                        share()
                    }
                    //.multilineTextAlignment(.leading)
                    .padding(.horizontal, 16)
            } //HStack
        } //ZStack
    }
    
    private let labeledAttributedString: AttributedString = {
        var label = AttributedString("You can earn $10 when you invite a friend to buy crypto.")
        label.font = Font.custom("Roboto-Regular", size: 16)
        
        var invite = AttributedString("Invite your friend")
        invite.font = Font.custom("Roboto-Bold", size: 16)
        invite.foregroundColor = Color.dFont1
        return label + invite
    }()
    
    private func share() {
        guard let url = URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fapps.apple.com%2Fth%2Fapp%2Fline-man-food-delivery-more%2Fid1076238296&psig=AOvVaw0d6RX29N1ZWF916BNq1IZ5&ust=1714925111897000&source=images&cd=vfe&opi=89978449&ved=0CAcQrpoMahcKEwi4prGpsPSFAxUAAAAAHQAAAAAQEQ") else { return }
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        if let window = UIApplication.shared.windows.first {
            window.rootViewController?.present(activityController, animated: true, completion: nil)
        }
    }
}



struct EmptySearchView: View {
    var body: some View {
        VStack(alignment: .center) {
            
            Text("Sorry")
                .font(.custom("Roboto-Bold", size: 20.0))
                .foregroundColor(Color.listTheme.font1)
                .padding(.bottom, 12)
            
            Text("No result match this keyword")
                .font(.custom("Roboto-Regular", size: 16.0))
                .foregroundColor(Color.listTheme.font2)
            
        } //VStack
    }
}

#Preview {
    ReferView()
    //HomeView(viewModel: HomeViewModel(coinListService: CoinListService()))
}

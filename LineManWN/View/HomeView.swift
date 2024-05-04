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
                        VStack(alignment: .center ) { ///
                            
                            searchBarView
                                .padding(.top, 20)
                            
                            Divider()
                            /*
                             //.frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(1.0), alignment: .center)
                             //.background(ColorConstants.Gray200)
                             //.padding(.top, getRelativeHeight(16.0))
                             */
                            
                            
                            if viewModel.searchCoin.isEmpty && !viewModel.coins.isEmpty && viewModel.isSearching {
                                
                                EmptySearchView()
                                    .position(x: geo.size.width / 2, y: geo.size.height / 3)
                            } else {
                                if !viewModel.topCoins.isEmpty  {
                                    if !viewModel.isSearching {
                                        topRankView
                                    }
                                    
                                }
                                /*
                                 //.frame(width: UIScreen.main.bounds.width, height: getRelativeHeight(170.0), alignment: .center)
                                 //.padding(.top, getRelativeHeight(18.0))
                                 */
                                
                                buySellList
                            }
                            
                            
                        }
                        .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                    }  //scrollview
                }
                .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                .background(Color.white)
                .padding(.top, 30)
                .padding(.bottom, 30)
                //.padding(.top, getRelativeHeight(30.0))
                //.padding(.bottom, getRelativeHeight(10.0))
                
            } // Vstack
           // .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            .refreshable(action: {
                viewModel.getCoinsList()
            })
            .onAppear(perform: {
                // viewModel.getCoinsList()
                
        })
        }
        
        //.hideNavigationBar()
    }
    
    private var searchBarView:  some View {
        
        HStack {
            Spacer()
            Image("icon_search")
                .resizable()
                .frame(width: 24, height: 24)
            //.frame(width: getRelativeWidth(24.0), height: getRelativeWidth(24.0), alignment: .center)
                .scaledToFit()
                .clipped()
                .padding(12)
            //.padding(.all, getRelativeWidth(12.0))
            // .padding(.vertical, getRelativeHeight(12.0))
            // .padding(.horizontal, getRelativeWidth(12.0))
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
            //.font(FontScheme.kRobotoRegular(size: getRelativeHeight(14.0)))
            // .foregroundColor(ColorConstants.Gray500)
            //.padding()
        }
        // .frame(width: getRelativeWidth(343.0), height: getRelativeHeight(48.0),alignment: .center)
        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                   bottomRight: 8.0)
            .fill(Color.listTheme.search))
        .padding(16)
//        .onChange(of: search, perform: { value in
//            viewModel.getSearchList(text: value)
//            print("onchange")
//        })
        //.padding(.horizontal, getRelativeWidth(16.0))
        
    }
    
    private var topRankView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Top 3 rank crypto")
                .foregroundColor(Color("LFont1"))
                .font(.custom("Roboto-Medium", size: 16.0))
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.leading)
            //.frame(width: getRelativeWidth(126.0), height: getRelativeHeight(19.0), alignment: .topLeading)
                .padding(.vertical, 16)
            
            HStack(spacing: 8) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.topCoins) { coin in
                            RankHeaderCellView(coin: coin)
                                .padding(.horizontal, 5)
                        }
                    }
                }
            }
            //.frame(width: getRelativeWidth(346.0), alignment: .leading)
            //.padding(.top, getRelativeHeight(11.0))
        }// VStack
        .padding(.horizontal, 16)
    }
    
    private var buySellList: some View {
        VStack(alignment: .leading) {
            Text("Buy, sell and hold crypto")
                .font(.custom("Roboto-Bold", size: 16.0))
                .foregroundColor(Color(red:0, green: 0,blue: 0, opacity: 1.0))
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.leading)
                .padding(.leading, 16)
                .padding(.bottom, 12)
            //.frame(width: getRelativeWidth(175.0), height: getRelativeHeight(19.0),alignment: .topLeading)
            //.padding(.top, getRelativeHeight(23.0))
            // .padding(.leading, getRelativeWidth(16.0))
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        if viewModel.isSearching {
                            ForEach(Array(viewModel.searchCoin.enumerated()), id: \.element) { index, coin in
                                if viewModel.specialIndices.contains(index) {
                                    ReferView()
                                } else {
                                    CardContentView(coin: coin)
                                }
                            } //foreach
                        } else {
                            ForEach(Array(viewModel.coins.enumerated()), id: \.element) { index, coin in
                                if viewModel.specialIndices.contains(index) {
                                    ReferView()
                                } else {
                                    CardContentView(coin: coin)
                                }
                            } //foreach
                        }

                    } //lazyVstack
                    .padding(.horizontal,8)
                } //scrollview
            }
            //.frame(width: getRelativeWidth(359.0), alignment: .center)
            //.padding(.top, getRelativeHeight(10.0))
            //.padding(.horizontal, getRelativeWidth(8.0))
        }
        .padding(.top, 20)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(coinListService: CoinListService()))
}

struct CardContentView: View {
    let coin: Coins
    @State var isPresented = false
    var body: some View {
        HStack(spacing: 0) {
            CoinImageView(coin: coin)
                .frame(width: 40, height: 40)
                .padding(.horizontal, 16)
            titleView
            Spacer()
            rightView
        }
        .onTapGesture {
            isPresented.toggle()
        }
        
        .popover(isPresented: $isPresented, content: {
            CoinDetailsView(viewModel: CoinDetailsViewModel(coin: coin), isPresented: $isPresented)
        })
        //.background(Color.listTheme.background)
        .frame(height: 82)
        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0, bottomRight: 8.0)
            .fill(Color.listTheme.background)
                    )
        .shadow(color: Color.listTheme.shadow, radius: 2, x: 0, y: 2)
    
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
        }
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
                    .padding(.top , 5)
                Text(coin.positiveChange)
                    .foregroundColor( coin.changeStatus ? Color("LFont3") : Color("LFont4"))
                    .font(.custom("Roboto-Bold", size: 12.0))
                .padding(.top, 9)
            }
        }
        .padding(.trailing, 16)
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct ReferView : View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.referBackground)
            //.frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.13,  alignment: .center)
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
                    
                }
                .padding(EdgeInsets(top: 21, leading: 16, bottom: 21, trailing: 0))
                
                Text("You can earn $10  when you invite a friend to buy crypto. Invite your friend")
                    .font(.custom("Roboto-Regular", size: 16.0))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 16)
            }
        }
       // .padding(.horizontal, 16)
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
           
        }
        
    }
}

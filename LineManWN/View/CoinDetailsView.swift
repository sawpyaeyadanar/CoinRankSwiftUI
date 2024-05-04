//
//  CoinDetailsView.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//

import SwiftUI

struct CoinDetailsView: View {
    @StateObject var viewModel : CoinDetailsViewModel
    @Binding var isPresented: Bool
    @State private var showStackoverflow:Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                header
                description
                Spacer()
                Divider()
            }
            .padding(.horizontal, 24)

            Button(action: { self.showStackoverflow.toggle() }) {
                Text("GO TO WEBSITE")
                    .font(.custom("Roboto-Bold", size: 14.0))
                    .foregroundColor(Color.detailTheme.font1)
                    .padding(.vertical, 16)
            }
            .fullScreenCover(isPresented: self.$showStackoverflow , content: {
                SFSafariViewWrapper(url: URL(string: viewModel.coins!.websiteURL)!)
                    .ignoresSafeArea()
            })
                
        }
        .padding(.top, 32)
        
        
    }
}

extension CoinDetailsView {
    private var header: some View {
        HStack(alignment: .top) {
            CoinImageView(coin: viewModel.coin)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(viewModel.coins?.name ?? "")
                        .font(.custom("Roboto-Bold", size: 18.0))
                        .shadow(
                            color: Color.primary.opacity(0.25), /// shadow color
                            radius: 4, /// shadow radius
                            x: 0, /// x offset
                            y: 4 /// y offset
                        )
                        .foregroundColor(Color(hex: viewModel.coins?.color ?? "#999999"))
                    Text("(\(viewModel.coins?.symbol ?? ""))")
                        .font(.custom("Roboto-Regular", size: 16.0))
                }
                HStack {
                    Text("PRICE")
                        .font(.custom("Roboto-Bold", size: 12.0))
                    Text(viewModel.coins?.price.asCurrencyWith2Decimals() ?? "")
                        .font(.custom("Roboto-Regular", size: 12.0))
                }
                HStack {
                    Text("MARKET CAP")
                        .font(.custom("Roboto-Bold", size: 12.0))
                    Text(viewModel.coins?.marketCap.formatNumberWithSuffix() ?? "")
                        .font(.custom("Roboto-Regular", size: 12.0))
                }
            }
            .padding(.leading, 16)
        }
        .padding(.bottom, 16)
        
    }
    
    private var description: some View {
        ScrollView {
            Text("\(viewModel.coins?.coinDescription ?? "")")
                .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .font(.custom("Roboto-Regular", size: 14.0))
            .foregroundColor(Color.listTheme.font2)
        } // scrollView
    }
}

//#Preview {
//    CoinDetailsView()
//}


struct CoinDetailsView2: View {
    @State private var showStackoverflow:Bool = false
    @Binding var isPresented: Bool
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                
                header
                description
                Spacer()
                Divider()
            }
            .padding(.horizontal, 24)
            
            Button(action: { self.showStackoverflow.toggle() }) {
                Text("GO TO WEBSITE")
                    .font(.custom("Roboto-Bold", size: 14.0))
                    .foregroundColor(Color.detailTheme.font1)
                    .padding(.vertical, 16)
            }
            .fullScreenCover(isPresented: self.$showStackoverflow , content: {
                SFSafariViewWrapper(url: URL(string: "https://stackoverflow.com")!)
                    .ignoresSafeArea()
            })

        }
        .padding(.top, 32)

      

        
    }
}

extension CoinDetailsView2 {
    private var header: some View {
        HStack(alignment: .top) {
            Circle()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("viewModel")
                        .font(.custom("Roboto-Bold", size: 18.0))
                        .shadow(
                            color: Color.primary.opacity(0.25), /// shadow color
                            radius: 4, /// shadow radius
                            x: 0, /// x offset
                            y: 4 /// y offset
                        )
                        .foregroundColor(Color.yellow)
                    Text("( BTC)")
                        .font(.custom("Roboto-Regular", size: 16.0))
                }
                HStack {
                    Text("PRICE")
                        .font(.custom("Roboto-Bold", size: 12.0))
                    Text("PRice")
                        .font(.custom("Roboto-Regular", size: 12.0))
                }
                HStack {
                    Text("MARKET CAP")
                        .font(.custom("Roboto-Bold", size: 12.0))
                    Text("Market")
                        .font(.custom("Roboto-Regular", size: 12.0))
                }
            }
            //Spacer()
            .padding(.leading, 16)
        }
        .padding(.bottom, 16)
        
    }
    
    private var description: some View {
        ScrollView {
            Text("viewModel.coins?.coinDescription ?? ")
                .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .font(.custom("Roboto-Regular", size: 14.0))
            .foregroundColor(Color.listTheme.font2)
        } // scrollView
    }
}

#Preview {
    CoinDetailsView2(isPresented: .constant(false))
}


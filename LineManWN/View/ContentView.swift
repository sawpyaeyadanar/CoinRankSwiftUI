//
//  ContentView.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//


import SwiftUI

struct ContentView: View {
    @State private var coins: [Coin] = []
    @State private var isLoading = false
    @State private var shouldLoadMore = false
    @State private var rotationAngle: Angle = .degrees(0)
    var body: some View {
        ScrollViewReader { scrollViewProxy in
           shareButton
            Image(systemName: "arrow.clockwise.circle")
                       .resizable()
                       .scaledToFit()
                       .frame(width: 100, height: 100)
                       .rotationEffect(rotationAngle)
                       .onAppear {
                           
                           Timer.scheduledTimer(withTimeInterval: 0.002, repeats: true) { _ in
                               withAnimation {
                                   rotationAngle += .degrees(1) // Increase rotation angle by 1 degree
                               }
                           }
                       }
            
            List {
                ForEach(coins, id: \.id) { coin in
                    Text(coin.name)
                        .onAppear {
                            // Check if this is the last item in the list
                            if coin == self.coins.last {
                                // Set the flag to load more data
                                self.shouldLoadMore = true
                            }
                        }
                }
                
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .onAppear {
                // Initial API call to fetch data
                fetchCoins()
            }
            .onChange(of: shouldLoadMore) { shouldLoadMore in
                if shouldLoadMore {
                    // Load more data
                    fetchCoins()
                }
            }
            .onChange(of: coins) { _ in
                // Scroll to the bottom of the list when new data is added
                if !coins.isEmpty {
                    scrollViewProxy.scrollTo(coins.last!.id, anchor: .bottom)
                }
            }
        }
    }
    
    private var shareButton: some View {
        Text(labeledAttributedString)
            .font(.system(size: 23))
            .onTapGesture {
                share()
            }
        
    }
    
    private func share() {
        guard let url = URL(string: "https://google.com") else { return }
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        if let window = UIApplication.shared.windows.first {
            window.rootViewController?.present(activityController, animated: true, completion: nil)
        }
    }

    
    private let labeledAttributedString: AttributedString = {
        var label = AttributedString("You can earn $10 when you invite a friend to buy crypto.")
        label.foregroundColor = .yellow
        var invite = AttributedString("Invite your friend")
        invite.font = .callout
        invite.foregroundColor = .cyan
        invite.font = .title.bold()
        return label + invite
    }()
    
    func fetchCoins() {
        guard !isLoading else {
            return // Do not fetch if already loading
        }
        
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Mock data
            
            let newCoins = [Coin(uuid: UUID().uuidString, symbol: "", name: "Bitcoin", color: "", iconUrl: "", price: "", change: "", rank: 0),
                            Coin(uuid: UUID().uuidString, symbol: "", name: "Etharum", color: "", iconUrl: "", price: "", change: "", rank: 0)]
            
           // self.coins.append(contentsOf: newCoins)
            
            self.isLoading = false
            self.shouldLoadMore = false
        }
    }
}

#Preview {
        ContentView()
}

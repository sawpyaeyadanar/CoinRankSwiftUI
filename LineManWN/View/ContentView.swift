//
//  ContentView.swift
//  LineManWN
//
//  Created by Saw Pyae Yadanar on 2/5/2567 BE.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView {
                    VStack {
                        Rectangle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.red)
                            
                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                            

                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Expand VStack to fill the parent
            .background(Color.blue) // Just for visualization
            .edgesIgnoringSafeArea(.all)
        } // Ignore safe area for the background
    }
}

#Preview {
        ContentView()
}

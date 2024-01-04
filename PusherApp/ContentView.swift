//
//  ContentView.swift
//  PusherApp
//
//  Created by Pixel on 04/01/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @ObservedObject var pusherManager = PusherManager()
    
    var body: some View {
        VStack {
    
           
            Text("Received Message: \(pusherManager.receivedMessage)")
                           .padding()
        }
        .padding()
        .onAppear{
            pusherManager.pusherChannel()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

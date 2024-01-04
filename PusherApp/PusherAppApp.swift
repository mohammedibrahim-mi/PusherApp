//
//  PusherAppApp.swift
//  PusherApp
//
//  Created by Pixel on 04/01/24.
//

import SwiftUI
import PusherSwift

@main
struct PusherAppApp: App {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
         let pusher = Pusher(key: "caa48816454c8810e867")
         pusher.connect()
         
         return true
     }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

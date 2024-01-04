//
//  Readme.swift
//  PusherApp
//
//  Created by Pixel on 04/01/24.
//import Foundation


/*
 
 Pusher is a real-time websockets service that allows you to add real-time functionality to your applications, enabling instant communication and updates between clients and servers.A channel is a named communication path that allows clients to subscribe to and receive updates. Think of a channel as a topic or a specific category of messages/events.
 
 
 
 1.Add  Pusher Swift SDK GitHub URL: https://github.com/pusher/pusher-websocket-swift.git
 2.Initialize Pusher in your AppDelegate.swift or @main App file with pusher key
 
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      let pusher = Pusher(key: "YOUR_PUSHER_KEY")
      pusher.connect()
      
      return true
  }
 
 3.Create a Pusher channel and subscribe to events:
 
 class PusherManager: ObservableObject {
     private var pusher: Pusher!

     @Published var receivedMessage: String = ""

     init() {
         let options = PusherClientOptions(
             host: .cluster("YOUR_PUSHER_CLUSTER")
         )
 
 Creates options for the Pusher client, specifying the cluster host.
 
         pusher = Pusher(key: "YOUR_PUSHER_KEY", options: options)
 
 Initializes the Pusher client with the provided key and options.
 
         
         let channel = pusher.subscribe("YOUR_CHANNEL_NAME")

   channel?.bind(eventName: "trade-cancel", eventCallback: { event in   //YOUR_EVENT_NAME
         This line of code registers a callback function to be executed when an event with the specified name ("YOUR_EVENT_NAME") is received on the channel. The callback function captures [weak self] to avoid strong reference cycles and potential memory leaks.
     
     print(event.data!)
     print(event.channelName)

     if let pusherEvent = event as? PusherEvent,
           This line attempts to cast the event to a PusherEvent object. If successful, it proceeds to the next step; otherwise, it exits the callback.
        let eventDataString = pusherEvent.data,
             This line attempts to extract the data property from the PusherEvent object and cast it to a String. If successful, it proceeds to the next step; otherwise, it exits the callback.
          let jsonData = eventDataString.data(using: .utf8),
              This line converts the eventDataString (a JSON-formatted string) into Data using UTF-8 encoding, preparing it for JSON deserialization.
          let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
         This line deserializes the JSON data (jsonData) into a [String: Any] dictionary. It uses JSONSerialization.jsonObject(with:options:) for deserialization. The try? keyword is used to handle any potential errors by converting them into optional values. If the deserialization succeeds, the resulting dictionary is stored in the json constant.
          let infoData = json["info"] as? [String: Any],
        This line attempts to extract the "info" key from the json dictionary and cast its value to another [String: Any] dictionary, which represents the nested "info" object in the JSON structure.
          let message = infoData["message"] as? String {
         This line attempts to extract the "message" key from the infoData dictionary and cast its value to a String, representing the message content.
         
         print("message")
         print(message)
           
           DispatchQueue.main.async {
               self.receivedMessage = message
               //This block of code updates the receivedMessage property on the main thread. It uses DispatchQueue.main.async to ensure that the UI updates are performed on the main thread, which is required for UIKit and SwiftUI interactions.
           }
       }
 })

 pusher?.connect()
     }
 }

 4.Use in SwiftUI View
 
 @ObservedObject var pusherManager = PusherManager()
 Text("Received Message: \(pusherManager.receivedMessage)")
 
 
 */

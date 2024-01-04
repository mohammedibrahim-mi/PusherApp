//
//  PusherVM.swift
//  PusherApp
//
//  Created by Pixel on 04/01/24.
//

import Foundation
import PusherSwift

class PusherManager: ObservableObject {
    
    private var pusher: Pusher?
  
    @Published var receivedMessage: String = ""

    init() {
        let options = PusherClientOptions(
            host: .cluster("ap2")
        )
        
        pusher = Pusher(key: "caa48816454c8810e867", options: options)
        
        let channel = pusher?.subscribe("p2p-armup-socket")

        channel?.bind(eventName: "trade-request-chat", eventCallback: { [weak self] (data: Any?) in
            
            print("heloo\(String(describing: data) )")
            
            
            
            if let data = data as? [String: Any], let message = data["message"] as? String {
                DispatchQueue.main.async {
                    self?.receivedMessage = message
                }
            }
        })

        pusher?.connect()
    }
    
    
    
   func pusherChannel(){
       
       let options = PusherClientOptions(
           host: .cluster("ap2")   //YOUR_PUSHER_CLUSTER
       )
       
       //Creates options for the Pusher client, specifying the cluster host.
       
       pusher = Pusher(key: "caa48816454c8810e867", options: options)  //YOUR_PUSHER_KEY
       
       // Initializes the Pusher client with the provided key and options.
       
       let channel = pusher?.subscribe("p2p-armup-socket")      //YOUR_CHANNEL_NAME
       
       //Subscribes to a Pusher channel with the specified name.
       
       
       channel?.bind(eventName: "trade-cancel", eventCallback: { event in   //YOUR_EVENT_NAME
           
/*          This line of code registers a callback function to be executed when an event with the specified name ("YOUR_EVENT_NAME") is received on the channel. The callback function captures [weak self] to avoid strong reference cycles and potential memory leaks. */
           
           print(event.data!)
           print(event.channelName)

           if let pusherEvent = event as? PusherEvent,
              
                // This line attempts to cast the event to a PusherEvent object. If successful, it proceeds to the next step; otherwise, it exits the callback.
              
              let eventDataString = pusherEvent.data,
              
//              This line attempts to extract the data property from the PusherEvent object and cast it to a String. If successful, it proceeds to the next step; otherwise, it exits the callback.
              
                let jsonData = eventDataString.data(using: .utf8),
              
//              This line converts the eventDataString (a JSON-formatted string) into Data using UTF-8 encoding, preparing it for JSON deserialization.
              
                let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
              
              // This line deserializes the JSON data (jsonData) into a [String: Any] dictionary. It uses JSONSerialization.jsonObject(with:options:) for deserialization. The try? keyword is used to handle any potential errors by converting them into optional values. If the deserialization succeeds, the resulting dictionary is stored in the json constant.
              
                let infoData = json["info"] as? [String: Any],
              
              //This line attempts to extract the "info" key from the json dictionary and cast its value to another [String: Any] dictionary, which represents the nested "info" object in the JSON structure.
              
                let message = infoData["message"] as? String {
               
               //This line attempts to extract the "message" key from the infoData dictionary and cast its value to a String, representing the message content.
               
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




/*
 
 Pusher Response :
 
 {"info":{"sender_id":"3","receiver_id":"1","message":"Cancelled","orderid":"391"}}
 
 
 */


//another method
//       let _ = channel.bind(eventName: "trade-cancel", eventCallback: { (data: Any?) -> Void in
//
//           print("55")
//           print(data.self!)
//         if let data = data as? [String : AnyObject] {
//           if let message = data["message"] as? String {
//               print("456")
//               print(message)
//           }
//         }
//           else{
//
//           }
//
//       })

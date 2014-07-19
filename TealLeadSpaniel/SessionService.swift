//
//  SessionService.swift
//  TealLeadSpaniel
//
//  Created by Rafael on 19/07/14.
//  Copyright (c) 2014 Matt Nydam. All rights reserved.
//

import Foundation

import MultipeerConnectivity

class SessionService {
    
    let peerID: MCPeerID
    let session: MCSession
    let advertiser: MCNearbyServiceAdvertiser
    let serviceBrowser: MCNearbyServiceBrowser
    
    //delegates
    let sessionDelegate = SessionDelegate()
    let advertiserDelegate: AdvertiserDelegate
    let serviceBrowserDelegate: ServiceBrowserDelegate
    
    //config stuff
    let serviceType = "ramdom"
    let info = ["key":"value"]
    
    init(name:String){
        
        peerID = MCPeerID(displayName: "Anonymous\(UIDevice.currentDevice().identifierForVendor.UUIDString)")
        
        // Create the session that peers will be invited/join into.
        // You can provide an optinal security identity for custom authentication.
        // Also you can set the encryption preference for the session.
        session = MCSession(peer: peerID)//[[MCSession alloc] initWithPeer:peerID securityIdentity:nil encryptionPreference:MCEncryptionRequired];
        
        session.delegate = sessionDelegate
        
        //init(peer myPeerID: MCPeerID!, discoveryInfo info: NSDictionary!, serviceType: String!)
        advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: info, serviceType: serviceType)
        
        advertiserDelegate = AdvertiserDelegate(mySession: session)
        advertiser.delegate = advertiserDelegate
        
        advertiser.startAdvertisingPeer()
        
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        serviceBrowserDelegate = ServiceBrowserDelegate(session: session)
        serviceBrowser.delegate = serviceBrowserDelegate
        serviceBrowser.startBrowsingForPeers()
    }
    
    func onReceive(newHandler:(String) -> Void){
        
        sessionDelegate.handler = newHandler
        
    }
    
    
    func send(text:String){
        // Send a data message to a list of destination peers
        //func sendData(data: NSData!, toPeers peerIDs: AnyObject[]!, withMode mode: MCSessionSendDataMode, error: NSErrorPointer) -> Bool
        
        let data = text.dataUsingEncoding(NSUTF8StringEncoding)
        
        var error : NSError?
        
        session.sendData(data, toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error)
        
        if let actualError = error {
            println("An Error Occurred: \(actualError)")
        }
        else{
            println("Yeahhh message sent")
        }
    }
}

class SessionDelegate: NSObject, MCSessionDelegate {
    
    var handler:(String) -> Void
    
    init(){
        handler = {
            (text) -> Void in
                println("No handler defined.. so using default !")
        }
    }
    
    // Remote peer changed state
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState){
        println("Remote peer changed state - Connected to someone :-) -> \(peerID.displayName)  state: \(state)")
        
        if state == MCSessionState.Connected {
            println("Yeahhh someone to talk to")
        }
    }
    
    // Received data from remote peer
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!){
        println("Received data from remote peer")
        
        //if let realHandler = handler {
            let msg:String = NSString(data:data, encoding:NSUTF8StringEncoding)
            self.handler(msg)
        //}
    }
    
    // Received a byte stream from remote peer
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!){
        println("Received data from remote peer")
    }
    
    // Start receiving a resource from remote peer
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!){
        println("Start receiving a resource from remote peer")
    }
    
    // Finished receiving a resource from remote peer and saved the content in a temporary location - the app is responsible for moving the file to a permanent location within its sandbox
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!){
        println("Finished receiving a resource from remote peer and saved the content in a temporary location - the app is responsible for moving the file to a permanent location within its sandbox")
    }
    
    // Made first contact with peer and have identity information about the remote peer (certificate may be nil)
    func session(session: MCSession!, didReceiveCertificate certificate: AnyObject[]!, fromPeer peerID: MCPeerID!, certificateHandler: ((Bool) -> Void)!){
        println("Made first contact with peer and have identity information about the remote peer (certificate may be nil)")
        
        
        
    }
    
}

class AdvertiserDelegate: NSObject, MCNearbyServiceAdvertiserDelegate{
    
    let session: MCSession
    
    init(mySession:MCSession){
        session = mySession
    }
    
    // Incoming invitation request.  Call the invitationHandler block with YES and a valid session to connect the inviting peer to the session.
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!){
        
        println("advertiser ! -> Always says YES !!!")
        
        //always say yes !
        invitationHandler(true, session)
    }
    
    // Advertising did not start due to an error
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didNotStartAdvertisingPeer error: NSError!){
        
        println("advertiser !!! -> Something NASTY HAPPENED :-( Error: \(error.localizedDescription)")
        
    }
    
}

class ServiceBrowserDelegate: NSObject, MCNearbyServiceBrowserDelegate {
    
    let session: MCSession
    
    let inviteTimeout: NSTimeInterval = 30 //30 seconds is the default anyway
    
    let myPeerID: MCPeerID
    
    init(session: MCSession, myPeerID: MCPeerID){
        self.session = session
        self.myPeerID = myPeerID
    }
    
    // Found a nearby advertising peer
    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: NSDictionary!){
        println("Found a nearby advertising peer")
        
        if peerID?.displayName == myPeerID.displayName {
            println("I have found myself :-)")
        }
        
        if peerID?.displayName != myPeerID.displayName {
            
            println("I have found SOMEONE ELSE :-) ... inviting !")
            
            browser?.invitePeer(peerID, toSession: session, withContext: nil, timeout: inviteTimeout)
        }
    }
    
    // A nearby peer has stopped advertising
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!){
        println("A nearby peer has stopped advertising")
    }
    
    // Browsing did not start due to an error
    func browser(browser: MCNearbyServiceBrowser!, didNotStartBrowsingForPeers error: NSError!){
        println("Browsing did not start due to an error")
    }
}
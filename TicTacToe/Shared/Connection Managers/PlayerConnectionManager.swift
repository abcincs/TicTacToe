//
//  PlayerConnectionManager.swift
//  TicTacToe (iOS)
//
//  Created by Cédric Bahirwe on 27/05/2021.
//

import Foundation
import MultipeerConnectivity

class PlayerConnectionManager: NSObject, ObservableObject {
    typealias PlayerReceivedHandler = (PlayerModel) -> Void
    
    private static let service = "tictactoe-games"
    private var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
    
    // 1
    private let session: MCSession
    // 2
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let playerReceivedHandler: PlayerReceivedHandler?
    
    var isReceivingPlayers: Bool = false {
      didSet {
        if isReceivingPlayers {
          nearbyServiceAdvertiser.startAdvertisingPeer()
          print("Started advertising")
        } else {
          nearbyServiceAdvertiser.stopAdvertisingPeer()
          print("Stopped advertising")
        }
      }
    }

    
    
    init(_ playerReceivedHandler: PlayerReceivedHandler? = nil) {
        // 3
        session = MCSession(
            peer: myPeerId,
            securityIdentity: nil,
            encryptionPreference: .none)
        // 4
        self.playerReceivedHandler = playerReceivedHandler
        
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(
            peer: myPeerId,
            discoveryInfo: nil,
            serviceType: PlayerConnectionManager.service)
        super.init()
        nearbyServiceAdvertiser.delegate = self
    }
}

extension PlayerConnectionManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        guard
            let window = UIApplication.shared.windows.first,
            // 1
            let context = context,
            let playerName = String(data: context, encoding: .utf8)
        else {
            return
        }
        let title = "Accept \(peerID.displayName)'s Game"
        let message = "Would you like to accept: \(playerName)"
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(
            title: "No",
            style: .cancel
        ) { _ in
            // 2
            invitationHandler(false, nil)
        })
        alertController.addAction(UIAlertAction(
            title: "Yes",
            style: .default
        ) { _ in
            // 3
            invitationHandler(true, self.session)
        })
        window.rootViewController?.present(alertController, animated: true)
        
    }
}

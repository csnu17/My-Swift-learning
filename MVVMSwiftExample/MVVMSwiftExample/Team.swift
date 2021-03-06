//
//  Team.swift
//  MVVMExample
//
//  Created by Dino Bartosak on 15/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

struct Team {
  let name: String
  let identifier: String
  var players: [Player]
  
  mutating func addPlayer(_ player: Player) {
    players.append(player)
  }
  
  func containsPlayer(_ player: Player) -> Bool {
    var contains: Bool = false
    for currentPlayer in players {
      if currentPlayer.identifier == player.identifier {
        contains = true
        break
      }
    }
    
    return contains
  }
}

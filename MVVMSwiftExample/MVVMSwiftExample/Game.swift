//
//  Game.swift
//  MVVMExample
//
//  Created by Dino Bartosak on 15/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

enum PlayerInGameMove {
  case onePoint
  case twoPoints
  case assist
  case rebound
  case foul
}

enum GameNotifications {
  static let GameScoreDidChangeNotification = "GameScoreDidChangeNotification"
}

class Game {
  let matchWinningScore = 15
  
  let identifier: String
  var homeTeam: Team
  var awayTeam: Team
  var homeTeamScore = 0
  var awayTeamScore = 0
  
  var time: TimeInterval = 0.0
  var isFinished = false
  
  private var moveHistory: [(move: PlayerInGameMove, player: Player)]
  
  init(homeTeam: Team, awayTeam: Team, identifier: String) {
    self.identifier = identifier
    self.homeTeam = homeTeam
    self.awayTeam = awayTeam
    moveHistory = []
  }
  
  func addPlayerMove(_ move: PlayerInGameMove, for player: Player) {
    if !containsPlayer(player) {
      print("Player not part of this game")
      return
    }
    
    updateMoveHistory(with: move, player: player)
    
    switch move {
    case .onePoint:
      updateScore(1, withScoringPlayer: player)
    case .twoPoints:
      updateScore(2, withScoringPlayer: player)
    case .assist: return
    case .rebound: return
    case .foul: return
    }
  }
  
  func playerMoveCount(for player: Player, move: PlayerInGameMove) -> Int {
    var moveCount = 0
    for currentMove in moveHistory {
      if currentMove.move == move && currentMove.player.identifier == player.identifier {
        moveCount += 1
      }
    }
    return moveCount
  }
  
  static func isScoringMove(_ move: PlayerInGameMove) -> Bool {
    return move == .onePoint || move == .twoPoints
  }
  
  // MARK: Private
  
  private func containsPlayer(_ player: Player) -> Bool {
    var contains = false
    
    contains = homeTeam.containsPlayer(player)
    if !contains {
      contains = awayTeam.containsPlayer(player)
    }
    
    return contains
  }
  
  private func updateMoveHistory(with move: PlayerInGameMove, player: Player) {
    moveHistory.append((move: move, player: player))
  }
  
  private func updateScore(_ score: Int, withScoringPlayer player: Player) {
    if isFinished || score == 0 {
      return
    }
    
    if homeTeam.containsPlayer(player) {
      homeTeamScore += score
    } else {
      assert(awayTeam.containsPlayer(player))
      awayTeamScore += score
    }
    
    if checkIfFinished() {
      isFinished = true
    }
    
    NotificationCenter.default.post(name: Notification.Name(rawValue: GameNotifications.GameScoreDidChangeNotification), object: self)
  }
  
  private func checkIfFinished() -> Bool {
    var isFinished = false
    
    let winningScoreReached = homeTeamScore >= matchWinningScore ||
      awayTeamScore >= matchWinningScore
    
    if winningScoreReached {
      isFinished = abs((Int(awayTeamScore)) - Int(homeTeamScore)) > 1
    }
    
    return isFinished
  }
}

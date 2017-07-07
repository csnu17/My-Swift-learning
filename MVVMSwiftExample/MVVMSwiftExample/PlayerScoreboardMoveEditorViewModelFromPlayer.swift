//
//  PlayerScoreboardMoveEditorViewModelFromPlayer.swift
//  MVVMSwiftExample
//
//  Created by Phetrungnapha, K. on 7/6/2560 BE.
//  Copyright © 2560 Toptal. All rights reserved.
//

import Foundation

class PlayerScoreboardMoveEditorViewModelFromPlayer: PlayerScoreboardMoveEditorViewModel {
  
  private let player: Player
  private var game: Game
  
  // MARK: PlayerScoreboardMoveEditorViewModel protocol
  
  let playerName: String
  
  let onePointMoveCount: Dynamic<String>
  let twoPointMoveCount: Dynamic<String>
  let assistMoveCount: Dynamic<String>
  let reboundMoveCount: Dynamic<String>
  let foulMoveCount: Dynamic<String>
  
  func onePointMove() {
    makeMove(.onePoint)
  }
  
  func twoPointsMove() {
    makeMove(.twoPoints)
  }
  
  func assistMove() {
    makeMove(.assist)
  }
  
  func reboundMove() {
    makeMove(.rebound)
  }
  
  func foulMove() {
    makeMove(.foul)
  }
  
  // MARK: Init
  
  init(withGame game: Game, player: Player) {
    self.game = game
    self.player = player
    
    playerName = player.name
    onePointMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .onePoint))")
    twoPointMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .twoPoints))")
    assistMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .assist))")
    reboundMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .rebound))")
    foulMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .foul))")
  }
  
  // MARK: Private
  
  private func makeMove(_ move: PlayerInGameMove) {
    game.addPlayerMove(move, for: player)
    
    onePointMoveCount.value = "\(game.playerMoveCount(for: player, move: .onePoint))"
    twoPointMoveCount.value = "\(game.playerMoveCount(for: player, move: .twoPoints))"
    assistMoveCount.value = "\(game.playerMoveCount(for: player, move: .assist))"
    reboundMoveCount.value = "\(game.playerMoveCount(for: player, move: .rebound))"
    foulMoveCount.value = "\(game.playerMoveCount(for: player, move: .foul))"
  }
}

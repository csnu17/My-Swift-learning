//
//  GameScoreboardEditorViewModelFromGame.swift
//  MVVMSwiftExample
//
//  Created by Phetrungnapha, K. on 7/5/2560 BE.
//  Copyright © 2560 Toptal. All rights reserved.
//

import Foundation

class GameScoreboardEditorViewModelFromGame: GameScoreboardEditorViewModel {
  let game: Game
  
  struct Formatter {
    static let durationFormatter: DateComponentsFormatter = {
      let dateFormatter = DateComponentsFormatter()
      dateFormatter.unitsStyle = .positional
      return dateFormatter
    }()
  }
  
  // MARK: - GameScoreboardEditorViewModel protocol
  
  let homePlayers: [PlayerScoreboardMoveEditorViewModel]
  let awayPlayers: [PlayerScoreboardMoveEditorViewModel]
  
  let homeTeam: String
  let awayTeme: String
  let time: Dynamic<String>
  let score: Dynamic<String>
  let isFinished: Dynamic<Bool>
  let isPaused: Dynamic<Bool>
  
  func togglePause() {
    if isPaused.value {
      startTimer()
    } else {
      pauseTimer()
    }
    
    isPaused.value = !isPaused.value
  }
  
  // MARK: - Init
  
  init(withGame game: Game) {
    self.game = game
    homeTeam = game.homeTeam.name
    awayTeme = game.awayTeam.name
    
    time = Dynamic(GameScoreboardEditorViewModelFromGame.timeRemainingPretty(for: game))
    score = Dynamic(GameScoreboardEditorViewModelFromGame.scorePretty(for: game))
    isFinished = Dynamic(game.isFinished)
    isPaused = Dynamic(true)
    
    homePlayers = GameScoreboardEditorViewModelFromGame.playerViewModels(from: game.homeTeam.players, game: game)
    awayPlayers = GameScoreboardEditorViewModelFromGame.playerViewModels(from: game.awayTeam.players, game: game)
    
    subscribeToNotifications()
  }
  
  deinit {
    unsubscribeFromNotifications()
  }
  
  // MARK: Notifications (Private)
  
  private func subscribeToNotifications() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(gameScoreDidChangeNotification(_:)),
                                           name: NSNotification.Name(rawValue: GameNotifications.GameScoreDidChangeNotification),
                                           object: game)
  }
  
  private func unsubscribeFromNotifications() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc private func gameScoreDidChangeNotification(_ notification: NSNotification) {
    self.score.value = GameScoreboardEditorViewModelFromGame.scorePretty(for: game)
    
    if game.isFinished {
      self.isFinished.value = true
    }
  }
  
  // MARK: - Private
  
  private var gameTimer: Timer?
  
  private func startTimer() {
    let interval: TimeInterval = 0.001
    gameTimer = Timer.schedule(repeatInterval: interval) { timer in
      self.game.time += interval
      self.time.value = GameScoreboardEditorViewModelFromGame.timeRemainingPretty(for: self.game)
    }
  }
  
  private static func playerViewModels(from players: [Player], game: Game) -> [PlayerScoreboardMoveEditorViewModel] {
    var playerViewModels: [PlayerScoreboardMoveEditorViewModel] = [PlayerScoreboardMoveEditorViewModel]()
    for player in players {
      playerViewModels.append(PlayerScoreboardMoveEditorViewModelFromPlayer(withGame: game, player: player))
    }
    
    return playerViewModels
  }
  
  private func pauseTimer() {
    gameTimer?.invalidate()
    gameTimer = nil
  }
  
  // MARK: - String Utils
  
  private static func timeFormatted(totalMillis: Int) -> String {
    let millis = totalMillis % 1000 / 100 // "/ 100" <- because we want only 1 digit
    let totalSeconds = totalMillis / 1000
    
    let seconds = totalSeconds % 60
    let minutes = totalSeconds / 60
    
    return String(format: "%02d:%02d.%d", minutes, seconds, millis)
  }
  
  private static func timeRemainingPretty(for game: Game) -> String {
    return timeFormatted(totalMillis: Int(game.time * 1000))
  }
  
  private static func scorePretty(for game: Game) -> String {
    return "\(game.homeTeamScore) - \(game.awayTeamScore)"
  }
}

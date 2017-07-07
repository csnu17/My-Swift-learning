//
//  GameScoreboardEditorViewModel.swift
//  MVVMSwiftExample
//
//  Created by Phetrungnapha, K. on 7/5/2560 BE.
//  Copyright © 2560 Toptal. All rights reserved.
//

import Foundation

protocol GameScoreboardEditorViewModel {
  
  var homePlayers: [PlayerScoreboardMoveEditorViewModel] { get }
  var awayPlayers: [PlayerScoreboardMoveEditorViewModel] { get }
  
  var homeTeam: String { get }
  var awayTeme: String { get }
  var time: Dynamic<String> { get }
  var score: Dynamic<String> { get }
  var isFinished: Dynamic<Bool> { get }
  var isPaused: Dynamic<Bool> { get }
  
  func togglePause()
}

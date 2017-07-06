//
//  PlayerScoreboardMoveEditorViewModel.swift
//  MVVMSwiftExample
//
//  Created by Phetrungnapha, K. on 7/6/2560 BE.
//  Copyright © 2560 Toptal. All rights reserved.
//

import Foundation

protocol PlayerScoreboardMoveEditorViewModel {
  var playerName: String { get }
  
  var onePointMoveCount: Dynamic<String> { get }
  var twoPointMoveCount: Dynamic<String> { get }
  var assistMoveCount: Dynamic<String> { get }
  var reboundMoveCount: Dynamic<String> { get }
  var foulMoveCount: Dynamic<String> { get }
  
  func onePointMove()
  func twoPointsMove()
  func assistMove()
  func reboundMove()
  func foulMove()
}

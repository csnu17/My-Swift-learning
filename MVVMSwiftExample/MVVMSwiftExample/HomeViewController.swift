//
//  HomeViewController.swift
//  MVVMSwiftExample
//
//  Created by Dino Bartosak on 25/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  var gameLibrary: GameLibrary? {
    didSet {
      showGameScoreboardEditorViewController()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    showGameScoreboardEditorViewController()
  }
  
  // MARK: Private
  
  private func showGameScoreboardEditorViewController() {
    if !isViewLoaded {
      return
    }
    
    guard let gameLibrary = gameLibrary else {
      return
    }
    
    if let game = gameLibrary.allGames().first {
      let controller = UIStoryboard.loadGameScoreboardEditorViewController()
      let viewModel = GameScoreboardEditorViewModelFromGame(withGame: game)
      controller.viewModel = viewModel
      
      insertChildController(controller, intoParentView: view)
    }
  }
}
//
//  GameScoreboardEditorViewController.swift
//  MVVMSwiftExample
//
//  Created by Dino Bartosak on 25/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class GameScoreboardEditorViewController: UIViewController {
  @IBOutlet weak var homePlayer1View: PlayerScoreboardMoveEditorView!
  @IBOutlet weak var homePlayer2View: PlayerScoreboardMoveEditorView!
  @IBOutlet weak var homePlayer3View: PlayerScoreboardMoveEditorView!
  
  @IBOutlet weak var awayPlayer1View: PlayerScoreboardMoveEditorView!
  @IBOutlet weak var awayPlayer2View: PlayerScoreboardMoveEditorView!
  @IBOutlet weak var awayPlayer3View: PlayerScoreboardMoveEditorView!
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var pauseButton: UIButton!
  
  @IBOutlet weak var homeTeamNameLabel: UILabel!
  @IBOutlet weak var awayTeamNameLabel: UILabel!
  
  @IBOutlet weak var scoreLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    styleUI()
    fillUI()
  }
  
  // MARK: Button Action
  
  @IBAction func pauseButtonPress(_ sender: AnyObject) {
    
  }
  
  // MARK: Private
  
  private func styleUI() {
    view.backgroundColor = UIColor.backgroundColor
    scoreLabel.textColor = UIColor.scoreColor
    homeTeamNameLabel.textColor = UIColor.textColor
    awayTeamNameLabel.textColor = UIColor.textColor
    timeLabel.textColor = UIColor.textColor
  }
  
  private func fillUI() {
    
  }
}

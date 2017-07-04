//
//  PlayerScoreboardMoveEditorView.swift
//  MVVMSwiftExample
//
//  Created by Dino Bartosak on 26/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

class PlayerScoreboardMoveEditorView: UIView {
  @IBOutlet weak var onePointCountLabel: UILabel!
  @IBOutlet weak var twoPointCountLabel: UILabel!
  @IBOutlet weak var assistCountLabel: UILabel!
  @IBOutlet weak var reboundCountLabel: UILabel!
  @IBOutlet weak var foulCountLabel: UILabel!
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var onePointButton: UIButton!
  @IBOutlet weak var twoPointsButton: UIButton!
  @IBOutlet weak var assistButton: UIButton!
  @IBOutlet weak var reboundButton: UIButton!
  @IBOutlet weak var foulButton: UIButton!
  
  private weak var playerNibView: UIView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    let playerView: UIView = UINib.loadPlayerScoreboardMoveEditorView(self)
    addSubview(playerView)
    playerNibView = playerView
    
    styleUI()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    playerNibView.frame = bounds
  }
  
  // MARK: Button Action
  
  @IBAction func onePointAction(_ sender: Any) {
    
  }
  
  @IBAction func twoPointsAction(_ sender: Any) {
    
  }
  
  @IBAction func assistAction(_ sender: Any) {
    
  }
  
  @IBAction func reboundAction(_ sender: Any) {
    
  }
  
  @IBAction func foulAction(_ sender: Any) {
    
  }
  
  // MARK: Private
  
  private func styleUI() {
    layer.cornerRadius = 5.0
    layer.borderWidth = 1.0
    layer.borderColor = UIColor.borderColor.cgColor
    clipsToBounds = true
    
    backgroundColor = UIColor.playerBackgroundColor
    
    styleActionButton(onePointButton)
    styleActionButton(twoPointsButton)
    styleActionButton(assistButton)
    styleActionButton(reboundButton)
    styleActionButton(foulButton)
  }
  
  private func styleActionButton(_ button: UIButton) {
    button.setTitleColor(UIColor.scoreColor, for: UIControlState())
    button.layer.cornerRadius = button.bounds.size.width / 2.0
    button.layer.borderWidth = 1.0
    button.layer.borderColor = UIColor.brightPlayerBackgroundColor.cgColor
    button.backgroundColor = UIColor.brightPlayerBackgroundColor
  }
  
  private func fillUI() {
    
  }
}

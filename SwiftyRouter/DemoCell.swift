//
//  DemoCell.swift
//  SwiftyRouter
//
//  Created by duzhe on 2017/8/5.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import UIKit

class DemoCell: UITableViewCell {
  
  
  @IBOutlet weak var leftLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(push))
    contentView.addGestureRecognizer(tap)
    contentView.isUserInteractionEnabled = true
  }
  
  func push(){
    Router.open(RouterPath.avc)
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

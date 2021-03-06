//
//  YelpLightCell.swift
//  YelpLight
//
//  Created by Shane Afsar on 2/9/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

protocol YelpSettingsCellDelegate : class{
  func switchView(cell:YelpSettingsCell, switchedOn value:Bool)
}

class YelpSettingsCell: UITableViewCell {
  
  weak var delegate:YelpSettingsCellDelegate?
  
  @IBOutlet weak var optionSwitch: UISwitch!
  
  @IBOutlet weak var settingsLabel: UILabel!
  
  var filterType:String?
  var filterValue:AnyObject?
  
  var top=false
  var bottom=false
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  @IBAction func onChanged(sender: AnyObject) {
    delegate?.switchView(self, switchedOn: optionSwitch.on)
  }
  
  func setBorders(#isTop: Bool, isBottom: Bool){
    top = isTop
    bottom = isBottom
    
    layer.borderWidth = 0.0
    layer.masksToBounds = true
    separatorInset = UIEdgeInsetsZero
    
    var corners:UIRectCorner?
    let triggerCorners = isTop || isBottom
    
    if isTop && isBottom{
      corners = UIRectCorner.AllCorners
    }
    else if isBottom{
      corners = UIRectCorner.BottomLeft | UIRectCorner.BottomRight
    }
    else if isTop{
      corners = UIRectCorner.TopLeft | UIRectCorner.TopRight
    }
    
    
    if triggerCorners{
      let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners!, cornerRadii: CGSize(width: 12.0, height: 12.0))
      
      let maskLayer = CAShapeLayer()
      maskLayer.frame = bounds
      maskLayer.path = maskPath.CGPath
      layer.mask = maskLayer
    }else{
      let maskPath = UIBezierPath(rect: bounds)
      
      let maskLayer = CAShapeLayer()
      maskLayer.frame = bounds
      maskLayer.path = maskPath.CGPath
      layer.mask = maskLayer
    }

    
    if optionSwitch.hidden == false{
      selectionStyle = .None
    }
    
  }
  
  //Custom masks don't automatically resize on orientation change
  //so this is needed
  override func layoutSubviews() {
    super.layoutSubviews()
    setBorders(isTop: top, isBottom: bottom)
  }
  
  func layoutSubviews(#isTop:Bool, isBottom: Bool){
    super.layoutSubviews()
    setBorders(isTop: isTop, isBottom: isBottom)
  }

}

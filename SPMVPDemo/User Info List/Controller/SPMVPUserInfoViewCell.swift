//
//  SPMVPUserInfoViewCell.swift
//  SPMVPDemo
//
//  Created by webonise on 29/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit

var LABEL_HEIGHT        : CGFloat   = 21
var LEFT_RIGHT_MARGIN   : CGFloat   = 10
var TOP_BOTTOM_MARGIN   : CGFloat   = 12

var NUMBER_OF_VERTICAL_MARGINS      : CGFloat = 4
var NUMBER_OF_HORIZANTAL_MARGINS    : CGFloat = 2
var NUMBER_OF_STATIC_LABELS         : CGFloat = 2

var FONT_SIZE : CGFloat = 16.0

class SPMVPUserInfoViewCell: UITableViewCell
{
    @IBOutlet weak var lblName  : UILabel!
    @IBOutlet weak var lblEmail : UILabel!
    @IBOutlet weak var lblBody  : UILabel!
    
    var userInfo : SPUserInfo!

    func updateUI()
    {
        self.lblName.text   = self.userInfo.getNameWithThreeWords();
        self.lblEmail.text  = self.userInfo.getEmailInLowerCase();
        self.lblBody.text   = self.userInfo.emailBody;
    }
    
    class func getHeightForCellForUserInfo(userInfo: SPUserInfo)->CGFloat?
    {
        var width : CGFloat = UIScreen.mainScreen().bounds.size.width
        
        width = width - (NUMBER_OF_HORIZANTAL_MARGINS * LEFT_RIGHT_MARGIN);
        
        return Utility.getHeightForText(userInfo.emailBody, width:width , fontSize: FONT_SIZE)! + (NUMBER_OF_STATIC_LABELS * LABEL_HEIGHT) + (NUMBER_OF_VERTICAL_MARGINS * TOP_BOTTOM_MARGIN);
    }
}

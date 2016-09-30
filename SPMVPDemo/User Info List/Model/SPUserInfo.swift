//
//  SPUserInfo.swift
//  SPMVPDemo
//
//  Created by webonise on 28/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit

var KEY_POST_ID     : String = "postId"
var KEY_ID          : String = "id"
var KEY_NAME        : String = "name"
var KEY_EMAIL       : String = "email"
var KEY_BODY        : String = "body"

class SPUserInfo: NSObject
{
    var userID      : NSNumber = 0.0
    var userPostID  : NSNumber = 0.0
    var name        : String = ""
    var email       : String = ""
    var emailBody   : String = ""
}

extension SPUserInfo
{
    func loadUserInfoFromResponse(response: NSDictionary)
    {
        self.userID         = response.valueForKey(KEY_ID)! as! NSNumber
        self.userPostID     = response.valueForKey(KEY_POST_ID)! as! NSNumber
        self.name           = response.valueForKey(KEY_NAME)! as! String
        self.email          = response.valueForKey(KEY_EMAIL)! as! String
        self.emailBody      = response.valueForKey(KEY_BODY)! as! String
    }
    
    func getNameWithThreeWords() -> String?
    {
        return Utility.shortenTextToWordLinit(self.name as String, wordLinit: 3)
    }
    
    func getEmailInLowerCase() -> String?
    {
        return Utility.textInLowerCase(self.email as String)
    }
}

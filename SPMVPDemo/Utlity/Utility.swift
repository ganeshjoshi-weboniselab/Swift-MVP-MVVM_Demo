//
//  Utility.swift
//  SPMVPDemo
//
//  Created by webonise on 28/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit

class Utility: NSObject
{
    /*
     * Removes words more than given word limit & truncate
     */
    class func shortenTextToWordLinit(text: String, wordLinit: NSInteger) -> String?
    {
        var name = ""
        
        let nameComponents = text.componentsSeparatedByString(" ")
        
        if nameComponents.count <= 3
        {
            name = text;
        }
        else
        {
            name = nameComponents[0] + " " +  nameComponents [1] + " " + nameComponents [3] + "..."
        }
        
        return name;
    }
    
    /*
     * Return given text in lower case
     */
    class func textInLowerCase(emailText: String) -> String?
    {
        return emailText.lowercaseString
    }
    
    /*
     * Check whether given email is valid or not
     */
    class func isEmailValid(email: String) -> Bool?
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluateWithObject(email)
    }
    
    /*
     * Return height for given text & for given font size
     */
    class func getHeightForText(text : NSString, width : CGFloat, fontSize : CGFloat)->CGFloat?
    {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = text.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(fontSize)], context: nil)
        
        return boundingBox.height
    }
    
    class func getButtonWithFrame(frame : CGRect, buttonTag:Int, image: UIImage)->UIButton?
    {
        let btn = UIButton.init(frame: frame)
        btn.tag = buttonTag
        btn.setBackgroundImage(image , forState: UIControlState.Normal)
        return btn
    }
}

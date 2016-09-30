//
//  SPUserInfoTableViewDataSource.swift
//  SPMVPDemo
//
//  Created by webonise on 28/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit

class SPUserInfoTableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource
{
    var userInfoList: NSArray = []
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userInfoList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return SPMVPUserInfoViewCell.getHeightForCellForUserInfo(self.userInfoList.objectAtIndex(indexPath.row) as! SPUserInfo)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:SPMVPUserInfoViewCell = tableView.dequeueReusableCellWithIdentifier("SPMVPUserInfoViewCell") as! SPMVPUserInfoViewCell!
                
        cell.userInfo = self.userInfoList.objectAtIndex(indexPath.row) as! SPUserInfo
        
        cell.updateUI()
        
        return cell
    }
}

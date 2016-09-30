//
//  SPUserInfoViewModel.swift
//  SPMVPDemo
//
//  Created by webonise on 29/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit

@objc protocol SPUserInfoViewModelDelegate
{
    func startLoadingUserInfoFromServerInViewModel()
    func finishLoadingUserInfoListFromViewModel(userInfoList: NSArray)
    func failedLoadingUserInfoListWithMessageFromViewModel(message: NSString)
}

var USER_INFO_URL : NSString = "https://jsonplaceholder.typicode.com/comments";
var GET : NSString = "GET"

class SPUserInfoViewModel: NSObject
{
    var delegate : SPUserInfoViewModelDelegate!
    
    //# MARK:- Server call for user info list
    
    func fetchAllUsers()
    {
        let url = NSURL(string: USER_INFO_URL as String)!
        
        let urlRequest = NSMutableURLRequest(
            URL: url,
            cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 10.0 * 1000)
        
        urlRequest.HTTPMethod = GET as String
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let urlSession = NSURLSession.sharedSession()
        
        if self.delegate != nil
        {
            self.delegate.startLoadingUserInfoFromServerInViewModel()
        }
        
        let task = urlSession.dataTaskWithRequest(urlRequest)
        { (data, response, error) -> Void in
            
            guard error == nil
                else
            {
                print("Error while fetching user info: \(error)")
                
                if self.delegate != nil
                {
                    self.delegate.failedLoadingUserInfoListWithMessageFromViewModel("Failed to get user info from server")
                }
                
                return
            }
            
            guard (try? NSJSONSerialization.JSONObjectWithData(data!,
                options: []) as? [String: AnyObject]) != nil
                else
            {
                if self.delegate != nil
                {
                    self.delegate.failedLoadingUserInfoListWithMessageFromViewModel("Failed to get user info from server")
                }
                
                print("No data received from server")
                return
            }
            
            let json = try? NSJSONSerialization.JSONObjectWithData(data!, options:[])
            
            self.finishServerCallWithJson(json!)
        }
        
        task.resume()
    }
    
    func finishServerCallWithJson(json:AnyObject?)
    {
        let array = json as! NSArray
        
        if array.count > 0 && self.delegate != nil
        {
            self.delegate.finishLoadingUserInfoListFromViewModel(self.loadUserInfoFromResponse(array)!)
        }
        else if array.count <= 0 && self.delegate != nil
        {
            self.delegate.failedLoadingUserInfoListWithMessageFromViewModel("Failed to get user info from server")
        }
    }
    
    //#MARK: End
    
    //#MARK:- Load user info list
    
    func loadUserInfoFromResponse(responses:NSArray)->NSArray?
    {
        let userList = NSMutableArray()
        
        for userInfo in responses
        {
            let user = SPUserInfo()
            user.loadUserInfoFromResponse(userInfo as! NSDictionary)
            userList.addObject(user)
        }
        
        return userList
    }
    
    //#MARK: End
}

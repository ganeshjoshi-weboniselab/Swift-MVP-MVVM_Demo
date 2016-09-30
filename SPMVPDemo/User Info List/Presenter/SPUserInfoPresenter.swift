//
//  SPUserInfoPresenter.swift
//  SPMVPDemo
//
//  Created by webonise on 28/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit

protocol SPUserInfoPresenterDelegate
{
   func finishLoadingUserInfoList(userInfoList: NSArray)
   func failedLoadingUserInfoListWithMessage(message: NSString)
}

class SPUserInfoPresenter: NSObject, SPUserInfoViewModelDelegate
{
    var userInfoList: NSArray = []
    var delegate: SPUserInfoPresenterDelegate!
 
    func getUserInfoListFromServer ()
    {
        let vmodel = SPUserInfoViewModel()
        vmodel.delegate = self
        vmodel.fetchAllUsers()
    }
    
    func finishLoadingUserInfoListFromViewModel(userInfoList: NSArray)
    {
        self.userInfoList = userInfoList;
        
        if self.userInfoList.count > 0 && self.delegate != nil
        {
            self.delegate.finishLoadingUserInfoList(self.userInfoList)
        }
    }
    
    func failedLoadingUserInfoListWithMessageFromViewModel(message: NSString)
    {
        if self.delegate != nil
        {
            self.delegate.failedLoadingUserInfoListWithMessage("Failed to get user info from server")
        }
    }
}

//
//  SPMVPDemoTests.swift
//  SPMVPDemoTests
//
//  Created by webonise on 28/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import XCTest
@testable import SPMVPDemo

class SPMVPDemoTests: XCTestCase
{
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample()
    {
        // This is an example of a performance test case.
        self.measureBlock
        {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEmailLowerCase()
    {
        let email = "Ganesh.Joshi@weboniselab.com"
        
        XCTAssertEqual(Utility.textInLowerCase(email), "ganesh.joshi@weboniselab.com", "Email not conmverted in lower case")
    }
    
    func testEmailLowerCaseFail()
    {
        let email = "Ganesh.Joshi@weboniselab.com"
        
        XCTAssertEqual(email, "ganesh.joshi@weboniselab.com", "Email not conmverted in lower case")
    }
    
    func testNameInThreeWords()
    {
        let name = "John Steve Parker"
        
        let shortName = Utility.shortenTextToWordLinit(name, wordLinit: 3)
        
        let arr = shortName!.componentsSeparatedByString(" ")
        
        XCTAssertTrue(arr.count <= 3, "Name contains more than three words")
    }
    
    func testNameInThreeWordsFail()
    {
        let name = "John Steve Parker Lee"
        
        XCTAssertTrue(name.characters.count <= 3, "Name contains more than three words")
    }
}

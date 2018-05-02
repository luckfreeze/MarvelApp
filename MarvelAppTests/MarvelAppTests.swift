//
//  MarvelAppTests.swift
//  MarvelAppTests
//
//  Created by Lucas Moraes on 27/04/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import XCTest
@testable import MarvelApp

class MarvelAppTests: XCTestCase {

    let marvelAPI = MarvelAPI()
    
    var viewController = CharactersVC()
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func setUp() {
        super.setUp()
        
        viewController = storyboard.instantiateViewController(withIdentifier: "Characters") as! CharactersVC
        _ = viewController.view // Calling the view of ViewController
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_IsInstantiatable() {
        XCTAssertNotNil(viewController)
    }
    
    func testGrid() {
        XCTAssertNotNil(viewController.collectionView?.delegate)
        XCTAssertNotNil(viewController.collectionView?.dataSource)
    }
    
    func testList() {
        XCTAssertNotNil(viewController.tableView?.delegate)
        XCTAssertNotNil(viewController.tableView?.dataSource)
    }
    
    func test_MarvelApi_Chars() {
        marvelAPI.getCharacters { (error, chars) in
            XCTAssertNotNil(chars)
        }
    }
    
    func test_MarvelApi_Error() {
        marvelAPI.getCharacters { (error, chars) in
            XCTAssertNil(error, "There is no Error while testing of 'getCharacters' ")
        }
    }
    
    func testPerformanceExample() {
        self.measure { }
    }
    
}

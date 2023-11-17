//
//  twitterAppByAnandTests.swift
//  twitterAppByAnandTests
//
//  Created by APPLE on 14/11/23.
//

import XCTest
@testable import twitterAppByAnand

final class twitterAppByAnandTests: XCTestCase {

    var twitterViewModel: TwitterViewModel!
    var tweetsList: [Tweet] = []
    
    
    override func setUpWithError() throws {
        twitterViewModel = TwitterViewModel()
    }

    override func tearDownWithError() throws {
        // Clean up resources if needed
        twitterViewModel = nil
        super.tearDown()
    }
    
    func testFetchTweetData() {
          let viewModel = TwitterViewModel()

          let expectation = XCTestExpectation(description: "Fetching tweet data")

        viewModel.fetchTweetData {
            XCTAssertFalse(viewModel.tweetsList.isEmpty, "Tweets list should not be empty after fetching data")
            
            // You can add more specific assertions based on your data model or requirements
            
            expectation.fulfill()
        }
          wait(for: [expectation], timeout: 5.0)
      }

    func testExample() throws {
      
    }

    func testPerformanceExample() throws {
       
        self.measure {
           
        }
    }

}

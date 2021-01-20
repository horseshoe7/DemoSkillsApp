//
//  ChannelListViewModelTests.swift
//  DemoSkillsAppTests
//
//  Created by Stephen O'Connor on 20.01.21.
//

import XCTest
@testable import DemoSkillsApp

class ChannelListViewModelTests: XCTestCase {

    var viewModel: ChannelListViewModel = ChannelListViewModel()
    
    override func setUpWithError() throws {
        // create a fixture from JSON, get a model to instantiate a view model
        
        //guard let response: ChannelListResponse = Fixture.decodeJSON(fileName: "watch_channel_response_valid.fixture").result else { return XCTFail("Unable to decode")}
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testControllerTitle() throws {
        XCTAssertTrue(viewModel.controllerTitle == L10n.ChannelListViewController.title)
    }
    
    func testBinding() throws {
        let expectation = self.expectation(description: "Data gets updated")
        var initialValue = false
        viewModel.channels.bind { (newCollection) in
            if !initialValue {
                initialValue = true
            } else {
                expectation.fulfill()
            }
        }
        
        guard let response: ChannelListResponse = Fixture.decodeJSON(fileName: "MockChannelList.json").result else { return XCTFail("Unable to decode")}
        
        viewModel.channels.value = response.channelList.map({ (listItem) -> ChannelListItemTableCellModel in
            return ChannelListItemTableCellModel(model: listItem)
        })
        
        self.waitForExpectations(timeout: 20, handler: nil)
    }
}

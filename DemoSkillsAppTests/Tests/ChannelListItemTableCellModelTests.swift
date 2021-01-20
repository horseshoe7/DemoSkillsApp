//
//  ChannelListItemTableCellModelTests.swift
//  DemoSkillsAppTests
//
//  Created by Stephen O'Connor on 20.01.21.
//

import XCTest
@testable import DemoSkillsApp

// the point of testing a view model is to make sure that the values you expect to be in the UI are correct.
// but the view model doesn't require you to actually have a UI present.

class ChannelListItemTableCellModelTests: XCTestCase {

    var testObject: ChannelListItemTableCellModel!
    
    override func setUpWithError() throws {
        // create a fixture from JSON, get a model to instantiate a view model
        
        guard let response: ChannelListResponse = Fixture.decodeJSON(fileName: "MockChannelList.json").result else { return XCTFail("Unable to decode")}
        
        testObject = ChannelListItemTableCellModel(model: response.channelList.first!)  // BBC News
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReadOnlyValues() {
        XCTAssertTrue(testObject.titleLabelText == testObject.model.name)
        XCTAssertTrue(testObject.lastWatched.contains("Last watched"))
        XCTAssertTrue(testObject.descriptionLabelText == testObject.model.channelDescription)
    }
}

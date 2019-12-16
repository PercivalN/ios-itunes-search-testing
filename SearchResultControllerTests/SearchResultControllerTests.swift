
//
//  SearchResultControllerTests.swift
//  iTunes SearchTests
//
//  Created by Percy Ngan on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import XCTest

@testable import iTunes_Search

/*
What can we test?
* network
* results - if data is correct
* decoding
* if results are saved properly
* completion handler
*/

class SearchResultControllerTests: XCTestCase {

	// Naive approach
	func testPerformSearchNaive() {
		print("Test started")
		let controller = SearchResultController()

		controller.performSearch(for: "Garage Band", resultType: .software) {
			XCTAssert(!controller.searchResults.isEmpty)
			print("Test finished")
		}
	}

	func testPerformSearch() {

		let controller = SearchResultController()

		let exp = expectation(description: "Wait for iTunes API to return")

		controller.performSearch(for: "Garage Band", resultType: .software) {
			XCTAssert(!controller.searchResults.isEmpty)
			exp.fulfill()
		}

		wait(for: [exp], timeout: 3)

		XCTAssertTrue(controller.searchResults.count > 0, "Expecting at least one result for Garage Band")
	}

	/*
	Usually using networking in unit tests isn't good idea
	Need to wait for API to finish and it can be slow
	Important with continuous integration - automate to test your apps
	*/

	func testSearchResultController() {

		let mock = MockDataLoader()
		mock.data = goodResultData

		let controller = SearchResultController(networkDataLoader: mock)
		let exp = self.expectation(description: "Wait for iTunes API to return")

		controller.performSearch(for: "Garage Band", resultType: .software) {
			XCTAssert(!controller.searchResults.isEmpty)
			exp.fulfill()
		}

		wait(for: [exp], timeout: 2)
		XCTAssertTrue(controller.searchResults.count > 0, "Expecting at least one result for Garage Band")

		/*
		"trackName": "GarageBand",
		"artistName": "Apple"
		*/

		XCTAssertEqual(controller.searchResults[0].title, "GarageBand")
		XCTAssertEqual(controller.searchResults[0].artist, "Apple")
	}

	func testBadJSONDecodingReturnsError() {

		let mock = MockDataLoader()
		mock.data = badResultData

		let controller = SearchResultController(networkDataLoader: mock)
		let exp = expectation(description: "Wait for iTunes API to return")

		controller.performSearch(for: "Garage Band", resultType: .software) {
			exp.fulfill()
		}

		wait(for: [exp], timeout: 2)

		XCTAssertTrue(controller.searchResults.isEmpty, "Expecting 2 results for Garage Band")
		XCTAssertNotNil(controller.error)
	}

	func testNoResults() {

		let mock = MockDataLoader()
		mock.data = badResultData

		let controller = SearchResultController(networkDataLoader: mock)
		let exp = expectation(description: "Wait for iTunes API to return")

		controller.performSearch(for: "abcdefg123", resultType: .software) {
			exp.fulfill()
		}

		wait(for: [exp], timeout: 2)

		XCTAssertTrue(controller.searchResults.isEmpty)
		XCTAssertNil(controller.error)
	}
}


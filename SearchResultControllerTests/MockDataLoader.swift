//
//  MockDataLoader.swift
//  SearchResultControllerTests
//
//  Created by Percy Ngan on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
@testable import iTunes_Search

class MockDataLoader: NetworkDataLoader {

	var data: Data?
	var response: URLResponse?
	var error: Error?

	//	init(data: Data?, response: URLResponse?, error: Error?) {
	//		self.data = data
	//		self.response = response
	//		self.error = error
	//	}

	func loadData(using request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
		// We don't want to use URLSession to get the data, instead we can get the data from mock JSON file

		// We want to wait 1 second before calling completion
		// WE mimic the network call which has a lag time

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion(self.data, self.response, self.error)
		}
	}
}

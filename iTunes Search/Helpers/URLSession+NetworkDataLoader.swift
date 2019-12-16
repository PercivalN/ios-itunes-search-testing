//
//  URLSession+NetworkDataLoader.swift
//  iTunes Search
//
//  Created by Percy Ngan on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

// We don't have source code for the URLSession, but we can extend the functionality

extension URLSession: NetworkDataLoader {

	// We forward those things to whatever is calling loadData

	func loadData(using request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
		dataTask(with: request) { (data, response, error) in
			completion(data, response, error)
		}.resume()
	}
}

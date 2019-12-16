//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Spencer Curtis on 8/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class SearchResultController {
	
	let baseURL = URL(string: "https://itunes.apple.com/search")!
	var searchResults: [SearchResult] = []
	
	/*
	What are the dependencies?
	* base URL
	* searchTerms
	* URL
	* Network - URLSession
	* decoder
	
	What can we test?
	* network
	* results - if data is correct
	* decoding
	* if results are saved properly
	* completion handler
	*/
	
	let dataLoader: NetworkDataLoader
	
	var error: Error?
	
	// Pass in the dataLoader and error
	// Most of the time we want URLSession.shared to be the data loader sometimes
	//
	init(networkDataLoader: NetworkDataLoader = URLSession.shared) {
		self.dataLoader = networkDataLoader
	}
	
	func performSearch(for searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
		
		// Create the URL components
		var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
		let parameters = ["term": searchTerm,
						  "entity": resultType.rawValue]
		let queryItems = parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
		urlComponents?.queryItems = queryItems
		
		guard let requestURL = urlComponents?.url else { return }
		
		// Create the URL request using the components
		var request = URLRequest(url: requestURL)
		request.httpMethod = HTTPMethod.get.rawValue
		
		// Offload the networking to another class/object
		// We can load data from whatever the data loader is
		dataLoader.loadData(using: request) { data, response, error in
			
			// Validate the information
			if let error = error { NSLog("Error fetching data: \(error)") }
			guard let data = data else { completion(); return }
			
			do {
				// Parsing data
				let jsonDecoder = JSONDecoder()
				let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
				
				// Save data
				self.searchResults = searchResults.results
			} catch {
				print("Unable to decode data into object of type [SearchResult]: \(error)")
				self.error = error
			}
			
			completion()
		}
	}
}

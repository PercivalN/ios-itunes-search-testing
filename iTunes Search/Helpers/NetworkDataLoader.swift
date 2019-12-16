//
//  NetworkDataLoader.swift
//  iTunes Search
//
//  Created by Percy Ngan on 12/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

// Allow us to decide whether we want to use actual
// network (data loading) via URl Session or mock data

protocol NetworkDataLoader {

	/*
	 Question: What do we need for data in/out?
	 Provide: URLRequest
	 Give back: Data and Error
	*/

	func loadData(using request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

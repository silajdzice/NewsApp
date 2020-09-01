//
//  NetworkProtocol.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation

protocol ResponseServiceDelegate: class {
    func responseSuccess<T: Decodable>(_ response: T?)
    func responseFailed(_ error: Error?, _ message: String?)
}

//
//  CoreError.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation


public enum CoreError: Error {
    case mapping
    case noInternet
    case unknown
    case unAuthenticated
    case badURL
    case googleLoginFailed
    case error(error: Error)
    case failed(reason: String)
}

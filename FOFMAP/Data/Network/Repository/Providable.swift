//
//  Providable.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/06.
//

import UIKit

protocol Providable {
    func receiveData<T: Decodable>(url: URL, isCached: Bool, by type: T.Type) async throws -> T
    func receiveImage(isCached: Bool, by url: URL) async throws -> UIImage
}

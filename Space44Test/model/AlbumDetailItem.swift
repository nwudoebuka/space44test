//
//  AlbumDetailItem.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 13/12/2021.
//

import Foundation

class AlbumDetailItem: Hashable {
    let photoURL: URL
    let thumbnailURL: String
    let totalLikes:Int
    let totalDescription:String
    init(photoURL: URL, thumbnailURL: String, totalLikes: Int, totalDescription:String) {
        self.photoURL = photoURL
        self.thumbnailURL = thumbnailURL
        self.totalLikes = totalLikes
        self.totalDescription = totalDescription
 }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func == (lhs: AlbumDetailItem, rhs: AlbumDetailItem) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  private let identifier = UUID()
}

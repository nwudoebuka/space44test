//
//  AlbumItem.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 13/12/2021.
//

import Foundation

class AlbumItem: Hashable {
  let albumURL: URL
  let albumTitle: String
  let imageItems: [AlbumDetailItem]

  init(albumURL: URL, imageItems: [AlbumDetailItem] = []) {
    self.albumURL = albumURL
    self.albumTitle = albumURL.lastPathComponent.displayNicely
    self.imageItems = imageItems
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  static func == (lhs: AlbumItem, rhs: AlbumItem) -> Bool {
    return lhs.identifier == rhs.identifier
  }

  private let identifier = UUID()
}


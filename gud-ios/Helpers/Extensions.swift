//
//  Helpers.swift
//  gud-ios
//
//  Created by sudofluff on 8/1/19.
//  Copyright © 2019 sudofluff. All rights reserved.
//

import UIKit

extension URL {
  static func inDocumentDirectory(filename: String) -> URL {
    let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    return URL(fileURLWithPath: dir, isDirectory: true).appendingPathComponent(filename)
  }
}

extension UITableView {
  func scrollsToTop() {
    let sortedIndexPaths = self.indexPathsForVisibleRows?.sorted(by: <)
    guard let firstAvailableIndexPath = sortedIndexPaths?.first else { return }
    self.scrollToRow(at: firstAvailableIndexPath, at: .top, animated: true)
  }
}

extension UICollectionView {
  func scrollsToTop() {
    let sortedIndexPaths = self.indexPathsForVisibleItems.sorted(by: <)
    guard let firstAvailableIndexPath = sortedIndexPaths.first else { return }
    self.scrollToItem(at: firstAvailableIndexPath, at: .top, animated: true)
  }
}

extension Date {
  var toString: String {
    return self.description
  }
}

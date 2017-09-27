//
//  additemdelegate.swift
//  myfirstsections
//
//  Created by havisha tiruvuri on 9/25/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

protocol additemDelegate: class {
    func itemSaved(by: additemViewController, quote: String, author: String, date: String, indexPath: NSIndexPath?)
    func cancelButtonPressed(by: additemViewController)
}

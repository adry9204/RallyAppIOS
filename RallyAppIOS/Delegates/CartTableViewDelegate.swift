//
//  CartTableViewDelegate.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

protocol CartTableViewDelegate: AnyObject{
    func itemSelectedAtIndex(dataAtIndex: CartModel, indexPath: IndexPath)
}

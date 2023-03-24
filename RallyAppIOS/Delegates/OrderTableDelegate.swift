//
//  OrderTableDelegate.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation

protocol OrderTableDelegate: AnyObject{
    func itemSelectedAtIndex(dataAtIndex: Order<User>, indexPath: IndexPath)
}

//
//  HomeTableViewDelegate.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-22.
//

import Foundation

protocol HomeTableViewDelegate: AnyObject{
    func tableItemSelected(dataAtCell: Menu, indexPath: IndexPath)
    func makeAlert(title: String, message: String)
}

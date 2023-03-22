//
//  BmiData.swift
//  BMI-Tracker-App
//
//  Created by Abraham Alfred Babu on 2022-12-13.
//  Student id  : 301270598
//
//  Desciprtion
//  _________________________________________________
//  A simple app that lets you calculate your bmi and
//  save it for later viewing and tracking purpose. It
//  also allows you to edit and delete previous entries

import Foundation
import UIKit

class RallyData {
    
    // data members
    var image: String
    var name: String
    
    var price: String
    
    var description: String
    
    
    // constructor
    init(image: String, name: String, price: String, description: String) {
        self.name = name
        self.image = image
        self.price = price
        self.description = description
        
    }
  
    

}

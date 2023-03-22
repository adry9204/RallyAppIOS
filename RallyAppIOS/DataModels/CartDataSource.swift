//
//  BmiDataSource.swift
//  BMI-Tracker-App
//
//  Created by Abraham Alfred Babu on 2022-12-13.
//

import Foundation

struct UserDefalutKeysCart{
    static let NAMES = "NAME"
    static let PRICES = "PRICE"
    static let DESCRIPTIONS = "DESCRIPTIONS"
    static let IMAGES = "IMAGES"
}

// data source that holds the data
class CartDataSource {
    
    var dataSource: Array<CartData>
    
    // constructors
    init(){
        self.dataSource = Array<CartData>()
    }
    
    init(dataSource: Array<CartData>) {
        self.dataSource = dataSource
    }
    
    
    // returns data at index
//    func getDataAt(at: Int) -> RallyData {
//        return dataSource[at]
//    }
    
    // adds a data to the front of Array
    func addDataToSource(data: CartData){
        if(dataSource.isEmpty){
            dataSource.append(data)
        }else{
            dataSource.insert(data, at: 0)
        }
    }
    
    
    
    
    
     //Loads data from useDefaults
    func loadData() {

        var tempDataSource:Array<CartData> = []

        let userDefaults = UserDefaults.standard
        let names = userDefaults.object(forKey: UserDefalutKeysCart.NAMES) as? [String] ?? []
        let prices = userDefaults.object(forKey: UserDefalutKeysCart.PRICES) as? [String] ?? []
        let descriptions = userDefaults.object(forKey: UserDefalutKeysCart.DESCRIPTIONS) as? [String] ?? []
        let images = userDefaults.object(forKey: UserDefalutKeysCart.IMAGES) as? [String] ?? []
    

        if(!names.isEmpty){

            for i in 0...names.count-1{
                let rallyData = CartData(
                    image: images[i],
                    name: names[i],
                    price: prices[i],
                    description: descriptions[i]
                    
                )
                tempDataSource.append(rallyData)
            }

            self.dataSource = tempDataSource
        }
    }
}

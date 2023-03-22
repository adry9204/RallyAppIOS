//
//  BmiDataSource.swift
//  BMI-Tracker-App
//
//  Created by Abraham Alfred Babu on 2022-12-13.
//

import Foundation

struct UserDefalutKeys{
    static let NAMES = "NAME"
    static let PRICES = "PRICE"
    static let DESCRIPTIONS = "DESCRIPTIONS"
    static let IMAGES = "IMAGES"
}

// data source that holds the data
class RallyDataSource {
    
    var dataSource: Array<RallyData>
    
    // constructors
    init(){
        self.dataSource = Array<RallyData>()
    }
    
    init(dataSource: Array<RallyData>) {
        self.dataSource = dataSource
    }
    
    
    // returns data at index
//    func getDataAt(at: Int) -> RallyData {
//        return dataSource[at]
//    }
    
    // adds a data to the front of Array
    func addDataToSource(data: RallyData){
        if(dataSource.isEmpty){
            dataSource.append(data)
        }else{
            dataSource.insert(data, at: 0)
        }
    }
    
    
    
    
    
     //Loads data from useDefaults
    func loadData() {

        var tempDataSource:Array<RallyData> = []

        let userDefaults = UserDefaults.standard
        let names = userDefaults.object(forKey: UserDefalutKeys.NAMES) as? [String] ?? []
        let prices = userDefaults.object(forKey: UserDefalutKeys.PRICES) as? [String] ?? []
        let descriptions = userDefaults.object(forKey: UserDefalutKeys.DESCRIPTIONS) as? [String] ?? []
        let images = userDefaults.object(forKey: UserDefalutKeys.IMAGES) as? [String] ?? []
    

        if(!names.isEmpty){

            for i in 0...names.count-1{
                let rallyData = RallyData(
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

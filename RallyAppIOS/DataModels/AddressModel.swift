//
//  AddressModel.swift
//  RallyAppIOS
//
//  Created by Abraham Alfred Babu on 2023-03-23.
//

import Foundation

struct Address: Decodable {
    let name, line1: String
    let line2: String?
    let country, province, postalCode: String
    let id: Int
    var selected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name, line1, line2, country, province, postalCode, id, selected
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        line1 = try container.decode(String.self, forKey: .line1)
        line2 = try container.decodeIfPresent(String.self, forKey: .line2)
        country = try container.decode(String.self, forKey: .country)
        province = try container.decode(String.self, forKey: .province)
        postalCode = try container.decode(String.self, forKey: .postalCode)
        id = try container.decode(Int.self, forKey: .id)
        selected = try container.decodeIfPresent(Bool.self, forKey: .selected) ?? false
    }
}



//
//  RadioctivyElement.swift
//  first
//
//  Created by Марк Шавловский on 04/07/2019.
//Copyright © 2019 BunBeauty. All rights reserved.
//

import Foundation
import RealmSwift

class RadioctivyElement: Object {
    
    @objc dynamic var id:String?
    @objc dynamic var name:String?
    @objc dynamic var periodOfDecay:String?
    @objc dynamic var titel:String?

//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

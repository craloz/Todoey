//
//  Category.swift
//  Todoey
//
//  Created by Carlos Lozano on 2/3/19.
//  Copyright © 2019 Carlos Lozano. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
  
  @objc dynamic var name: String = ""
  let items = List<Item>()
  
}

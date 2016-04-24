//
//  Spell.swift
//  DnDHelper
//
//  Created by Rita Fang on 4/21/16.
//  Copyright © 2016 Rita Fang. All rights reserved.
//

import UIKit

class Spell {
    // MARK: Properties
    
    var name: String
    var desc: String
    var level: Int
    var range: String
    var components: [String]
    var duration: String
    var concentration: Bool
    var casting_time: String
    var school: String
    var classes: [String]
    var oaths: [String]
    var ritual: Bool
    var prepared: Bool
    
    // MARK: Initialization
    
    init?(name: String, desc: String, level: Int, range: String, components: [String], duration: String, concentration: Bool, casting_time: String, school: String, classes: [String], oaths: [String], ritual: Bool) {
        self.name = name
        self.desc = desc
        self.level = level
        self.range = range
        self.components = components
        self.duration = duration
        self.concentration = concentration
        self.casting_time = casting_time
        self.school = school
        self.classes = classes
        self.oaths = oaths
        self.ritual = ritual
        self.prepared = false
        
        if name.isEmpty || level < 0 {
            return nil
        }
    }
    
    func setPrepared(isPrepared: Bool) {
        self.prepared = isPrepared
    }
}
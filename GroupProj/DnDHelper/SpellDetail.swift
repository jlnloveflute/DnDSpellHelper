//
//  SpellDetail.swift
//  DnDHelper
//
//  Created by Rita Fang on 4/21/16.
//  Copyright © 2016 Rita Fang. All rights reserved.
//

import UIKit

class SpellDetail: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var castLabel: UILabel!
    @IBOutlet var rangeLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var componentsLabel: UILabel!
    @IBOutlet var descriptionLabel: UITextView!
    
    var spell: Spell?
    
    func printSpell(spell: Spell) {
        nameLabel.text = spell.name
        
        var leveltext = "Level " + String(spell.level) + " " + spell.school.lowercaseString + " spell"
        if spell.ritual {
            leveltext += " (ritual)"
        }
        levelLabel.text = leveltext
        
        castLabel.text = "Casting time: " + spell.casting_time
        
        rangeLabel.text = "Range: " + spell.range
        
        var durationtext = "Duration: "
        if (spell.concentration) {
            durationtext += spell.duration + " (concentration)"
        }
        else {
            durationtext = spell.duration
        }
        durationLabel.text = durationtext
        
        var componentstext = "Components: "
        for comp in spell.components {
            componentstext += comp + ", "
        }
        if !componentstext.isEmpty {
            componentstext = String(componentstext.characters.dropLast())
            componentstext = String(componentstext.characters.dropLast())
        }
        componentsLabel.text = componentstext
        
        descriptionLabel.text = spell.desc
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        printSpell(spell!)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

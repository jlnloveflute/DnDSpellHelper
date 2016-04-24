//
//  SpellListTableViewController.swift
//  DnDHelper
//
//  Created by Rita Fang on 4/21/16.
//  Copyright © 2016 Rita Fang. All rights reserved.
//

import UIKit

class SpellListTableViewController: UITableViewController {
    var spells = [[Spell]]()
    var spellheadings = ["Cantrips", "1st Level Spells", "2nd Level Spells", "3rd Level Spells", "4th Level Spells", "5th Level Spells", "6th Level Spells", "7th Level Spells", "8th Level Spells", "9th Level Spells"]

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0 ..< 10  {
            spells.append([Spell]())
        }
        
        // Load the sample data.
        loadSampleSpells()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadSampleSpells() {
        let name1 = "Aid"
        let desc1 = "Your spell bolsters your allies with toughness and resolve. Choose up to three creatures within range. Each target's Max HP and current HP increase by 5 for the duration. When you cast this spell using a slot of 3rd level or higher, a target's HP increases by an addition 5 for each slot above 2nd."
        let level1 = 2
        let range1 = "30 ft"
        let components1 = ["V", "S", "M (a tiny strip of white cloth)"]
        let duration1 = "8 hours"
        let concentration1 = false
        let casting_time1 = "1 action"
        let school1 = "Abjuration"
        let classes1 = ["Druid", "Priest"]
        let oaths1 = [String]()
        let ritual1 = false
        
        let name2 = "Alter Self"
        let desc2 = "You can choose Aquatic Adaptation, Change Appearance, or Natural Weapons for the spell's duration. Aquatic Adaptation allows you to breathe underwater and grants a swim speed equal to walking speed. Change Appearance allows you to change the way others perceive you, but cannot change to another creature type or size. Natural Weapons grants you fangs, claws or the like to use as a natural attack with a +1 bonus to attack rolls and damage."
        let level2 = 2
        let range2 = "Self"
        let components2 = ["V", "S"]
        let duration2 = "Up to 1 hour"
        let concentration2 = true
        let casting_time2 = "1 action"
        let school2 = "Transmutation"
        let classes2 = ["Druid"]
        let oaths2 = [String]()
        let ritual2 = false
    
        let name3 = "Alarm"
        let desc3 = "Choose a door, window, or an area within range that is no larger than a 20-foot cube. Until the spell ends, an alarm alerts you whenever a Tiny or larger creature touches or enters the warded area. You can designate creatures to not trigger the alarm. A mental alarm alerts you if you are within 1 mile and wakes you if sleeping. An audible alarm produces a bell sound for 10 seconds within 60 feet."
        let level3 = 1
        let range3 = "30 feet"
        let components3 = ["V", "S", "M (a tiny bell and a piece of fine silver wire)"]
        let duration3 = "8 hours"
        let concentration3 = false
        let casting_time3 = "1 action"
        let school3 = "Transmutation"
        let classes3 = ["Ranger"]
        let oaths3 = [String]()
        let ritual3 = true
        
        
        let spell1 = Spell(name: name1, desc: desc1, level: level1, range: range1, components: components1, duration: duration1, concentration: concentration1, casting_time: casting_time1, school: school1, classes: classes1, oaths: oaths1, ritual: ritual1)!
        
        let spell2 = Spell(name: name2, desc: desc2, level: level2, range: range2, components: components2, duration: duration2, concentration: concentration2, casting_time: casting_time2, school: school2, classes: classes2, oaths: oaths2, ritual: ritual2)!
        
        let spell3 = Spell(name: name3, desc: desc3, level: level3, range: range3, components: components3, duration: duration3, concentration: concentration3, casting_time: casting_time3, school: school3, classes: classes3, oaths: oaths3, ritual: ritual3)!
        
    
        spells[1] = [spell3]
        spells[2] = [spell2, spell1]
        
    }
    
    @IBAction func cancelToSpellListViewController(segue:UIStoryboardSegue) {
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSpellDetail" {
            //print("Segueing?")
            let spellDetailViewController = segue.destinationViewController as! SpellDetailAdd
            // Get the cell that generated this segue.
            
            if let selectedSpellCell = sender as? SpellListViewCell {
                let indexPath = tableView.indexPathForCell(selectedSpellCell)!
                let selectedSpell = spells[indexPath.section][indexPath.row]
                spellDetailViewController.spell = selectedSpell
                //print("Checking detail")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return spells.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spells[section].count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SpellListViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SpellListViewCell
        
        let spell = spells[indexPath.section][indexPath.row]
        cell.nameLabel.text = spell.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return spellheadings[section]
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}

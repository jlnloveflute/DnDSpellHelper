//
//  FirstViewController.swift
//  DnDHelper
//
//  Created by Rita Fang on 4/2/16.
//
//

import UIKit
import SwiftyJSON
import Alamofire

let urlPath: String = "http://localhost:3000/"

class FirstViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var strLabel: UILabel!
    @IBOutlet var dexLabel: UILabel!
    @IBOutlet var conLabel: UILabel!
    @IBOutlet var intLabel: UILabel!
    @IBOutlet var wisLabel: UILabel!
    @IBOutlet var chaLabel: UILabel!
    
    func grabSheet() {
        let urlRequest: String = "items"
        let fullurlPath: String = urlPath + urlRequest
        Alamofire.request(.GET, fullurlPath, parameters:nil, encoding:.JSON).responseString
            { response in switch response.result {
            case .Success:
                
                if let value = response.result.value {
                    let json = JSON.parse(value)
                    let charName = json[0]["name"].stringValue
                    let charSTR = json[0]["ability scores"]["str"].intValue
                    let charDEX = json[0]["ability scores"]["dex"].intValue
                    let charCON = json[0]["ability scores"]["con"].intValue
                    let charINT = json[0]["ability scores"]["int"].intValue
                    let charWIS = json[0]["ability scores"]["wis"].intValue
                    let charCHA = json[0]["ability scores"]["cha"].intValue
                    self.writeName(charName)
                    self.writeStr(charSTR)
                    self.writeDex(charDEX)
                    self.writeCon(charCON)
                    self.writeInt(charINT)
                    self.writeWis(charWIS)
                    self.writeCha(charCHA)
                }
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                }
        }
    }
    
    func writeName(name: String) {
        nameLabel.text = name
    }
    
    func writeStr(n: Int) {
        strLabel.text = "STR: \(n)"
    }
    
    func writeDex(n: Int) {
        dexLabel.text = "DEX: \(n)"
    }
    
    func writeCon(n: Int) {
        conLabel.text = "CON: \(n)"
    }
    
    func writeInt(n: Int) {
        intLabel.text = "INT: \(n)"
    }
    
    func writeWis(n: Int) {
        wisLabel.text = "WIS: \(n)"
    }
    
    func writeCha(n: Int) {
        chaLabel.text = "CHA: \(n)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        grabSheet()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


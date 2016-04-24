//
//  SecondViewController.swift
//  DnDHelper
//
//  Created by Rita Fang on 4/3/16.
//  Copyright © 2016 Rita Fang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

//let urlPath: String = "http://localhost:3000/"

class SecondViewController: UIViewController {
    /*
    func grabSheet() {
        let urlRequest: String = "items"
        let fullurlPath: String = urlPath + urlRequest
        Alamofire.request(.GET, fullurlPath, parameters:nil, encoding:.JSON).responseString
            { response in switch response.result {
            case .Success:
                
                if let value = response.result.value {
                    let json = JSON.parse(value)
                }
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                }
        }
        
    }
    
    func getSkills(json: JSON) {
        let skillList = json[0]["skills"]
        let skillDict = ["", "", ""]
        //for (skill: String, list: )
        
    }
*/

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


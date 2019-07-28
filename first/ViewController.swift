//
//  ViewController.swift
//  first
//
//  Created by Марк Шавловский on 03/07/2019.
//  Copyright © 2019 BunBeauty. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    var elementNameList = [String]()
    var elementPeriodList = [String]()

    @IBOutlet weak var myTableView: UITableView!
    
    //return countOfRowsInTable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return elementNameList.count
    }
    // work with cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = elementNameList[indexPath.row]
        return cell
    }
    //selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        goToCalculator(_name: elementNameList[indexPath.row], _period:elementPeriodList[indexPath.row])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 2,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let realm = try! Realm()
        //road to DB
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        // put elemnt into database
        /*let radioctivityElement = RadioctivyElement()
        radioctivityElement.name = "Bronza"
        radioctivityElement.periodOfDecay = "230"
        radioctivityElement.titel = "BR"
        
       try! realm.write {
            realm.add(radioctivityElement)
        }*/
        
        //read element from databse
        let radioctivityElements = realm.objects(RadioctivyElement.self)
        //using filter equals WHERE
        //let radioctivityElements = realm.objects(RadioctivyElement.self).filter("name = 'Золото'")
        //sort 
        for element in radioctivityElements{
            elementNameList.append(element.name!)
            elementPeriodList.append(element.periodOfDecay!)
        }
    }

    func goToCalculator(_name:String, _period:String) -> Void  {
        let  calculatorVC = storyboard?.instantiateViewController(withIdentifier: "Calculator") as! Calculator
        calculatorVC.nameOfElement = _name
        calculatorVC.periodOfDecay = _period
        navigationController?.pushViewController(calculatorVC, animated: true)
    }
}


//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Developer on 10/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FilterViewControllerDelegate {
    @objc optional func userDidSet(filters:[String:Bool])
}

class FiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterViewCellDelegate {

    let categories:[Dictionary<String, String>] = [["name" : "Afghan", "code": "afghani"],
                      ["name" : "African", "code": "african"],
                      ["name" : "American, New", "code": "newamerican"],
                      ["name" : "American, Traditional", "code": "tradamerican"],
                      ["name" : "Arabian", "code": "arabian"],
                      ["name" : "Argentine", "code": "argentine"],
                      ["name" : "Armenian", "code": "armenian"],
                      ["name" : "Asian Fusion", "code": "asianfusion"],
                      ["name" : "Asturian", "code": "asturian"],
                      ["name" : "Australian", "code": "australian"],
                      ["name" : "Austrian", "code": "austrian"],
                      ["name" : "Baguettes", "code": "baguettes"],
                      ["name" : "Bangladeshi", "code": "bangladeshi"],
                      ["name" : "Barbeque", "code": "bbq"],
                      ["name" : "Basque", "code": "basque"],
                      ["name" : "Bavarian", "code": "bavarian"],
                      ["name" : "Beer Garden", "code": "beergarden"],
                      ["name" : "Beer Hall", "code": "beerhall"],
                      ["name" : "Beisl", "code": "beisl"],
                      ["name" : "Belgian", "code": "belgian"],
                      ["name" : "Bistros", "code": "bistros"],
                      ["name" : "Black Sea", "code": "blacksea"],
                      ["name" : "Brasseries", "code": "brasseries"],
                      ["name" : "Brazilian", "code": "brazilian"],
                      ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                      ["name" : "British", "code": "british"],
                      ["name" : "Buffets", "code": "buffets"],
                      ["name" : "Bulgarian", "code": "bulgarian"],
                      ["name" : "Burgers", "code": "burgers"],
                      ["name" : "Burmese", "code": "burmese"],
                      ["name" : "Cafes", "code": "cafes"],
                      ["name" : "Cafeteria", "code": "cafeteria"],
                      ["name" : "Cajun/Creole", "code": "cajun"],
                      ["name" : "Cambodian", "code": "cambodian"],
                      ["name" : "Canadian", "code": "New)"],
                      ["name" : "Canteen", "code": "canteen"],
                      ["name" : "Caribbean", "code": "caribbean"],
                      ["name" : "Catalan", "code": "catalan"],
                      ["name" : "Chech", "code": "chech"],
                      ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                      ["name" : "Chicken Shop", "code": "chickenshop"],
                      ["name" : "Chicken Wings", "code": "chicken_wings"],
                      ["name" : "Chilean", "code": "chilean"],
                      ["name" : "Chinese", "code": "chinese"],
                      ["name" : "Comfort Food", "code": "comfortfood"],
                      ["name" : "Corsican", "code": "corsican"],
                      ["name" : "Creperies", "code": "creperies"],
                      ["name" : "Cuban", "code": "cuban"],
                      ["name" : "Curry Sausage", "code": "currysausage"],
                      ["name" : "Cypriot", "code": "cypriot"],
                      ["name" : "Czech", "code": "czech"],
                      ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                      ["name" : "Danish", "code": "danish"],
                      ["name" : "Delis", "code": "delis"],
                      ["name" : "Diners", "code": "diners"],
                      ["name" : "Dumplings", "code": "dumplings"],
                      ["name" : "Eastern European", "code": "eastern_european"],
                      ["name" : "Ethiopian", "code": "ethiopian"],
                      ["name" : "Fast Food", "code": "hotdogs"],
                      ["name" : "Filipino", "code": "filipino"],
                      ["name" : "Fish & Chips", "code": "fishnchips"],
                      ["name" : "Fondue", "code": "fondue"],
                      ["name" : "Food Court", "code": "food_court"],
                      ["name" : "Food Stands", "code": "foodstands"],
                      ["name" : "French", "code": "french"],
                      ["name" : "French Southwest", "code": "sud_ouest"],
                      ["name" : "Galician", "code": "galician"],
                      ["name" : "Gastropubs", "code": "gastropubs"],
                      ["name" : "Georgian", "code": "georgian"],
                      ["name" : "German", "code": "german"],
                      ["name" : "Giblets", "code": "giblets"],
                      ["name" : "Gluten-Free", "code": "gluten_free"],
                      ["name" : "Greek", "code": "greek"],
                      ["name" : "Halal", "code": "halal"],
                      ["name" : "Hawaiian", "code": "hawaiian"],
                      ["name" : "Heuriger", "code": "heuriger"],
                      ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                      ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                      ["name" : "Hot Dogs", "code": "hotdog"],
                      ["name" : "Hot Pot", "code": "hotpot"],
                      ["name" : "Hungarian", "code": "hungarian"],
                      ["name" : "Iberian", "code": "iberian"],
                      ["name" : "Indian", "code": "indpak"],
                      ["name" : "Indonesian", "code": "indonesian"],
                      ["name" : "International", "code": "international"],
                      ["name" : "Irish", "code": "irish"],
                      ["name" : "Island Pub", "code": "island_pub"],
                      ["name" : "Israeli", "code": "israeli"],
                      ["name" : "Italian", "code": "italian"],
                      ["name" : "Japanese", "code": "japanese"],
                      ["name" : "Jewish", "code": "jewish"],
                      ["name" : "Kebab", "code": "kebab"],
                      ["name" : "Korean", "code": "korean"],
                      ["name" : "Kosher", "code": "kosher"],
                      ["name" : "Kurdish", "code": "kurdish"],
                      ["name" : "Laos", "code": "laos"],
                      ["name" : "Laotian", "code": "laotian"],
                      ["name" : "Latin American", "code": "latin"],
                      ["name" : "Live/Raw Food", "code": "raw_food"],
                      ["name" : "Lyonnais", "code": "lyonnais"],
                      ["name" : "Malaysian", "code": "malaysian"],
                      ["name" : "Meatballs", "code": "meatballs"],
                      ["name" : "Mediterranean", "code": "mediterranean"],
                      ["name" : "Mexican", "code": "mexican"],
                      ["name" : "Middle Eastern", "code": "mideastern"],
                      ["name" : "Milk Bars", "code": "milkbars"],
                      ["name" : "Modern Australian", "code": "modern_australian"],
                      ["name" : "Modern European", "code": "modern_european"],
                      ["name" : "Mongolian", "code": "mongolian"],
                      ["name" : "Moroccan", "code": "moroccan"],
                      ["name" : "New Zealand", "code": "newzealand"],
                      ["name" : "Night Food", "code": "nightfood"],
                      ["name" : "Norcinerie", "code": "norcinerie"],
                      ["name" : "Open Sandwiches", "code": "opensandwiches"],
                      ["name" : "Oriental", "code": "oriental"],
                      ["name" : "Pakistani", "code": "pakistani"],
                      ["name" : "Parent Cafes", "code": "eltern_cafes"],
                      ["name" : "Parma", "code": "parma"],
                      ["name" : "Persian/Iranian", "code": "persian"],
                      ["name" : "Peruvian", "code": "peruvian"],
                      ["name" : "Pita", "code": "pita"],
                      ["name" : "Pizza", "code": "pizza"],
                      ["name" : "Polish", "code": "polish"],
                      ["name" : "Portuguese", "code": "portuguese"],
                      ["name" : "Potatoes", "code": "potatoes"],
                      ["name" : "Poutineries", "code": "poutineries"],
                      ["name" : "Pub Food", "code": "pubfood"],
                      ["name" : "Rice", "code": "riceshop"],
                      ["name" : "Romanian", "code": "romanian"],
                      ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                      ["name" : "Rumanian", "code": "rumanian"],
                      ["name" : "Russian", "code": "russian"],
                      ["name" : "Salad", "code": "salad"],
                      ["name" : "Sandwiches", "code": "sandwiches"],
                      ["name" : "Scandinavian", "code": "scandinavian"],
                      ["name" : "Scottish", "code": "scottish"],
                      ["name" : "Seafood", "code": "seafood"],
                      ["name" : "Serbo Croatian", "code": "serbocroatian"],
                      ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                      ["name" : "Singaporean", "code": "singaporean"],
                      ["name" : "Slovakian", "code": "slovakian"],
                      ["name" : "Soul Food", "code": "soulfood"],
                      ["name" : "Soup", "code": "soup"],
                      ["name" : "Southern", "code": "southern"],
                      ["name" : "Spanish", "code": "spanish"],
                      ["name" : "Steakhouses", "code": "steak"],
                      ["name" : "Sushi Bars", "code": "sushi"],
                      ["name" : "Swabian", "code": "swabian"],
                      ["name" : "Swedish", "code": "swedish"],
                      ["name" : "Swiss Food", "code": "swissfood"],
                      ["name" : "Tabernas", "code": "tabernas"],
                      ["name" : "Taiwanese", "code": "taiwanese"],
                      ["name" : "Tapas Bars", "code": "tapas"],
                      ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                      ["name" : "Tex-Mex", "code": "tex-mex"],
                      ["name" : "Thai", "code": "thai"],
                      ["name" : "Traditional Norwegian", "code": "norwegian"],
                      ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                      ["name" : "Trattorie", "code": "trattorie"],
                      ["name" : "Turkish", "code": "turkish"],
                      ["name" : "Ukrainian", "code": "ukrainian"],
                      ["name" : "Uzbek", "code": "uzbek"],
                      ["name" : "Vegan", "code": "vegan"],
                      ["name" : "Vegetarian", "code": "vegetarian"],
                      ["name" : "Venison", "code": "venison"],
                      ["name" : "Vietnamese", "code": "vietnamese"],
                      ["name" : "Wok", "code": "wok"],
                      ["name" : "Wraps", "code": "wraps"],
                      ["name" : "Yugoslav", "code": "yugoslav"]]
    

    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate:FilterViewControllerDelegate?
    
    var tableViewCategoryDataBackArray = [Dictionary<String, String>]()
    var userSelectedFilter:[String:Bool]?
    var tableViewDataBackArray:[[String:Any]] = [["Header":"Deal",     "Cells":["Offering A Deal"]],
                                  ["Header":"Distance", "Cells":["0.3", "1", "5", "20"] ],
                                  ["Header":"Sort By", "Cells":["Best Match", "Distance", "Highest Rated"]]
                                  ]
    
    var categoryExpanded = false
    var sortExpanded = false
    var distanceExpanded = false
    
    func setupMockData(){
        self.tableViewDataBackArray.append(["Header":"Category", "Cells":categories])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupMockData()
        
        self.setupTableView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TableView Setup, Delegates, DataSource
    func setupTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    func updateTableView() { //here is a chance to update tableView data with filtered array.
        self.tableViewCategoryDataBackArray = self.categories
        
        self.tableView.reloadData()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewDataBackArray.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        
        case 0:  //Deals Section
            if let sectionArray = self.tableViewDataBackArray[section]["Cells"] as? [String] {
                return sectionArray.count
            }
        
        case 1: //Distance Section
            if self.distanceExpanded == false {
                return 1
            }
            else {
                if let sectionArray = self.tableViewDataBackArray[section]["Cells"] as? [String] {
                    return sectionArray.count
                }
            }
        case 2:  //Sort Section
            if self.sortExpanded == false {
                return 1
            }
            else {
                if let sectionArray = self.tableViewDataBackArray[section]["Cells"] as? [String] {
                    return sectionArray.count
                }
            }
        
        case 3:
            if self.categoryExpanded == false {
                return 4    //Show 4 category before clicking see more.
            }
            else {
                if let sectionArray = self.tableViewDataBackArray[section]["Cells"] as? [[String:String]] {
                    return sectionArray.count
                }
            }
        default:
            break
        }
        
        return 0
    }
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        case 0:  //Deals Section
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterViewCell", for: indexPath) as? FilterViewCell
            let cellsData = self.tableViewDataBackArray[indexPath.section]["Cells"] as? [String]
            cell?.filterLabel.text = cellsData?[indexPath.row]
            return cell!
        
        case 1://Distance Section
            if self.distanceExpanded == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterExpandCell", for: indexPath) as? FilterExpandCell
                //load user last selection
                cell?.filterLabel.text = "TEST"
                return cell!
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCheckCell", for: indexPath) as? FilterCheckCell
                let cellsData = self.tableViewDataBackArray[indexPath.section]["Cells"] as? [String]
                cell?.filterLabel.text = cellsData?[indexPath.row]
            return cell!
            }
        
        case 2: //Sort Section
            if self.sortExpanded == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterExpandCell", for: indexPath) as? FilterExpandCell
                //load user last selection
                cell?.filterLabel.text = "TEST"
                return cell!
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCheckCell", for: indexPath) as? FilterCheckCell
                let cellsData = self.tableViewDataBackArray[indexPath.section]["Cells"] as? [String]
                cell?.filterLabel.text = cellsData?[indexPath.row]
                return cell!
            }
        
        case 3:
            if self.categoryExpanded == false && indexPath.row == 3 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSeeMoreCell", for: indexPath) as? FilterSeeMoreCell
                return cell!
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterViewCell", for: indexPath) as? FilterViewCell
                cell?.delegate = self
                let cellsDataArray = self.tableViewDataBackArray[indexPath.section]["Cells"] as? [[String:String]]
                
                let categoryName = cellsDataArray?[indexPath.row]["name"]
                cell?.filterLabel.text = categoryName
                return cell!
            }
        default:
            return tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        }
    }
    
//    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "FOOTER"
//    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            
        case 0: //Deals Section

            print()
        case 1: //Distance Section

            print()

        case 2: //Sort Section

            if self.sortExpanded == false {
                self.sortExpanded = true
                self.reload(tableView: tableView, section: indexPath.section)
            }
            else {
                
            }

        case 3:
            if self.categoryExpanded == false && indexPath.row == 3 {
                self.categoryExpanded = true
                self.reload(tableView: tableView, section: indexPath.section)
            }
            else {
//                if let sectionArray = self.tableViewDataBackArray[section]["Cells"] as? [[String:String]] {
//                    return sectionArray.count
//                }
            }
        default:
            break
        }
    }
    
    func reload(tableView:UITableView, section:Int) {
        let indexSet = IndexSet(integer: section)
        self.tableView.reloadSections(indexSet as IndexSet, with: .fade)
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let header = self.tableViewDataBackArray[section]["Header"] as? String {
            return header
        }
        return ""
    }
    
    @IBAction func touchOnSave(_ sender: AnyObject) {
        
        if let savedFilter = self.userSelectedFilter {
            self.delegate?.userDidSet!(filters: savedFilter)
        }
        
        self.dismiss(animated: true) { 
            
        }
    }

    // MARK: - FilterViewCell Delegate
    
    func userDidChange(tableView: UITableView, for cell: FilterViewCell, to value: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {

            print("Selected IndexPath = \(indexPath)")

            if let filterCode = self.categories[indexPath.row]["code"] {
                
                if value == true {
                    self.userSelectedFilter?[filterCode] = true
                }
                else {
                    _ = self.userSelectedFilter?.removeValue(forKey: filterCode)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

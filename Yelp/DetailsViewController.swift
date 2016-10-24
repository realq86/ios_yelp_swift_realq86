


import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var business = Business(dictionary: ["":""])
    var businessDetail:BusinessDetail?
    var tableViewDataBackArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        // Do any additional setup after loading the view.
        
        self.callAPI()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func callAPI() {
        let id = self.business.id

        Business.searchBusiness(name: id!) { (businessDetail:BusinessDetail) in
            
            self.businessDetail = businessDetail
            self.tableView.reloadData()
        }
    }
    
    
    
    func setupTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if businessDetail == nil {
            return 0
        }
        else {
            return 3
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleImageCell", for: indexPath) as? TitleImageCell
            
            cell?.titleImage.setImageWith((businessDetail?.imageURL)!)
            cell?.titleLabel.text = business.name?.capitalized
                    return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneNumberCell", for: indexPath) as? PhoneNumberCell
            cell?.phoneLabel.text = businessDetail?.phoneNumber
            cell?.addressLabel.text = business.address
            return cell!
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell
            cell?.reviewImage.setImageWith(business.ratingImageURL!)
            
            cell?.reviewCount.text = (business.reviewCount?.stringValue)! + "  reviews"
            cell?.reviewSnip.text = businessDetail?.snippetText
            return cell!
        default:
            
            break
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return self.view.bounds.size.width*0.8
        }
        
        return UITableViewAutomaticDimension
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

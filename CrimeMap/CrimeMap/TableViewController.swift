//
//  TableViewController.swift
//  CrimeMap
//
//  Created by Jiatai Sun on 4/13/22.
//

import UIKit
import Parse
import Alamofire

class TableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Incidents")
        query.includeKey("reporter")
        query.limit = 50
        
        query.findObjectsInBackground { posts, Error in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        let post = posts[indexPath.row]
        
        cell.IncidentLabel.text = post["incident"] as? String
        cell.DetailLabel.text = post["detail"] as? String
        cell.LongtitudeLabel.text = post["Longtitude"] as? String
        cell.LatitudeLabel.text = post["Latitude"] as? String
        cell.LocationLabel.text = "Location:"
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

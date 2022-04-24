//
//  PostViewController.swift
//  CrimeMap
//
//  Created by Jiatai Sun on 4/13/22.
//

import UIKit
import Parse

class PostViewController: UIViewController {
    
    @IBOutlet weak var LocationField: UITextField!
    @IBOutlet weak var IncidentField: UITextField!
    @IBOutlet weak var DetailField: UITextField!
    @IBOutlet weak var LongtitudeField: UITextField!
    
    
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let incident = PFObject(className: "Incidents")
        incident["Longtitude"] = LongtitudeField.text;
        incident["Latitude"] = LocationField.text;
        incident["incident"] = IncidentField.text
        incident["detail"] = DetailField.text
        incident["reporter"] = PFUser.current()!
        
        incident.saveInBackground { success, Error in
            if success{
                print("saved!")
            } else{
                print("error!")
            }
        }
        
        self.dismiss(animated: true)
        self.presentingViewController?.dismiss(animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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

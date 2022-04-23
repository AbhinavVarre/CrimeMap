//
//  AnnotationInfoViewController.swift
//  CrimeMap
//
//  Created by Abhinav Varre on 4/16/22.
//

import UIKit

class AnnotationInfoViewController: UIViewController {
    
    @IBOutlet weak var crimeEventLabel: UILabel!

    @IBOutlet weak var crimeDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("this runs")
        crimeEventLabel.text = ""
        crimeDescription.text = ""

        // Do any additional setup after loading the view.
    }
    
    func setLabelAndDesc(label: String, desc: String)
    {
        
        crimeEventLabel.text = label
        crimeDescription.text = desc
        
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

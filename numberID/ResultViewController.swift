//
//  ResultViewController.swift
//  numberID
//
//  Created by Samuel Ailemen on 7/20/21.
//

import UIKit

class ResultViewController: UIViewController {

    var first_name = ""
    var last_name = ""
    var address = ""
    var city = ""
    var state = ""
    var zipcode = ""
    
    @IBOutlet weak var firstNameTxt: UITextField!
    
    @IBOutlet weak var lastNameTxt: UITextField!
    
    @IBOutlet weak var addressTxt: UITextField!
    
    @IBOutlet weak var cityTxt: UITextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nextBtn.layer.borderWidth = 1.5
        self.nextBtn.layer.borderColor = UIColor.white.cgColor
        
        self.firstNameTxt.text = first_name
        self.lastNameTxt.text = last_name
        self.addressTxt.text = address
        self.cityTxt.text = city
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

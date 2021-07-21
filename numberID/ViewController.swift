//
//  ViewController.swift
//  numberID
//
//  Created by Samuel Ailemen on 7/20/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import RappleProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var numberTxt: UITextField!
    var apiKey = "" //https://account.verified.ly
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        numberTxt.attributedPlaceholder = NSAttributedString(string:"Your Number here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.nextBtn.layer.borderWidth = 1.5
        self.nextBtn.layer.borderColor = UIColor.white.cgColor
    }

    @IBAction func nextStep(_ sender: Any) {
        //url https://api.verified.ly/v1/enrichment/number
        guard let number = self.numberTxt.text else {return}
        if !number.isEmpty {
            RappleActivityIndicatorView.startAnimating()
            let parameters = ["number": number,
                              "country": "US",
                              "apiKEY": apiKey]
            AF.request("https://api.verified.ly/v1/enrichment/number", method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
               
                switch response.result {
                case .success:
                if response.response?.statusCode == 200 {
                    RappleActivityIndicatorView.stopAnimation(completionIndicator: .success, completionLabel: "Success", completionTimeout: 1.0)
                    let json = try? JSON(data: response.data!)
                    guard let address = json!["Address"].string else {return}
                    guard let first_name = json!["First_name"].string else {return}
                    guard let last_name = json!["Last_name"].string else {return}
                    let location = json!["Location"]
                    guard let city = location["city"].string else {return}
                    
                    //Navigate to the next screen
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "resultVC") as! ResultViewController
                    vc.first_name = first_name
                    vc.last_name = last_name
                    vc.address = address
                    vc.city = city
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                else {
                    
                    //The request failed for whatever reason
                    RappleActivityIndicatorView.stopAnimation(completionIndicator: .failed, completionLabel: "Failed", completionTimeout: 1.0)
                    let json = try? JSON(data: response.data!)
                    guard let message = json!["message"].string else {return}
                    print(message)

                }
                    break
               // hud.dismiss(completion: nil)
                case .failure:
                    RappleActivityIndicatorView.stopAnimation(completionIndicator: .failed, completionLabel: "Failed", completionTimeout: 1.0)
                    print("Error getting a response")
                    break
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}


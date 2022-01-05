//
//  OrderDetailsViewController.swift
//  Isadora-Santos_COMP2125_FinalTerm_Ex-01
//
//  Created by user202443 on 12/12/21.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    /*-- Outlets -- */
    //order ID outlet
    @IBOutlet weak var textFieldOrderID: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var textFieldtotalPrice: UITextField!
    @IBOutlet weak var thanksMessage: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    
    var uName:String = ""
    var totalP:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomNumber()
        userName.text = uName
        textFieldtotalPrice.text = totalP
    }
    
    //action for button 'Save' to display Thank You message
    @IBAction func btnSaveTapped(_ sender: Any) {
        thanksMessage.text = "Thank you for your order! :)"
    }
    
    //random number generator function for order ID
    func randomNumber(){
        let rn = Int.random(in: 10...99)
        textFieldOrderID.text = String(rn)
    }
}

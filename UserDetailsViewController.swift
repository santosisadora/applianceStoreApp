//
//  UserDetailsViewController.swift
//  Isadora-Santos_COMP2125_FinalTerm_Ex-01
//
//  Created by user202443 on 12/12/21.
//

import UIKit

class UserDetailsViewController: UIViewController {

    /*-- Outlets -- */
    
    //user Name
    @IBOutlet weak var textFieldUserName: UITextField!
    //email address
    @IBOutlet weak var textFieldEmail: UITextField!
    //home address
    @IBOutlet weak var textFieldHomeAddress: UITextField!
    //Summary text view
    @IBOutlet weak var summary: UITextView!
    //button Next
    @IBOutlet weak var btnNextTapped: UIButton!
    //button Submit
    @IBOutlet weak var btnSubmit: UIButton!
    var summ:String = ""

    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var addressError: UILabel!
    @IBOutlet weak var totallbl: UILabel!
    var tl:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
        summary.text = summ
        totallbl.text = tl

    }
    
    func resetForm()
    {
        btnSubmit.isEnabled = false
        
        nameError.isHidden = false
        emailError.isHidden = false
        addressError.isHidden = false
        
        nameError.text = "Required!"
        emailError.text = "Please enter a valid email!"
        addressError.text = "Required!"
        
        textFieldUserName.text = ""
        textFieldEmail.text = ""
        textFieldHomeAddress.text = ""
    }
    
    
    /*-- Actions -- */
    
    //when event Editing changed for Name
    @IBAction func nameChanged(_ sender: Any) {
        if let name = textFieldUserName.text{
            if let errorMessage = invalidName(name){
                nameError.text = errorMessage
                nameError.isHidden = false
            }
            else{
                nameError.isHidden = true
            }
        }
        validationCheck()
    }
    
    //when event Editing changed for Email
    @IBAction func emailChanged(_ sender: Any) {
        if let email = textFieldEmail.text{
            if let errorMessage = invalidEmail(email){
                emailError.text = errorMessage
                emailError.isHidden = false
            }
            else{
                emailError.isHidden = true
            }
        }
        validationCheck()
    }
    
    //function that checks validation of email
    func invalidEmail(_ value:String) -> String?{
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value){
            return "Invalid email address."
        }
        return nil
    }
    
    //function that checks validation of name
    func invalidName(_ value:String) -> String?{
        if textFieldUserName.text?.isEmpty ?? true{
            return "Please enter your name."
        }
        return nil
    }
    
    //when event Editing changed for address
    @IBAction func addressChanged(_ sender: Any) {
        if let address = textFieldHomeAddress.text{
            if let errorMessage = invalidAddress(address){
                addressError.text = errorMessage
                addressError.isHidden = false
            }
            else{
                addressError.isHidden = true
            }
        }
        validationCheck()
    }
    
    //function that checks validation of name
    func invalidAddress(_ value:String) -> String?{
        if textFieldHomeAddress.text?.isEmpty ?? true{
            return "Please enter your address."
        }
        return nil
    }
    
    //button Next action
    @IBAction func btnNextTapped(_ sender: Any) {
        performSegue(withIdentifier: "segueToOrder", sender: self)
    }
    
    //Passing data to OrderDetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! OrderDetailsViewController
        vc.userName = textFieldUserName
        
        var vc1 = segue.destination as! OrderDetailsViewController
        vc1.uName = textFieldUserName.text!
        
        var vc2 = segue.destination as! OrderDetailsViewController
        vc2.totalP = totallbl.text!
    }
    
    //function to check input validations
    func validationCheck(){
        if emailError.isHidden && nameError.isHidden && addressError.isHidden{
            btnSubmit.isEnabled = true
            btnNextTapped.isEnabled = true
        }else{
            btnSubmit.isEnabled = false
            btnNextTapped.isEnabled = false
        }
    }
    
    //button Submit action
    @IBAction func btnSubmitTapped(_ sender: Any) {
            summary.text +=
                "\nUsername: " + textFieldUserName.text! +
                "\nEmail: " + textFieldEmail.text! +
                "\nAddress: " + textFieldHomeAddress.text!
    }
}


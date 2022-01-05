//
//  ApplianceDetailsViewController.swift
//  Isadora-Santos_COMP2125_FinalTerm_Ex-01
//
//  Created by user202443 on 12/12/21.
//

import UIKit

class ApplianceDetailsViewController: UIViewController {

    
    /*-- Outlets --*/
    
    //appliance ID
    @IBOutlet weak var textFieldApplianceID: UITextField!
    //appliance name
    @IBOutlet weak var textFieldApplianceName: UITextField!
    //price per item
    @IBOutlet weak var textFieldPrice: UITextField!
    //quantity
    @IBOutlet weak var textFieldQuantity: UITextField!
    //button Next
    @IBOutlet weak var btnNext: UIButton!
    
    //error message appliance name
    @IBOutlet weak var errorMessageApplianceName: UILabel!
    //error message price per item
    @IBOutlet weak var errorMessagePrice: UILabel!
    //error message quantity
    @IBOutlet weak var errorMessageQuantity: UILabel!

    @IBOutlet weak var subtot: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    /* viewDidLoad*/
    override func viewDidLoad() {
        super.viewDidLoad()
        randomNumber()
        resetForm()
        textFieldPrice.keyboardType = UIKeyboardType.numberPad
        textFieldQuantity.keyboardType = UIKeyboardType.numberPad
    }
    
    //random number generator for Appliance ID
    func randomNumber(){
        let rn = Int.random(in: 101...110)
        textFieldApplianceID.text = String(rn)
    }
    
    //function to reset form
    func resetForm(){
        btnNext.isEnabled = false
        
        errorMessageApplianceName.isHidden = false
        errorMessagePrice.isHidden = false
        errorMessageQuantity.isHidden = false
        
        errorMessageApplianceName.text = "Required."
        errorMessagePrice.text = "Invalid Price."
        errorMessageQuantity.text = "Mininum:1, Maximum:3"
        
        textFieldApplianceName.text = ""
        textFieldPrice.text = ""
        textFieldQuantity.text = ""
    }
    
    
    /*-- Actions --*/
    
    //action on the event Editing changed -> for name
    @IBAction func nameChanged(_ sender: Any) {
        if let name = textFieldApplianceName.text{
            if let errorMessage = invalidName(name){
                errorMessageApplianceName.text = errorMessage
                errorMessageApplianceName.isHidden = false
            }
            else{
                errorMessageApplianceName.isHidden = true
            }
        }
        validationCheck()    }
    
    //function that checks validation of name
    func invalidName(_ value:String) -> String?{
        if textFieldApplianceName.text?.isEmpty ?? true{
            return "Please enter appliance name."
        }
        return nil
    }

    //function to calculate sub-total
    func calculateSubTotal(){
        let price = (textFieldPrice.text! as NSString).intValue
        let quantity = (textFieldQuantity.text! as NSString).intValue
        let subTotal = price * quantity
        subtot.text = "\(Int(subTotal))"
    }
    
    //function to calculate total = subtotal+13%
    func calculateTotal(){
        let price = (textFieldPrice.text! as NSString).doubleValue
        let quantity = (textFieldQuantity.text! as NSString).doubleValue
        
        let subTotal = price * quantity
        subtot.text = "\(Double(subTotal))"
        
        let taxes13 = subTotal * 13 / 100
        let totalValue = price + taxes13
        
        lblTotal.text = "\(Double(totalValue))"
    }
    
    //action on event Editing changed -> for price
    @IBAction func priceChanged(_ sender: Any)
    {        if let price = textFieldPrice.text{
        if let errorMessage = invalidPrice(price){
            errorMessagePrice.text = errorMessage
            errorMessagePrice.isHidden = false
        }
        else{
            errorMessagePrice.isHidden = true
        }
    }
    validationCheck()
    calculateSubTotal()
    calculateTotal()
    }
    
    func invalidPrice(_ value:String) -> String?{
        if textFieldPrice.text == "0"{
            return "Price cannot be 0."
        }
        return nil
    }

    //action on event Editing changed -> for quantity
    @IBAction func quantityChanged(_ sender: Any) {
        if let quantity = textFieldQuantity.text{
            if let errorMessage = invalidQuantity(quantity){
                errorMessageQuantity.text = errorMessage
                errorMessageQuantity.isHidden = false
            }
            else{
                errorMessageQuantity.isHidden = true
            }
        }
        validationCheck()
        calculateSubTotal()
        calculateTotal()
    }
    
    func invalidQuantity(_ value:String) -> String?{
        let qt = (textFieldQuantity.text! as NSString).intValue
        if ( qt < 1 || qt > 3 ){
            return "Min 1. Max 3!"
        }
        return nil
    }
    
    
    func validationCheck(){
        if errorMessageApplianceName.isHidden && errorMessagePrice.isHidden && errorMessageQuantity.isHidden {
            btnNext.isEnabled = true
        }else{
            btnNext.isEnabled = false
        }
    }
    
    //action for button 'Next'
    @IBAction func btnNextTapped(_ sender: Any) {
        //resetForm()
        performSegue(withIdentifier: "segueToUser", sender: self)
        calculateSubTotal()
        calculateTotal()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! UserDetailsViewController
        vc.summ = "Appliance: " + textFieldApplianceName.text! +
                  "\nQuantity: " + textFieldQuantity.text! +
                  "\nPrice: " + textFieldPrice.text! +
                  "\nSub-Total: " + subtot.text!
        vc.tl = lblTotal.text!
    }
}

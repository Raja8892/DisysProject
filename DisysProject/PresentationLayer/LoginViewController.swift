//
//  ViewController.swift
//  DisysProject
//
//  Created by Moses on 12/08/19.
//  Copyright © 2019 Raja Inbam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mobileNoTextField: UITextField!
    @IBOutlet weak var unifiedTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var idbarahnoTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var empIDTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
        self.navigationItem.title = "Login"
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func loginAction(_ sender: Any) {
        
        guard let empId = self.empIDTextField.text, let name = self.nameTextField.text, let idbarahno = self.idbarahnoTextField.text, let emailaddress = self.emailAddressTextField.text, let unifiednumber = self.unifiedTextField.text, let mobileNO = self.mobileNoTextField.text else{
            return
        }
        
        if !self.checkEmptyInputData(){
            
            if !self.isValidEmail(emailStr: emailaddress){
                
               self.showAlert(With: "Invalid Email ID", message: "Please enter valid email format")
                
                return
            }
            
            let postData  = [DisysConstant.eid:Int(empId) ?? 0,
                             DisysConstant.name:name,
                             DisysConstant.idbarahno : Int(idbarahno) ?? 0,
                             DisysConstant.emailaddress : emailaddress,
                             DisysConstant.unifiednumber : Int(unifiednumber) ?? 0,
                             DisysConstant.mobileno : mobileNO
                ] as [String:Any]
            
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            DisysServiceHandler.loginService(with: postData, SuccessCallBack: { (serviceStatus, responseObj) in
                if serviceStatus {
                    if (responseObj["success"] as? Bool) ?? false{
                        
                        self.activityIndicator.stopAnimating()
                        let newsfeedsViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewsFeedViewController") as! NewsFeedViewController
                        self.navigationController?.pushViewController(newsfeedsViewController, animated: true)
                    }else{
                        
                        self.showAlert(With: "Service Error", message: responseObj["message"] as! String)
                        self.activityIndicator.stopAnimating()
                    }
                }
                
            }) { (error) in
                
                if error._code == -1009{
                    self.activityIndicator.stopAnimating()

                }
            }
            
        }
    }
    
    
    func checkEmptyInputData()-> Bool{
        
        var isTextfieldEmpty = false
        
        if let empID = self.empIDTextField.text , empID.isEmpty{
            isTextfieldEmpty = true
            self.empIDTextField.layer.borderColor = UIColor.red.cgColor
            self.empIDTextField.layer.borderWidth = 2.0
            self.empIDTextField.placeholder = "Please enter eID"
        }
        
        if let name = self.nameTextField.text , name.isEmpty{
            isTextfieldEmpty = true
            self.nameTextField.layer.borderColor = UIColor.red.cgColor
            self.nameTextField.layer.borderWidth = 2.0
            self.nameTextField.placeholder = "Please enter name"
        }
        
        if let idbarahno = self.idbarahnoTextField.text , idbarahno.isEmpty{
            isTextfieldEmpty = true
            self.idbarahnoTextField.layer.borderColor = UIColor.red.cgColor
            self.idbarahnoTextField.layer.borderWidth = 2.0
            self.idbarahnoTextField.placeholder = "Please enter idbarahno"
        }
        
        if let emailAddress = self.emailAddressTextField.text , emailAddress.isEmpty{
            isTextfieldEmpty = true
            self.emailAddressTextField.layer.borderColor = UIColor.red.cgColor
            self.emailAddressTextField.layer.borderWidth = 2.0
            self.emailAddressTextField.placeholder = "Please enter emailAddress"
        }
        
        if let unifiedID = self.unifiedTextField.text , unifiedID.isEmpty{
            isTextfieldEmpty = true
            self.unifiedTextField.layer.borderColor = UIColor.red.cgColor
            self.unifiedTextField.layer.borderWidth = 2.0
            self.unifiedTextField.placeholder = "Please enter unifiedID"
        }
        
        if let mobileNo = self.mobileNoTextField.text , mobileNo.isEmpty{
            isTextfieldEmpty = true
            self.mobileNoTextField.layer.borderColor = UIColor.red.cgColor
            self.mobileNoTextField.layer.borderWidth = 2.0
            self.mobileNoTextField.placeholder = "Please enter mobileNo"
        }
        return isTextfieldEmpty
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailAddressFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailAddressFormat)
        return emailPredicate.evaluate(with: emailStr)
    }
    
    func showAlert(With titleMsg:String, message:String){
        
        let alertErrorMsg = UIAlertController.init(title: titleMsg, message: message, preferredStyle: UIAlertController.Style.alert)
        alertErrorMsg.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertErrorMsg, animated: true)
    }
    
}

extension LoginViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0.0
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.layer.borderWidth = 0.0
        return true
    }
}


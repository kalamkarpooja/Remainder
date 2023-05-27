//
//  AddViewController.swift
//  Remainder
//
//  Created by Mac on 17/05/17.
//

import UIKit

class AddViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var titleField : UITextField!
    @IBOutlet var bodyField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
     
    public var completion: ((String,String,Date) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        bodyField.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(didTapSaveBtn))
        
        
    }
    @objc func didTapSaveBtn(){
        if let titletext = titleField.text,!titletext.isEmpty,
           let bodyText = bodyField.text,!titletext.isEmpty{
            let targetDate = datePicker.date
            
            completion?(titletext,bodyText,targetDate)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
       return true
    }

}

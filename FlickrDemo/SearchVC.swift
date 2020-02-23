//
//  SearchVC.swift
//  FlickrDemo
//
//  Created by Nier on 2020/2/22.
//  Copyright © 2020 Nier. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet var conditionText: UITextField!
    @IBOutlet var countNumberText: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC: ResultVC = segue.destination as! ResultVC
        
        resultVC.condition = conditionText.text
        resultVC.countNumber = countNumberText.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        self.view.endEditing(true)
    }

}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var textFieldReturn: Bool = false
        var condition: String!
        var countNumber: String!
        
        if textField == conditionText {
            condition = (textField.text?.dropLast(range.length) ?? "") + string
            countNumber = countNumberText.text ?? "0"
            textFieldReturn = true
        } else {
            condition = conditionText.text ?? ""
            countNumber = (textField.text?.dropLast(range.length) ?? "") + string
            if countNumber == "" || Int(countNumber) != nil {
                textFieldReturn = true
            }
        }
        
        if condition.count > 0 && countNumber.count > 0 && Int(countNumber) != nil && Int(countNumber)! > 0 {
            searchButton.isEnabled = true
            searchButton.backgroundColor = .systemBlue
        } else {
            searchButton.isEnabled = false
            searchButton.backgroundColor = .lightGray
        }
        
        return textFieldReturn
    }
    
}

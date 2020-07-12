//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.1
    var splitTotal = "0.00"
    var tipPercent: String = "10%"


    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        tip = Double(String(sender.currentTitle!.dropLast()))! / 100
        tipPercent = sender.currentTitle!
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: Any) {
        let amount = Double(billTextField.text!) ?? 0.00
        let people = Double(splitNumberLabel.text!)!
        let total = (tip + 1) * amount / people
        
        splitTotal = String(format: "%.2f", total)
        
        self.performSegue(withIdentifier: "showResults", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.total = splitTotal
            destinationVC.totalPeople = splitNumberLabel.text
            destinationVC.tipPercent = tipPercent
        }
    }
}


//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Desmond Ofori Atta on 8/18/21.
//

import UIKit

class ViewController: UIViewController, DataEnteredDelegate {
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var numberController: UIStepper!
    @IBOutlet weak var partySizeLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var amountPerPersonLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var tipPercentages = [0.08, 0.12, 0.18]
    var currencySymbol = "$"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberController.autorepeat = true
        numberController.minimumValue = 1
        billAmountTextField.adjustsFontSizeToFitWidth = true
        billAmountTextField.becomeFirstResponder()
        self.title = "Tip Calculator"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func calculateTotalAmount(_ sender: UITextField) {
        calculateTip(AnyObject.self)
    }
    
    @IBAction func partySizeControl(_ sender: UIStepper) {
        partySizeLabel.text = Int(sender.value).description
        calculateTip(AnyObject.self)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        //Get current bill amount
        let bill = Double(billAmountTextField.text!) ?? 0
        
        //Calculate tips
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let partySize = Int(partySizeLabel.text!) ?? 0
        let perPerson = total / Double(partySize)
        
        //Update fields
        tipAmountLabel.text = currencySymbol + String(format: " %.2f", tip)
        totalAmountLabel.text = currencySymbol + String(format: " %.2f", total)
        amountPerPersonLabel.text = currencySymbol + String(format: " %.2f", perPerson)
    }
    
    //Send current to settingsview and receive new tips
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.delegate = self
        settingsViewController.receivedTips = tipPercentages
    }
    
    //Make changes to the received new tips
    func currencySelected(currency: String!) {
        currencySymbol = getSymbol(forCurrencyCode: currency) ?? "$"
        calculateTip(AnyObject.self)
    }
    
    func tipsChanged (newTips: Array<Double>) {
        for index in 0..<newTips.count {
            tipPercentages[index] = newTips[index] / 100.0
        }
        changeTipControlSegments(newTips)
        calculateTip(AnyObject.self)
    }
    
    //Change the title for the percentages in the tipControl
    func changeTipControlSegments(_ sender: Array<Double>){
        for i in 0...2 {
            tipControl.setTitle(String(sender[i])+"%", forSegmentAt: i)
        }
    }
    
    //Get currency symbol
    func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }

}

//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Desmond Ofori Atta on 8/18/21.
//

import UIKit

extension Formatter {
    static let number = NumberFormatter()
}
extension Locale {
    static let englishUS: Locale = .init(identifier: "en_US")
    static let frenchFR: Locale = .init(identifier: "fr_FR")
    static let portugueseBR: Locale = .init(identifier: "pt_BR")
}

//Get thousand separator
extension Numeric {
    func formatted(with groupingSeparator: String? = ",", style: NumberFormatter.Style, locale: Locale = .current) -> String {
        Formatter.number.locale = locale
        Formatter.number.numberStyle = style
        if let groupingSeparator = groupingSeparator {
            Formatter.number.groupingSeparator = groupingSeparator
        }
        return Formatter.number.string(for: self) ?? ""
    }
    // Localized
    var currency:   String { formatted(style: .currency) }
    var calculator: String { formatted(style: .decimal) }
}

class ViewController: UIViewController, DataEnteredDelegate {
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var numberController: UIStepper!
    @IBOutlet weak var partySizeLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var amountPerPersonLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var tipPercentages = [8.0, 12.0, 18.0]   //Initial tips
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberController.autorepeat = true
        numberController.minimumValue = 1
        billAmountTextField.adjustsFontSizeToFitWidth = true
        billAmountTextField.becomeFirstResponder()
        self.title = "Tip Calculator"
    }
    
    //Animations
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    //Get tip and totals as user type
    @IBAction func calculateTotalAmount(_ sender: UITextField) {
        calculateTip(AnyObject.self)
    }
    
    //Get number of guests
    @IBAction func partySizeControl(_ sender: UIStepper) {
        partySizeLabel.text = Int(sender.value).description
        calculateTip(AnyObject.self)
    }
    
    //calculate and update total and tips
    @IBAction func calculateTip(_ sender: Any) {
        //Get current bill amount
        let bill = Double(billAmountTextField.text!) ?? 0
        
        //Calculate tips
        let tip = bill * (tipPercentages[tipControl.selectedSegmentIndex] / 100.0)
        let total = bill + tip
        let partySize = Int(partySizeLabel.text!) ?? 0
        let perPerson = total / Double(partySize)
        
        //Update fields
        tipAmountLabel.text = tip.currency
        totalAmountLabel.text = total.currency
        amountPerPersonLabel.text = perPerson.currency
    }
    
    //Send current to settingsview and receive new tips
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.delegate = self
        settingsViewController.receivedTips = tipPercentages
    }
    
    func tipsChanged (newTips: Array<Double>) {
        for index in 0..<newTips.count {
            tipPercentages[index] = newTips[index]
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

}

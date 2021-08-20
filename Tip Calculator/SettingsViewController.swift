//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Desmond Ofori Atta on 8/18/21.
//

import UIKit

// Protocol used for sending data back
protocol DataEnteredDelegate: AnyObject {
    func tipsChanged(newTips: Array<Double>)
    func currencySelected(currency: String!)
}

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Making this a weak variable, so that it won't create a strong reference cycle
    weak var delegate: DataEnteredDelegate? = nil
    
    @IBOutlet weak var tip1Label: UITextField!
    @IBOutlet weak var tip2Label: UITextField!
    @IBOutlet weak var tip3Label: UITextField!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var picker: UIPickerView!
    
    var receivedTips: Array<Double> = []
    var sendTips = [Double](repeating: 0.0, count:3)
    var selectedCurrency: String!
    
    //Let User choose currency
    let currencies = ["USD", "GBP", "CAD", "EUR", "JPY", "CHF"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        delegate?.currencySelected(currency: currencies[row])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tip1Label.text = String(receivedTips[0]*100)
        tip2Label.text = String(receivedTips[1]*100)
        tip3Label.text = String(receivedTips[2]*100)
        
        picker.delegate = self
        picker.dataSource = self
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
    
    //Pass new tips back to main view controller
    @IBAction func changeTips(_ sender: Any) {
        sendTips[0] = Double(tip1Label.text!) ?? 0.0
        sendTips[1] = Double(tip2Label.text!) ?? 0.0
        sendTips[2] = Double(tip3Label.text!) ?? 0.0
        
        delegate?.tipsChanged(newTips: sendTips)
    }
    

    
    @IBAction func switchMode(_ sender: UISwitch) {
        if sender.isOn {
            overrideUserInterfaceStyle = .light//LightMode
//            self.view.backgroundColor = UIColor.white
        } else {
            overrideUserInterfaceStyle = .dark//Dark mode
//            let darkModeColor = UIColor(rgb: 0x161618)
//            self.view.backgroundColor = darkModeColor
        }
    }
}

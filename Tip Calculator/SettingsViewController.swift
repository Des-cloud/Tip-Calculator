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
}

class SettingsViewController: UIViewController {
    
    // Making this a weak variable, so that it won't create a strong reference cycle
    weak var delegate: DataEnteredDelegate? = nil
    
    @IBOutlet weak var tip1Label: UITextField!
    @IBOutlet weak var tip2Label: UITextField!
    @IBOutlet weak var tip3Label: UITextField!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    var receivedTips: Array<Double> = []
    var sendTips = [Double](repeating: 0.0, count:3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tip1Label.text = String(receivedTips[0])
        tip2Label.text = String(receivedTips[1])
        tip3Label.text = String(receivedTips[2])
    }
    
    //animations
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
    
    //Pass new tips back to main view controller
    @IBAction func changeTips(_ sender: Any) {
        sendTips[0] = Double(tip1Label.text!) ?? 0.0
        sendTips[1] = Double(tip2Label.text!) ?? 0.0
        sendTips[2] = Double(tip3Label.text!) ?? 0.0
        
        delegate?.tipsChanged(newTips: sendTips)
    }
    

    //Switch themes
    @IBAction func switchMode(_ sender: UISwitch) {
        if sender.isOn {
            overrideUserInterfaceStyle = .light     //LightMode
        } else {
            overrideUserInterfaceStyle = .dark      //Dark mode
        }
    }
}

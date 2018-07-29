//
//  ViewController.swift
//  PractiseLocalization
//
//  Created by Sunny Chowdhury on 7/19/18.
//  Copyright © 2018 Sunny Chowdhury. All rights reserved.
//

import UIKit
import Localize_Swift

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mySegentController: UISegmentedControl!
    
    @IBOutlet weak var changeButton: UIButton!
    
    let availableLanguages = Localize.availableLanguages()
    
    // Add an observer for LCLLanguageChangeNotification on viewWillAppear. This is posted whenever a language changes and allows the viewcontroller to make the necessary UI updated. Very useful for places in your app when a language change might happen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
    }

    
    @objc func setText() {
        titleLabel.text = "Hello".localized()
        changeButton.setTitle("Change".localized(using: "ButtonTitles"), for: UIControlState.normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeLanguageBySegmentController(_ sender: Any) {
        switch mySegentController.selectedSegmentIndex {
        case 0:
            
            Localize.setCurrentLanguage(availableLanguages[0])
        default:
            Localize.setCurrentLanguage(availableLanguages[1])

        }
    }
    
    @IBAction func changedLanguageWithButton(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: "Switch Language", preferredStyle: UIAlertControllerStyle.actionSheet)
        for language in availableLanguages {
            let displayName = Localize.displayNameForLanguage(language)
            let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                Localize.setCurrentLanguage(language)
            })
            actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
}


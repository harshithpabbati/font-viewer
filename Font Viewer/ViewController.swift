//
//  ViewController.swift
//  Font Viewer
//
//  Created by Harshith on 30/03/20.
//  Copyright © 2020 Harshith. All rights reserved.
//

import Cocoa
 

class ViewController: NSViewController {
    
    func setupUI() {
        fontFamiliesPopup.removeAllItems()
        fontTypesPopup.removeAllItems()
        sampleLabel.stringValue = ""
        sampleLabel.alignment = .center
    }
    
    func populateFontFamilies() {
        fontFamiliesPopup.removeAllItems()
        fontFamiliesPopup.addItems(withTitles: NSFontManager.shared.availableFontFamilies)
        handleFontFamilySelection(self)
    }
    
    func updateFontTypesPopup() {
        fontTypesPopup.removeAllItems()
     
        for member in fontFamilyMembers {
            if let fontType = member[1] as? String {
                fontTypesPopup.addItem(withTitle: fontType)
            }
        }
        fontTypesPopup.selectItem(at: 0)
        handleFontTypeSelection(self)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
     
        setupUI()
        populateFontFamilies()
        view.window?.title = "Fonts"
    }
    var selectedFontFamily: String?

    var fontFamilyMembers = [[Any]]()
        
    @IBOutlet weak var fontFamiliesPopup: NSPopUpButton!
     
    @IBOutlet weak var fontTypesPopup: NSPopUpButton!
     
    @IBOutlet weak var sampleLabel: NSTextField!
    
    @IBAction func handleFontFamilySelection(_ sender: Any) {
        if let fontFamily = fontFamiliesPopup.titleOfSelectedItem {
        
               selectedFontFamily = fontFamily
        
               if let members = NSFontManager.shared.availableMembers(ofFontFamily: fontFamily) {
                   fontFamilyMembers.removeAll()
                   fontFamilyMembers = members
                   updateFontTypesPopup()
               }
           }
    }
     
     
    @IBAction func handleFontTypeSelection(_ sender: Any) {
        let selectedMember = fontFamilyMembers[fontTypesPopup.indexOfSelectedItem]
     
        if let weight = selectedMember[2] as? Int, let traits = selectedMember[3] as? UInt, let fontfamily = selectedFontFamily {
     
            let font = NSFontManager.shared.font(withFamily: fontfamily,
                                                 traits: NSFontTraitMask(rawValue: traits),
                                                 weight: weight,
                                                 size: 40.0)
            sampleLabel.font = font
            sampleLabel.stringValue = "Hello World!"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


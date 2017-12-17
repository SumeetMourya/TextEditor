//
//  ViewController.swift
//  TextEditorDemo
//
//  Created by Sumeet Mourya on 27/11/17.
//  Copyright © 2017 Sumeet Mourya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lineSlider: UISlider!
    @IBOutlet var tabGeasture: UITapGestureRecognizer!
    @IBOutlet var editingView: ExpandingTextEditor!
    @IBOutlet var lblPreviewModeDescription: UILabel!
    @IBOutlet var lblNumberOfLines: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editingView.delegate = self
        editingView.setEditorTextValue = ""
//        editingView.txtVEditor.layer.cornerRadius = 3
//        editingView.txtVEditor.layer.masksToBounds = true
//        editingView.txtVEditor.backgroundColor = UIColor.yellow
        editingView.setPreviewModeOfEditor(previewMode: true)
        editingView.setHideCharacterLimit(value: false)
        editingView.setFontToSendButton(font: UIFont(name: "HelveticaNeue", size: 14.0)!)
        editingView.setTextToSendButton(text: "Send", selected: false)
        editingView.setHideSendBTN(isHidden: false)
        editingView.setTextColorToSendButton(color: UIColor.purple)
        lblNumberOfLines.text = "\(editingView.maxLinesNum)"
        lblPreviewModeDescription.text = "In Preview mode you can not edit text"
        lineSlider.value = Float(editingView.maxLinesNum)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionOnShowSendBTN(_ sender: UISwitch) {
        editingView.setHideSendBTN(isHidden: !sender.isOn)
    }
    
    @IBAction func actionOnCharacterLimit(_ sender: UISwitch) {
        editingView.setHideCharacterLimit(value: !sender.isOn)
    }
    
    @IBAction func actionOnPreviewMode(_ sender: UISwitch) {
        editingView.setPreviewModeOfEditor(previewMode: sender.isOn)
        if sender.isOn {
            lblPreviewModeDescription.isHidden = false
            lblPreviewModeDescription.text = "In Preview mode you can not edit text"
        } else {
            lblPreviewModeDescription.isHidden = true
        }
    }
    
    @IBAction func sliderUpdate(_ sender: UISlider) {
        self.lblNumberOfLines.text = "\(Int(sender.value))"
        editingView.setNumberOfLines(lines: Int(sender.value))
    }
    
    @IBAction func handlerGestureOnSelf(_ sender: UITapGestureRecognizer) {
        self.tabGeasture.isEnabled = false
        self.view.endEditing(true)
    }
}


extension ViewController: ExpandingTextEditorDelegate{
    
    func handleSendBTNAction(textValue: String) {
        
    }
    
    func textModified(textValue: String) {
        
    }
    
    func textEditingDone(textValue: String) {
        self.tabGeasture.isEnabled = false
    }
    
    func textEditingStarted(textValue: String) {
        self.tabGeasture.isEnabled = true
    }

}


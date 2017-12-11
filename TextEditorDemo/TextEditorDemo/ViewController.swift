//
//  ViewController.swift
//  TextEditorDemo
//
//  Created by Sumeet Mourya on 27/11/17.
//  Copyright © 2017 Sumeet Mourya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var editingView: ExpandingTextEditor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editingView.setEditorTextValue = "sdaf jknsafkdsnf jklsdaf ndasjfkl mndsa fjkldmsa,fn dsjakflm anadsfjkl mansdjfklm nasdfjkldnasf kjlasdnf jkdsalmf,n sladjkfm ,nasjfdklmf, ndsakjf msadf sdaf jknsafkdsnf jklsdaf ndasjfkl mndsa fjkldmsa,fn dsjakflm anadsfjkl mansdjfklm nasdfjkldnasf kjlasdnf jkdsalmf,n sladjkfm ,nasjfdklmf, ndsakjf msadf "
        editingView.setPreviewModeOfEditor(previewMode: true)
        editingView.setHideCharacterLimit(value: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionOnCharacterLimit(_ sender: UISwitch) {
        editingView.setHideCharacterLimit(value: !sender.isOn)
    }
    
    @IBAction func actionOnPreviewMode(_ sender: UISwitch) {
        editingView.setPreviewModeOfEditor(previewMode: sender.isOn)
    }
    
}


extension ViewController: ExpandingTextEditorDelegate{
    func textModified(textValue: String) {
        
    }
    
    func textEditingDone(textValue: String) {
        
    }
    
    func textEditingStarted(textValue: String) {
        
    }
    
    
   
}

//
//  ExpandingTextEditor.swift
//  Demo
//
//  Created by Sumeet Mourya on 11/09/17.
//  Copyright © 2017 Sumeet Mourya. All rights reserved.
//


/*
                                   (Self)
 ----------------------------------------------------------------------------------
 |                            layoutTopPadding                                L   |
 |      --------------------------------------------------------------- ___   a   |
 |      |                                                             |  |    y   |
 |      |                                                             |  |    o   |
 |   L  |                                                             |  |    u   |
 |   a  |                                                             |  |    t   |
 |   y  |                                                             |  |------------>layoutMinimumHeightOfEditor
 |   o  |                                                             |  |------------>layoutExactHeightOfEditingArea
 |   u  |                                                             |  |    R   |
 |   t  |                                                             |  |    i   |
 |   L  |                                                             |  |    g   |
 |   e  |                                                             |  |    h   |
 |   f  |                                                             |  |    t   |
 |   t  --------------------------------------------------------------- ---   P   |
 |   P                                0                                       a   |
 |   a  --------------------------------------------------------------- ___   d   |
 |   d  |                                                             |  |    d   |
 |   d  |                   (saperator Line View)                     |  |----------->layoutSaperatorViewHeight
 |   i  |                                                             |  |    i   |
 |   n  --------------------------------------------------------------- ---   n   |
 |   g                layoutVerticalGapBTWLimitTXT2Saperator                  g   |
 |                                     -------------------------------- ___       |
 |                                     |      (Character Limit Text)  |  |--------->layoutCharacterLimitHeight
 |                                     -------------------------------|-----------|
 |                                                                           ^    |
 |                          layoutBottomPadding                              |    |
 ----------------------------------------------------------------------------|-----
                                                                             |
                                                                             |
                                                                layoutRightPadding2LimitText
*/


import UIKit

protocol ExpandingTextEditorDelegate : class, NSObjectProtocol {
    
    func textModified(textValue: String)
    func textEditingDone(textValue: String)
    func textEditingStarted(textValue: String)
    func handleSendBTNAction(textValue: String)

}

@IBDesignable

class ExpandingTextEditor: UIView {

    var minimumHeightOfTxtEditor: CGFloat = 0
    var delegate: ExpandingTextEditorDelegate?
    private var isHiddenCharacterLimitText: Bool = false

    @IBOutlet var txtVEditor: UITextView!
    @IBOutlet var lblCharactersLimit: UILabel!
    @IBOutlet var placeholderLabel: UILabel!
    @IBOutlet var vSepratorViewBTWTextView2LimitView: UIView!
    @IBOutlet var sendBTN: UIButton!

    @IBOutlet var layoutTopPadding: NSLayoutConstraint!
    @IBOutlet var layoutLeftPadding: NSLayoutConstraint!
    @IBOutlet var layoutRightPadding: NSLayoutConstraint!
    @IBOutlet var layoutBottomPadding: NSLayoutConstraint!
    
    @IBOutlet var layoutVerticalGapBTWLimitTXT2Saperator: NSLayoutConstraint!
    @IBOutlet var layoutRightPadding2LimitText: NSLayoutConstraint!
    @IBOutlet var layoutSaperatorViewHeight: NSLayoutConstraint!
    @IBOutlet var layoutMinimumHeightOfEditor: NSLayoutConstraint!
    @IBOutlet var layoutExactHeightOfEditingArea: NSLayoutConstraint!
    @IBOutlet var layoutCharacterLimitHeight: NSLayoutConstraint!
    @IBOutlet var layoutSendButtonWidth: NSLayoutConstraint!
    
    @IBInspectable public var topPadding: CGFloat = 5.0
    @IBInspectable public var leftPadding: CGFloat = 5.0
    @IBInspectable public var rightPadding: CGFloat = 5.0
    @IBInspectable public var bottomPadding: CGFloat = 5.0
    @IBInspectable public var rightLimitPin: CGFloat = 5.0
    @IBInspectable public var maxLinesNum: Int = 1
    @IBInspectable public var minLinesNum: Int = 1
    @IBInspectable public var previewMode: Bool = false
    @IBInspectable public var hideSaperatorView: Bool = false
    @IBInspectable public var sendButtonWidth: CGFloat = 5.0

    @IBInspectable public var textColor: UIColor = UIColor.black
    @IBInspectable public var placeHolderTextColor: UIColor = UIColor.black
    @IBInspectable public var charLimitTextColor: UIColor = UIColor.black
    @IBInspectable public var textEditingActiveColor: UIColor = UIColor.black

    @IBInspectable public var heightSaperator: Int = 1
    @IBInspectable public var topPinOfCharLimit: CGFloat = 5.0
    @IBInspectable public var numberOfCharaters: Int = 100
    
    /// The text that appears as a placeholder when the text view is empty
    @IBInspectable public var placeholder : String = "Place Holder..."
    @IBInspectable public var fontSizeEditor : CGFloat = 15.0
    @IBInspectable public var fontNameEditor : String = "HelveticaNeue"
    @IBInspectable public var fontSizeCharLimit : CGFloat = 10.0
    @IBInspectable public var fontNameCharLimit : String = "HelveticaNeue"
    
    //action On Send button
    @IBAction func actionOnSendButton(_ sender: UIButton) {
        self.endEditing(true)
        self.delegate?.handleSendBTNAction(textValue: txtVEditor.text)
    }
    
    // MARK: - Initializers
    override func awakeFromNib() {
        
        if self.layoutTopPadding != nil {
            self.layoutTopPadding.constant = topPadding
        }
        
        if self.layoutLeftPadding != nil {
            self.layoutLeftPadding.constant = leftPadding
        }
        
        if self.layoutRightPadding != nil {
            self.layoutRightPadding.constant = rightPadding
        }
        
        if self.layoutVerticalGapBTWLimitTXT2Saperator != nil {
            self.layoutVerticalGapBTWLimitTXT2Saperator.constant = topPinOfCharLimit
        }

        if self.layoutBottomPadding != nil {
            self.layoutBottomPadding.constant = bottomPadding
        }
        
        if self.layoutRightPadding2LimitText != nil {
           self.layoutRightPadding2LimitText.constant = rightLimitPin
        }
        
        self.vSepratorViewBTWTextView2LimitView.isHidden = self.hideSaperatorView
        self.setColorToActiveEditing(active: false)
        txtVEditor.tintColor = self.textEditingActiveColor
        
        self.layoutSaperatorViewHeight.constant = CGFloat(self.heightSaperator)
        
        //set initial value for preview mode according to the value set in xib
        self.setPreviewModeOfEditor(previewMode: previewMode)
        
        //set initial value for font to text view and place holder value set in xib
        self.setFonts()
        
        //set initial value for color to textView, Place holder Text and character limit text value set in xib
        self.setTextColor()

        self.layoutCharacterLimitHeight.isActive = !self.isHiddenCharacterLimitText
        self.lblCharactersLimit.text = self.isHiddenCharacterLimitText ? "" : "\(numberOfCharaters)"
        
        self.layoutMinimumHeightOfEditor.constant = (ceil(self.txtVEditor.font!.lineHeight) * CGFloat(minLinesNum)) + txtVEditor.textContainerInset.top + txtVEditor.textContainerInset.bottom
        minimumHeightOfTxtEditor = (ceil(self.txtVEditor.font!.lineHeight) * CGFloat(minLinesNum)) + txtVEditor.textContainerInset.top + txtVEditor.textContainerInset.bottom
        self.layoutMinimumHeightOfEditor.isActive = true
        
        if maxLinesNum == 0 {
            self.layoutExactHeightOfEditingArea.constant = roundHeight()
        } else {
            self.layoutExactHeightOfEditingArea.constant = (ceil(self.txtVEditor.font!.lineHeight) * CGFloat(maxLinesNum)) + txtVEditor.textContainerInset.top + txtVEditor.textContainerInset.bottom
        }
        self.layoutExactHeightOfEditingArea.isActive = false
        self.placeholderLabel.text = placeholder

        self.setupScrolling()
        
        if self.numberOfCharaters <= 0 {
            self.isHiddenCharacterLimitText = true
            self.updateLimitOfCharactors()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
    }
    
    //Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    private func setupScrolling() {

        var roundedHeight = roundHeight()
         roundedHeight = roundHeight()
        self.placeholderLabel.isHidden = self.shouldHidePlaceholder()

        var maxHeight:CGFloat = 0.0
        if maxLinesNum > 0 {
            maxHeight = (ceil(self.txtVEditor.font!.lineHeight) * CGFloat(maxLinesNum)) + txtVEditor.textContainerInset.top + txtVEditor.textContainerInset.bottom
        } else {
             roundedHeight = roundHeight()
            maxHeight = roundedHeight
        }
        
        if roundedHeight <= minimumHeightOfTxtEditor {
            self.layoutMinimumHeightOfEditor.constant = roundedHeight
            self.layoutMinimumHeightOfEditor.isActive = true
            self.layoutExactHeightOfEditingArea.isActive = false
            txtVEditor.isScrollEnabled = false
        } else if roundedHeight > maxHeight {
            self.layoutExactHeightOfEditingArea.constant = (ceil(self.txtVEditor.font!.lineHeight) * CGFloat(maxLinesNum)) + txtVEditor.textContainerInset.top + txtVEditor.textContainerInset.bottom
            self.layoutMinimumHeightOfEditor.isActive = false
            self.layoutExactHeightOfEditingArea.isActive = true
            txtVEditor.isScrollEnabled = true
        } else {
            self.layoutMinimumHeightOfEditor.constant = roundedHeight
            self.layoutMinimumHeightOfEditor.isActive = true
            self.layoutExactHeightOfEditingArea.isActive = false
            txtVEditor.isScrollEnabled = false
        }
        
        if roundedHeight <= ceil(self.txtVEditor.font!.lineHeight) + txtVEditor.textContainerInset.top + txtVEditor.textContainerInset.bottom {
            txtVEditor.isScrollEnabled = false
        }
        
        self.setNeedsDisplay()
        self.placeholderLabel.isHidden = self.shouldHidePlaceholder()
    }

    /**
     Determines if the placeholder should be hidden dependant on whether it was set and if there is text in the text view
     
     - returns: true if it should not be visible
     */
    private func shouldHidePlaceholder() -> Bool {
        let shouldShow: Bool = placeholder.count == 0 || self.txtVEditor.text.count > 0
        
        if(self.delegate != nil){
           self.delegate?.textModified(textValue: self.txtVEditor.text)
        }
        return shouldShow
    }

    /**
     Calculates the correct height for the text currently in the textview as we cannot rely on contentsize to do the right thing
     */
    private func roundHeight() -> CGFloat {
        var newHeight: CGFloat = 0
        
        if let font = self.txtVEditor.font {
            let attributes = [NSAttributedStringKey.font: font]
            let boundingSize = CGSize(width: self.txtVEditor.frame.size.width - 10 - self.txtVEditor.textContainerInset.right - self.txtVEditor.textContainerInset.left, height: .greatestFiniteMagnitude)
            let size = self.txtVEditor.text.boundingRect(with: boundingSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
            newHeight = ceil(size.height)
        }
        
        if let font = txtVEditor.font, newHeight < font.lineHeight {
            newHeight = font.lineHeight
        }
        
        return newHeight + txtVEditor.textContainerInset.top + txtVEditor.textContainerInset.bottom
    }
    
    // update the hide value of the placeholder label
    fileprivate func showingPlaceHolder() {
        placeholderLabel.isHidden = shouldHidePlaceholder()
        if !placeholderLabel.isHidden {
            sendSubview(toBack: placeholderLabel)
        }
    }
    
    // setting up the text font to the textview and placeholder label
    private func setFonts() {
        self.lblCharactersLimit.font = UIFont(name: self.fontNameCharLimit, size: (self.fontSizeCharLimit))
        self.txtVEditor.font = UIFont(name: self.fontNameEditor, size: self.fontSizeEditor)
        self.placeholderLabel.font = UIFont(name: self.fontNameEditor, size: self.fontSizeEditor)
    }
    
    // setting up the text color to the textview and placeholder label
    private func setTextColor() {
        self.placeholderLabel.textColor = self.placeHolderTextColor
        self.txtVEditor.textColor = self.textColor
        self.lblCharactersLimit.textColor = self.charLimitTextColor
    }

    // Here we are update the value of character limit label
    fileprivate func updateLimitOfCharactors() {
        let totalLength = self.txtVEditor.text.count
        
        if totalLength <= self.numberOfCharaters {
            self.lblCharactersLimit.text = self.isHiddenCharacterLimitText ? "" : "\(totalLength) / \(self.numberOfCharaters)"
        } else {
            self.lblCharactersLimit.text = self.isHiddenCharacterLimitText ? "" : "\(totalLength) / \(self.numberOfCharaters)"
        }

        self.layoutCharacterLimitHeight.isActive = !self.isHiddenCharacterLimitText
    }

    // here we are setting the Color of the Active text editing to the separator
    fileprivate func setColorToActiveEditing(active: Bool) {
        if active {
            vSepratorViewBTWTextView2LimitView.backgroundColor = self.textEditingActiveColor
        } else {
            vSepratorViewBTWTextView2LimitView.backgroundColor = self.placeHolderTextColor
        }
    }

    // Here we are setting up the placeholder text to the control
    public var placeholderValue : String = "" {
        
        willSet {
            self.placeholderLabel.text = newValue
            placeholder = newValue
        }
        
        didSet {
        }
    }
    
    // set the Text to the textView for showing initial. OR some value is already provided.
    public var setEditorTextValue: String? {
        willSet {
            self.txtVEditor.text = newValue
            self.showingPlaceHolder()
            self.setupScrolling()
        }
    }

    // Enable/Disable Previwe mode of the Control,
    public func setPreviewModeOfEditor(previewMode: Bool) {
        self.previewMode = previewMode
        self.txtVEditor.isEditable = !self.previewMode
    }
    
    // Hide/show the Character Limit label of the control
    public func setHideCharacterLimit(value: Bool) {
        self.isHiddenCharacterLimitText = value
        self.updateLimitOfCharactors()
    }
    
    //Update the UI with animation after text editing.
    public func updateViews(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
            
        } else {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    //Get the text value from the control
    public func getTextValue() -> String {
        return self.txtVEditor.text
    }

    // here are set the number of lines if need to pass the value via code or change the run time ot according to UI requirement we need to use this method.
    public func setNumberOfLines(lines: Int) {
        self.maxLinesNum = lines
        self.setupScrolling()
        updateViews(animated: true)
    }
    
    // set Hide/show Send Button of the control
    public func setHideSendBTN(isHidden: Bool) {
        self.sendBTN.isHidden = isHidden
        self.layoutSendButtonWidth.constant = isHidden ? 0.0 : self.sendButtonWidth
    }
    
    // set Image Color to Send Button
    public func setImageToSendButton(image: UIImage, selected: Bool) {
        if selected {
            self.sendBTN.setImage(image, for: .selected)
        } else {
            self.sendBTN.setImage(image, for: .normal)
        }
    }

    // set title to Send Button
    public func setTextToSendButton(text: String, selected: Bool) {
        if selected {
            self.sendBTN.setTitle(text, for: .selected)
        } else {
            self.sendBTN.setTitle(text, for: .normal)
        }
    }

    // set font to Send Button title
    public func setFontToSendButton(font: UIFont) {
        self.sendBTN.titleLabel?.font = font
    }

    // set Text Color to Send Button
    public func setTextColorToSendButton(color: UIColor) {
        self.sendBTN.setTitleColor(color, for: .normal)
    }

}

extension ExpandingTextEditor: UITextViewDelegate {

    public final func textViewDidChange(_ textView: UITextView) {
       
        self.updateLimitOfCharactors()
        self.setupScrolling()
        updateViews(animated: true)
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.setColorToActiveEditing(active: true)

        if self.delegate != nil {
            self.delegate?.textEditingStarted(textValue: textView.text)
        }
        return true
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.updateLimitOfCharactors()
        self.setupScrolling()
        
        if self.delegate != nil {
            self.delegate?.textEditingDone(textValue: textView.text)
        }
        self.setColorToActiveEditing(active: false)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        var shouldChange = false
        
        let totalLength = textView.text.count + text.count
        
        if totalLength <= self.numberOfCharaters || self.isHiddenCharacterLimitText {
            shouldChange = true
        }
        return shouldChange
    }
    
    
}






# TextEditor

# How to use

### Copy an paste `ExpandingTextEditor.swift and ExpandingTextEditor.xib`

* Create IBoutlet
      `@IBOutlet var editingView: ExpandingTextEditor`

* Add the delegate 

      `editingView.delegate = self`

* For set Preview mode of text editor control you can use this method:         

      `editingView.setPreviewModeOfEditor(previewMode: true)`

* For set hide/Show for character limit text you can use this method:         

      `editingView.setHideCharacterLimit(value: false)`

* For set number of lines which developer want to show for the text editor control you can use this method:

      `editingView.setNumberOfLines(lines: 4)`

* For set title Font to Send button

      `editingView.setFontToSendButton(font: UIFont(name: "HelveticaNeue", size: 14.0)!)`
     
* For set the tile to send button with selected/diselected mode of the button

      `editingView.setTextToSendButton(text: "Send", selected: false)`
        
* For set hide/Show for send button

      `editingView.setHideSendBTN(isHidden: false)`

* For change the Send button Title Text Color

      `editingView.setTextColorToSendButton(color: UIColor.purple)`        

* For set the image to Send button with selected/diselected mode of the button

      `editingView.setImageToSendButton(image: UIImage("name"), selected: false)`


***

## For set the UI element to the TextEditor like: Text Color, Place Holder Color, Character Limit Text Color, Character Limit value, Padding to the control, color of line separator, Height of Separator Line, Text Fonts, Send Button:width of button with constraints. You can set this in Xib check the blow image.

![Image](https://github.com/9SumeetMourya/TextEditor/blob/master/Screenshots/Xib%20Identity%20Inspector.png)

***

## Constraints

For more details about the constriants check the file Header: [File Link](https://github.com/9SumeetMourya/TextEditor/blob/master/TextEditorDemo/TextEditorDemo/Editor/ExpandingTextEditor.swift)

***

## Check the Video:[Video](https://gfycat.com/WarpedPowerlessBushbaby)

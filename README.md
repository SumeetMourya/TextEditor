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

## For set the UI element to the TextEditor like: Text Color, Place Holder Color, Character Limit Text Color, Character Limit value, Padding to the control, color of line separator, Height of Separator Line, Text Fonts. You can set this in Xib check the blow image.

![Image](https://github.com/9SumeetMourya/TextEditor/blob/master/Screenshots/Xib%20Identity%20Inspector.png)

## Check the Video:[Video](https://gfycat.com/gifs/detail/ThreadbareBewitchedHyena)

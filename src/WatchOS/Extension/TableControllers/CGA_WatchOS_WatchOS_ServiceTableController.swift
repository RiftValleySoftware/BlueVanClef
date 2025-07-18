/*
© Copyright 2020, The Great Rift Valley Software Company

LICENSE:

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

The Great Rift Valley Software Company: https://riftvalleysoftware.com
*/

import WatchKit
import Foundation
import RVS_BlueThoth

/* ###################################################################################################################################### */
// MARK: - Main Watch App Service Table Controller -
/* ###################################################################################################################################### */
/**
 This is the controller for the discovered services display screen.
 */
class CGA_WatchOS_ServiceTableController: NSObject {
    /* ################################################################## */
    /**
     Each table item has an associated Service.
     */
    var serviceInstance: CGA_Bluetooth_Service? {
        didSet {
            serviceLabel?.setText(serviceInstance?.id)
        }
    }
    
    /* ################################################################## */
    /**
     This displays the Service ID.
     */
    @IBOutlet weak var serviceLabel: WKInterfaceLabel!
}

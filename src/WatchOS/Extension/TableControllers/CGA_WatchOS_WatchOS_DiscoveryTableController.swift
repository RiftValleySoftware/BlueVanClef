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
// MARK: - Main Watch App Discovery Peripheral Table Controller -
/* ###################################################################################################################################### */
class CGA_WatchOS_DiscoveryTableController: NSObject {
    /* ################################################################## */
    /**
     Each table item has an associated Peripheral, denoted by discovery data.
     */
    var deviceDiscoveryData: RVS_BlueThoth.DiscoveryData! {
        didSet {
            var name = deviceDiscoveryData.preferredName
            
            if name.isEmpty {
                name = "SLUG-NO-DEVICE-NAME".localizedVariant
            }
            
            deviceLabel?.setText(name)
            
            if let services = deviceDiscoveryData.advertisementData.advertisedServiceUUIDS {
                let servicesText = services.map { $0.localizedVariant }.joined(separator: ", ")
                serviceLabel?.setText(servicesText)
                print("Services: \(servicesText)")
                serviceLabel?.setHidden(false)
            } else {
                serviceLabel?.setHidden(true)
            }
        }
    }
    
    /* ################################################################## */
    /**
     This displays the Peripheral name.
     */
    @IBOutlet weak var deviceLabel: WKInterfaceLabel!
    
    /* ################################################################## */
    /**
     This displays any advertised Services.
     */
    @IBOutlet weak var serviceLabel: WKInterfaceLabel!
}
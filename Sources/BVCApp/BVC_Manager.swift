/*
© Copyright 2020-2025, The Great Rift Valley Software Company

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

import SwiftUI
import RVS_BlueThoth
import RVS_Generic_Swift_Toolbox

/* ###################################################################################################################################### */
// MARK: - BlueThoth Interface -
/* ###################################################################################################################################### */
/**
 */
class BVC_Manager: ObservableObject {
    /* ################################################################## */
    /**
     This is the BlueThoth instance that manages our BLE connections.
     */
    let blueThothInstance: RVS_BlueThoth
    
    /* ################################################################## */
    /**
     Default initializer. We don't do much, here.
     */
    init() {
        self.blueThothInstance = RVS_BlueThoth()
        self.blueThothInstance.delegate = self
    }
}

/* ###################################################################################################################################### */
// MARK: CGA_BlueThoth_Delegate Conformance
/* ###################################################################################################################################### */
extension BVC_Manager: CGA_BlueThoth_Delegate {
    /* ################################################################## */
    /**
     Called when the BlueThoth instance registers an error.
     
     - parameter inError: The error that was triggered.
     - parameter inInstance: The BlueThoth instance experiencing the error.
     */
    func handleError(_ inError: CGA_Errors, from inInstance: RVS_BlueThoth) {
        #if DEBUG
            print("BLE ERROR: \(inError.localizedDescription.localizedVariant)")
        #endif
    }
    
    /* ################################################################## */
    /**
     Called when the BlueThoth instance has "powered on," as a central manager.
     
     - parameter inInstance: The BlueThoth instance experiencing the error.
     */
    func centralManagerPoweredOn(_ inInstance: RVS_BlueThoth) {
        #if DEBUG
            print("BLE Central Powered On")
        #endif
    }
    
    /* ################################################################## */
    /**
     Called when the BlueThoth instance central manager has an update.
     
     - parameter inInstance: The BlueThoth instance experiencing the error.
     */
    func updateFrom(_ inInstance: RVS_BlueThoth) {
        #if DEBUG
            print("BLE Central Update")
        #endif
    }
}

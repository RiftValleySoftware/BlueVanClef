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

/* ###################################################################################################################################### */
// MARK: - BlueThoth Interface -
/* ###################################################################################################################################### */
/**
 */
class BVC_Manager: ObservableObject {
    /* ################################################################## */
    /**
     */
    let blueThothInstance: RVS_BlueThoth
    
    /* ################################################################## */
    /**
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
     */
    func handleError(_ inError: CGA_Errors, from inInstance: RVS_BlueThoth) {
    }
}

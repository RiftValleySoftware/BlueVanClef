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
// MARK: - Main Watch App Discovery Interface Controller -
/* ###################################################################################################################################### */
/**
 This is the controller for the initial extension screen.
 */
class CGA_WatchOS_MainInterfaceController: CGA_WatchOS_BaseInterfaceController {
    /* ################################################################## */
    /**
     This is the ID for the main Discovery Screen.
     */
    static let id: String = "MAIN"

    /* ################################################################## */
    /**
     The image that indicates Bluetooth is not available.
     */
    @IBOutlet weak var noBTImage: WKInterfaceImage!
    
    /* ################################################################## */
    /**
     The switch that controls the scanning for Peripherals.
     */
    @IBOutlet weak var scanningSwitch: WKInterfaceSwitch!

    /* ################################################################## */
    /**
     The table that lists the discovered devices.
     */
    @IBOutlet weak var deviceListTable: WKInterfaceTable!
    
    /* ################################################################## */
    /**
     The "More" button.
     */
    @IBOutlet weak var infoButton: WKInterfaceButton!
}

/* ###################################################################################################################################### */
// MARK: - IBAction Methods -
/* ###################################################################################################################################### */
extension CGA_WatchOS_MainInterfaceController {
    /* ################################################################## */
    /**
     Called when the Scanning switch changes value
     
     - parameter inIsOn: True, if the switch is now on.
     */
    @IBAction func scanningSwitchChanged(_ inIsOn: Bool) {
        if  let centralManager = centralManager,
            centralManager.isBTAvailable,
            inIsOn {
            centralManager.allowEmptyNames = prefs?.allowEmptyNames ?? false
            centralManager.discoverOnlyConnectablePeripherals = prefs?.discoverOnlyConnectableDevices ?? false
            centralManager.minimumRSSILevelIndBm = prefs?.minimumRSSILevel ?? -100
            centralManager.startOver(true)
            populateTable()
        } else {
            centralManager?.stopScanning()
            scanningSwitch?.setOn(false)
        }
    }
}

/* ###################################################################################################################################### */
// MARK: - Instance Methods -
/* ###################################################################################################################################### */
extension CGA_WatchOS_MainInterfaceController {
    /* ################################################################## */
    /**
     Establishes accessibility labels.
     */
    func setAccessibility() {
        if  let centralManager = centralManager {
            scanningSwitch?.setAccessibilityLabel(("SLUG-ACC-SCANNING-BUTTON-O" + (centralManager.isScanning ? "N" : "FF")).localizedVariant)
            deviceListTable?.setAccessibilityLabel("SLUG-ACC-DEVICELIST-TABLE".localizedVariant)
            infoButton?.setAccessibilityLabel("SLUG-ACC-SETTINGS-BUTTON".localizedVariant)
        } else {
            noBTImage?.setAccessibilityLabel("SLUG-ACC-NO-BT-IMAGE".localizedVariant)
        }
    }
}

/* ###################################################################################################################################### */
// MARK: - Base Class Override Methods -
/* ###################################################################################################################################### */
extension CGA_WatchOS_MainInterfaceController {
    /* ################################################################## */
    /**
     Called as the View is set up.
     
     - parameter withContext: The context provided to the view, as it was instantiated.
     */
    override func awake(withContext inContext: Any?) {
        id = Self.id
        super.awake(withContext: inContext)
        if let extensionDelegateInstance = extensionDelegateInstance {
            extensionDelegateInstance.centralManager = RVS_BlueThoth(delegate: extensionDelegateInstance)
            scanningSwitch?.setTitle("SLUG-SCANNING".localizedVariant)
            setTitle("SLUG-DEVICES".localizedVariant)
        }
    }
    
    /* ################################################################## */
    /**
     Table touch handler.
     
     - parameters:
        - withIdentifier: The segue ID for this (we ignore)
        - in: The table instance
        - rowIndex: The vertical position (0-based) of the row that was touched.
     
        - returns: The context, if any. Can be nil.
     */
    override func contextForSegue(withIdentifier inSegueIdentifier: String, in inTable: WKInterfaceTable, rowIndex inRowIndex: Int) -> Any? {
        guard  let centralManager = centralManager,
            centralManager.isBTAvailable,
            (0..<centralManager.stagedBLEPeripherals.count).contains(inRowIndex) else { return nil }
        
        return centralManager.stagedBLEPeripherals[inRowIndex]
    }
    
    /* ################################################################## */
    /**
     Called before the view disappears. We use this to stop the scanning.
     */
    override func willDisappear() {
        super.willDisappear()
        centralManager?.stopScanning()
        scanningSwitch?.setOn(false)
    }
}

/* ###################################################################################################################################### */
// MARK: - Instance Methods -
/* ###################################################################################################################################### */
extension CGA_WatchOS_MainInterfaceController {
    /* ################################################################## */
    /**
     This adds devices to the table for display.
     */
    func populateTable() {
        if  let driverInstance = centralManager,
            driverInstance.isBTAvailable,
            0 < driverInstance.stagedBLEPeripherals.count {
            let rowControllerInitializedArray = [String](repeatElement("CGA_WatchOS_DiscoveryTableController", count: driverInstance.stagedBLEPeripherals.count))
            
            deviceListTable.setNumberOfRows(rowControllerInitializedArray.count, withRowType: "CGA_WatchOS_DiscoveryTableController")

            for item in rowControllerInitializedArray.enumerated() {
                if let deviceRow = deviceListTable.rowController(at: item.offset) as? CGA_WatchOS_DiscoveryTableController {
                    let deviceInstance = driverInstance.stagedBLEPeripherals[item.offset]
                    deviceRow.deviceDiscoveryData = deviceInstance
                }
            }
        } else {
            deviceListTable.setNumberOfRows(0, withRowType: "")
        }
    }
}

/* ###################################################################################################################################### */
// MARK: - CGA_WatchOS_Base_Protocol Conformance -
/* ###################################################################################################################################### */
extension CGA_WatchOS_MainInterfaceController {
    /* ################################################################## */
    /**
     This sets everything up to reflect the current state of the Central Manager.
     */
    override func updateUI() {
        if  let centralManager = centralManager,
            centralManager.isBTAvailable {
            deviceListTable?.setHidden(false)
            noBTImage?.setHidden(true)
            scanningSwitch?.setHidden(false)
            scanningSwitch?.setOn(centralManager.isScanning)
        } else {
            scanningSwitch?.setOn(false)
            noBTImage?.setHidden(false)
            deviceListTable?.setHidden(true)
            scanningSwitch?.setHidden(true)
        }
        
        setAccessibility()
        populateTable()
    }
}

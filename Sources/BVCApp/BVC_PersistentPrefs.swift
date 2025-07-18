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

import Foundation
import RVS_Persistent_Prefs

/* ###################################################################################################################################### */
// MARK: - The Persistent Prefs Subclass -
/* ###################################################################################################################################### */
/**
 This is the subclass of the preferences type that will provide our persistent app settings.
 */
class BVC_PersistentPrefs: RVS_PersistentPrefs {
    /* ################################################################################################################################## */
    // MARK: - The Persistent Prefs Keys (As An Enum) -
    /* ################################################################################################################################## */
    /**
     This is an enumeration that will list the prefs keys for us.
     */
    enum Keys: String {
        /* ############################################################## */
        /**
         This will be a Boolean value. If true, then the scan will not use duplicate filtering (meaning that it will be continuously updating).
         */
        case continuouslyUpdatePeripherals = "kUpdatePeripherals"
        
        /* ############################################################## */
        /**
         This will be an Array of String, containing the UUIDs of specific Peripherals for which we are filtering.
         */
        case peripheralFilterIDArray = "kPeripheralIDs"
        
        /* ############################################################## */
        /**
         This will be an Array of String, containing the UUIDs of specific Services for which we are filtering.
         */
        case serviceFilterIDArray = "kServiceIDs"
        
        /* ############################################################## */
        /**
         This will be an Array of String, containing the UUIDs of specific Characteristics for which we are filtering.
         */
        case characteristicFilterIDArray = "kCharacteristicIDs"
        
        /* ############################################################## */
        /**
         This will be a signed Integer, with the minimum RSSI.
         */
        case minimumRSSILevel = "kMinimumRSSILevel"
        
        /* ############################################################## */
        /**
         This will be a Bool, true, if we are filtering out non-connectable devices.
         */
        case discoverOnlyConnectableDevices = "kOnlyConnectables"
        
        /* ############################################################## */
        /**
         This will be a Bool, true, if we are allowing devices that don't have names to be discovered.
         */
        case allowEmptyNames = "kAllowEmptyNames"
        
        /* ############################################################## */
        /**
         This will be a Bool, true, if we will always force endline/carriage returns to be CRLF pairs.
         */
        case alwaysUseCRLF = "kAlwaysUseCRLF"

        /* ############################################################## */
        /**
         These are all the keys, in an Array of String.
         */
        static var allKeys: [String] { [continuouslyUpdatePeripherals.rawValue,
                                        peripheralFilterIDArray.rawValue,
                                        serviceFilterIDArray.rawValue,
                                        characteristicFilterIDArray.rawValue,
                                        minimumRSSILevel.rawValue,
                                        discoverOnlyConnectableDevices.rawValue,
                                        allowEmptyNames.rawValue,
                                        alwaysUseCRLF.rawValue
                                        ] }
    }
    
    /* ################################################################## */
    /**
     This is a list of the keys for our prefs.
     We should use the enum for the keys (rawValue).
     */
    override var keys: [String] { Keys.allKeys }
    
    /* ################################################################## */
    /**
     This is a Boolean value. If true, then the scan will not use duplicate filtering (meaning that it will be continuously updating).
     */
    @objc dynamic var continuouslyUpdatePeripherals: Bool {
        get { values[Keys.continuouslyUpdatePeripherals.rawValue] as? Bool ?? false }
        set { values[Keys.continuouslyUpdatePeripherals.rawValue] = newValue }
    }
    
    /* ################################################################## */
    /**
     This is a Boolean value. If true, then devices that are not advertising as connectable will be ignored.
     */
    @objc dynamic var discoverOnlyConnectableDevices: Bool {
        get { values[Keys.discoverOnlyConnectableDevices.rawValue] as? Bool ?? false }
        set { values[Keys.discoverOnlyConnectableDevices.rawValue] = newValue }
    }
    
    /* ################################################################## */
    /**
     This is a Boolean value. If true, then devices that do not have names will be included. Default is false.
     */
    @objc dynamic var allowEmptyNames: Bool {
        get { values[Keys.allowEmptyNames.rawValue] as? Bool ?? false }
        set { values[Keys.allowEmptyNames.rawValue] = newValue }
    }
    
    /* ################################################################## */
    /**
     This is a Boolean value. If true, then we will always send newlines as CRLF pairs. Default is false.
     */
    @objc dynamic var alwaysUseCRLF: Bool {
        get { values[Keys.alwaysUseCRLF.rawValue] as? Bool ?? false }
        set { values[Keys.alwaysUseCRLF.rawValue] = newValue }
    }

    /* ################################################################## */
    /**
     This is a Boolean value. If true, then the scan will not use duplicate filtering (meaning that it will be continuously updating).
     */
    @objc dynamic var minimumRSSILevel: Int {
        get { values[Keys.minimumRSSILevel.rawValue] as? Int ?? -100 }
        set { values[Keys.minimumRSSILevel.rawValue] = newValue }
    }

    /* ################################################################## */
    /**
     This is an Array of String, containing the UUIDs of specific Peripherals for which we are filtering.
     */
    @objc dynamic var peripheralFilterIDArray: [String] {
        get { values[Keys.peripheralFilterIDArray.rawValue] as? [String] ?? [] }
        set { values[Keys.peripheralFilterIDArray.rawValue] = newValue }
    }
    
    /* ################################################################## */
    /**
     This is an Array of String, containing the UUIDs of specific Services for which we are filtering.
     */
    @objc dynamic var serviceFilterIDArray: [String] {
        get { values[Keys.serviceFilterIDArray.rawValue] as? [String] ?? [] }
        set { values[Keys.serviceFilterIDArray.rawValue] = newValue }
    }
    
    /* ################################################################## */
    /**
     This is an Array of String, containing the UUIDs of specific Characteristics for which we are filtering.
     */
    @objc dynamic var characteristicFilterIDArray: [String] {
        get { values[Keys.characteristicFilterIDArray.rawValue] as? [String] ?? [] }
        set { values[Keys.characteristicFilterIDArray.rawValue] = newValue }
    }
}

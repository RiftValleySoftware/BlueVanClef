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
import RVS_BlueThoth

/*
 These have been set up in a separate file, because they aren't really part of the regular setup.
 Also, this file has been removed from inspection by SwiftLint, as SwiftLint erroneously rats out an "implicit getter," and I don't want to remove that rule from all files.
 */

/* ###################################################################################################################################### */
// MARK: - Preferences Extension -
/* ###################################################################################################################################### */
/**
 This extension adds a bit of extra "sauce" to the shared prefs class, in that it adds stuff specific to our platform.
 */
extension CGA_PersistentPrefs {
    /* ################################################################## */
    /**
     This is the scan criteria object to be used for filtering scans.
     It is provided in the struct required by the Bluetooth subsystem.
     */
    var scanCriteria: RVS_BlueThoth.ScanCriteria! { RVS_BlueThoth.ScanCriteria(peripherals: peripheralFilterIDArray, services: serviceFilterIDArray, characteristics: characteristicFilterIDArray) }
}

/* ###################################################################################################################################### */
// MARK: - Bundle Extension -
/* ###################################################################################################################################### */
/**
 This extension adds a few simple accessors for some of the more common bundle items.
 */
extension Bundle {
    // MARK: General Stuff for common Apple-Supplied Items
    
    /* ################################################################## */
    /**
     The app name, as a string. It is required, and "ERROR" is returned if it is not present.
     */
    var appDisplayName: String { (object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? object(forInfoDictionaryKey: "CFBundleName") as? String) ?? "ERROR" }

    /* ################################################################## */
    /**
     The app version, as a string. It is required, and "ERROR" is returned if it is not present.
     */
    var appVersionString: String { object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "ERROR" }
    
    /* ################################################################## */
    /**
     The build version, as a string. It is required, and "ERROR" is returned if it is not present.
     */
    var appVersionBuildString: String { object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "ERROR" }
    
    /* ################################################################## */
    /**
     If there is a copyright string, it is returned here. It may be nil.
     */
    var copyrightString: String? { object(forInfoDictionaryKey: "NSHumanReadableCopyright") as? String }

    // MARK: Specific to this app.
    
    /* ################################################################## */
    /**
     If there is a copyright site URI, it is returned here as a String. It may be nil.
     */
    var siteURIAsString: String? { object(forInfoDictionaryKey: "InfoScreenCopyrightSiteURL") as? String }
    
    /* ################################################################## */
    /**
     If there is a help site URI, it is returned here as a String. It may be nil.
     */
    var helpURIAsString: String? { object(forInfoDictionaryKey: "InfoScreenHelpSiteURL") as? String }
    
    /* ################################################################## */
    /**
     If there is a copyright site URI, it is returned here as a URL. It may be nil.
     */
    var siteURI: URL? { URL(string: siteURIAsString ?? "") }
    
    /* ################################################################## */
    /**
     If there is a help site URI, it is returned here as a URL. It may be nil.
     */
    var helpURI: URL? { URL(string: helpURIAsString ?? "") }
}

/* ###################################################################################################################################### */
// MARK: - Special Array Extension -
/* ###################################################################################################################################### */
/**
 This extension adds a bit of extra "sauce" to the shared prefs class, in that it adds stuff specific to our platform.
 */
extension Array where Element: CGA_WatchOS_BaseInterfaceController {
    /* ################################################################## */
    /**
     This subscript allows us to use an Array just like a Dictionary.
     */
    subscript(_ inIDString: String) -> Element? {
        get {
            for element in self where element.id == inIDString {
                return element
            }
            
            return nil
        }
        
        set {
            // If we have a valid key, and the value is nil, we delete. Otherwise, we replace the element at that spot.
            for elem in enumerated() where inIDString == self[elem.offset].id {
                if let newValue = newValue {
                    self[elem.offset] = newValue
                } else {
                    remove(at: elem.offset)
                }
                
                return
            }
            
            // If we fall through to here, it's a new element, and we simply append it.
            if let newValue = newValue {
                append(newValue)
            }
        }
    }
    
    /* ################################################################## */
    /**
     The main controller will always be the first one.
     */
    var mainViewController: CGA_WatchOS_MainInterfaceController? { first as? CGA_WatchOS_MainInterfaceController }
    
    /* ################################################################## */
    /**
     The top controller will always be the last one (most times, we will just have two controllers in the Array, anyway).
     */
    var topViewController: CGA_WatchOS_BaseInterfaceController? { last }
}

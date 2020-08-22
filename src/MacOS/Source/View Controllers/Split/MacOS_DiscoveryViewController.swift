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

import Cocoa
import RVS_BlueThoth

/* ###################################################################################################################################### */
// MARK: - Button With Attached Discovery Data -
/* ###################################################################################################################################### */
/**
 */
class MacOS_Clicker: NSButton {
    var discoveryInfo: RVS_BlueThoth.DiscoveryData?
}

/* ###################################################################################################################################### */
// MARK: - The Device Discovery Screen View Controller -
/* ###################################################################################################################################### */
/**
 This is the permanent Device Discovery Screen. It is the leftmost screen, and contains a table that is updated as the discovery scanning goes on.
 */
class MacOS_DiscoveryViewController: RVS_BlueThoth_MacOS_Test_Harness_Base_SplitView_ViewController {
    /* ################################################################## */
    /**
     The font size for the header of each device.
     */
    let headerRowFontSize = 15

    /* ################################################################## */
    /**
     The padding around that header (above and below)
     */
    let headerPadding = 2
    
    /* ################################################################## */
    /**
     This is the font size for the information about each discovery (below the header).
     */
    let infoRowFontSize = 12
    
    /* ################################################################## */
    /**
     The padding around that text (above and below)
     */
    let infoPadding = 2
    
    /* ################################################################## */
    /**
     This enum has the scanning on/off states, expressed as 0-based Int.
     */
    enum ScanningModeSwitchValues: Int {
        /// The SDK is not scanning for Peripherals.
        case notScanning
        /// The SDK is scanning for Peripherals.
        case scanning
    }
    
    /* ################################################################## */
    /**
     This is the container for one device in our table.
     */
    typealias TableRow = (id: String, contents: [String])
    
    /* ################################################################## */
    /**
     This is the width of the discovery section, which is fixed.
     */
    static let screenThickness: CGFloat = 480

    /* ################################################################## */
    /**
     This is a String key that uniquely identifies this screen.
     */
    let key: String = MacOS_AppDelegate.deviceScreenID
    
    /* ################################################################## */
    /**
     This will map the discovered devices for display in the table. The key is the ID of the Peripheral. The value is all the rows it will display.
     */
    private var _tableMap: [TableRow] = []
    
    /* ################################################################## */
    /**
     This is a segmented switch that reflects the state of the scanning.
     */
    @IBOutlet weak var scanningModeSegmentedSwitch: NSSegmentedControl!

    /* ################################################################## */
    /**
     This is the image that is shown if Bluetooth is not available.
     */
    @IBOutlet weak var noBTImage: NSImageView!
    
    /* ################################################################## */
    /**
     This is the "Start Over From Scratch" button.
     */
    @IBOutlet weak var reloadButton: NSButton!

    /* ################################################################## */
    /**
     This is the stack view that we populate with the discovery data.
     */
    @IBOutlet weak var stackView: NSStackView!
    
    /* ################################################################## */
    /**
     This is the scroller that contains that stack view.
     */
    @IBOutlet weak var scrollView: NSScrollView!
    
    /* ################################################################## */
    /**
     The currently selected device (nil, if no device selected).
     */
    var selectedDevice: RVS_BlueThoth.DiscoveryData?
    
    /* ################################################################## */
    /**
     This returns the peripherals, in a sorted order.
     */
    var sortedPeripherals: [RVS_BlueThoth.DiscoveryData] { centralManager?.stagedBLEPeripherals.sorted { (a, b) -> Bool in a.identifier < b.identifier } ?? [] }
}

/* ###################################################################################################################################### */
// MARK: - Private Methods -
/* ###################################################################################################################################### */
extension MacOS_DiscoveryViewController {
    /* ################################################################## */
    /**
     This creates an Array of String, containing the advertisement data from the indexed device.
     
     - parameter inAdData: The advertisement data.
     - parameter id: The ID string.
     - parameter power: The RSSI level.
     - returns: An Array of String, with the advertisement data in "key: value" form.
     */
    private func _createAdvertimentStringsFor(_ inAdData: RVS_BlueThoth.AdvertisementData?, id inID: String, power inPower: Int) -> [String] {
        // This gives us a predictable order of things.
        guard let sortedAdDataKeys = inAdData?.advertisementData.keys.sorted() else { return [] }
        let sortedAdData: [(key: String, value: Any?)] = sortedAdDataKeys.compactMap { (key:$0, value: inAdData?.advertisementData[$0]) }

        let retStr = sortedAdData.reduce("SLUG-ID".localizedVariant + ": \(inID)\n\t" + String(format: "SLUG-RSSI-LEVEL-FORMAT-ADV".localizedVariant, inPower)) { (current, next) in
            let key = next.key.localizedVariant
            let value = next.value
            var ret = "\(current)\n"
            
            if let asStringArray = value as? [String] {
                ret += current + asStringArray.reduce("\t\(key): ") { (current2, next2) in "\(current2)\n\(next2.localizedVariant)" }
            } else if let value = value as? String {
                ret += "\t\(key): \(value.localizedVariant)"
            } else if let value = value as? Bool {
                ret += "\t\(key): \(value ? "true" : "false")"
            } else if let value = value as? Int {
                ret += "\t\(key): \(value)"
            } else if let value = value as? Double {
                if "kCBAdvDataTimestamp" == next.key {  // If it's the timestamp, we can translate that, here.
                    let date = Date(timeIntervalSinceReferenceDate: value)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "SLUG-MAIN-LIST-DATE-FORMAT".localizedVariant
                    let displayedDate = dateFormatter.string(from: date)
                    ret += "\t\(key): \(displayedDate)"
                } else {
                    ret += "\t\(key): \(value)"
                }
            } else if let value = value as? NSArray {   // An NSArray can be strung together in one line.
                ret += "\(key): " + value.reduce("", { (curr, nxt) -> String in (!curr.isEmpty ? ", " : "") + curr + String(describing: nxt).localizedVariant })
            } else {    // Anything else is just a described instance of something or other.
                ret += "\(key): \(String(describing: value))"
            }

            return ret
        }.split(separator: "\n").map { String($0) }
        
        return retStr
    }

    /* ################################################################## */
    /**
     */
    private func _createTableRowViewFor(_ inRow: Int) {
        /* ################################################################## */
        /**
         Returns a string, with the name of a staged (discovered, but not connected) device.
         
         - parameter inDeviceIndex: The 0-based index of the device, in the staged Array.
         - returns: A String, with the device name, or text explaining the error.
         */
        func _stagedDeviceName(_ inDeviceIndex: Int) -> String {
            let device = sortedPeripherals[inDeviceIndex]
            
            return  !device.preferredName.isEmpty ? device.preferredName :
                    !device.localName.isEmpty ? device.localName :
                    !device.name.isEmpty ? device.name : "SLUG-NO-DEVICE-NAME".localizedVariant
        }
        
        guard let stackView = stackView else { return }
        
        let peripheralDiscoveryInfo = sortedPeripherals[inRow]
        let discoveryText = _createAdvertimentStringsFor(peripheralDiscoveryInfo.advertisementData, id: peripheralDiscoveryInfo.identifier, power: peripheralDiscoveryInfo.rssi)
        
        guard !discoveryText.isEmpty else { return }
        
        let deviceNameLabel = NSTextField(labelWithString: _stagedDeviceName(inRow))
        deviceNameLabel.font = NSFont.boldSystemFont(ofSize: CGFloat(headerRowFontSize))
        deviceNameLabel.allowsDefaultTighteningForTruncation = true
        deviceNameLabel.textColor = .blue
        deviceNameLabel.alignment = .center
        deviceNameLabel.backgroundColor = .white
        deviceNameLabel.drawsBackground = true
        deviceNameLabel.maximumNumberOfLines = 0
        
        stackView.addArrangedSubview(deviceNameLabel)
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceNameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
        deviceNameLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true

        if  !(centralManager?.isScanning ?? true),
            peripheralDiscoveryInfo.canConnect {
            let connectButton = MacOS_Clicker()
            connectButton.setButtonType(.momentaryPushIn)
            connectButton.bezelStyle = .inline
            
            var title = "SLUG-"
            title += (peripheralDiscoveryInfo.isConnected && (selectedDevice?.identifier == peripheralDiscoveryInfo.identifier)) ? "DIS" : ""
            title += "CONNECT"
            title += (!peripheralDiscoveryInfo.isConnected && (selectedDevice?.identifier == peripheralDiscoveryInfo.identifier)) ? "ING" : ""
            
            connectButton.title = title.localizedVariant
            connectButton.isEnabled = peripheralDiscoveryInfo.isConnected || (selectedDevice?.identifier != peripheralDiscoveryInfo.identifier)
            connectButton.contentTintColor = .blue
            connectButton.bezelColor = .white
            connectButton.discoveryInfo = peripheralDiscoveryInfo
            connectButton.target = self
            connectButton.action = #selector(connectButtonHit(_:))
            stackView.addArrangedSubview(connectButton)
            connectButton.translatesAutoresizingMaskIntoConstraints = false
            connectButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
            connectButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true
        }

        let deviceInfoLabel = NSTextField(labelWithString: discoveryText.joined(separator: "\n"))
        deviceInfoLabel.font = NSFont.systemFont(ofSize: CGFloat(infoRowFontSize))
        deviceInfoLabel.allowsDefaultTighteningForTruncation = true
        deviceInfoLabel.textColor = (selectedDevice?.identifier == peripheralDiscoveryInfo.identifier) ? .blue : .white
        if selectedDevice?.identifier == peripheralDiscoveryInfo.identifier {
            deviceInfoLabel.backgroundColor = .white
            deviceInfoLabel.drawsBackground = true
        }
        
        deviceInfoLabel.maximumNumberOfLines = 0
        
        stackView.addArrangedSubview(deviceInfoLabel)
        deviceInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceInfoLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
        deviceInfoLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0).isActive = true
    }
    
    /* ################################################################## */
    /**
     */
    private func _reloadStackView() {
        guard let stackView = stackView else { return }
        
        stackView.subviews.forEach { $0.removeFromSuperview()}
        
        for index in 0..<sortedPeripherals.count {
            _createTableRowViewFor(index)
        }
    }
}

/* ###################################################################################################################################### */
// MARK: - Base Class Overrides -
/* ###################################################################################################################################### */
extension MacOS_DiscoveryViewController {
    /* ################################################################## */
    /**
     Called when the view hierachy has loaded.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        scanningModeSegmentedSwitch?.setLabel(scanningModeSegmentedSwitch?.label(forSegment: ScanningModeSwitchValues.notScanning.rawValue)?.localizedVariant ?? "ERROR", forSegment: ScanningModeSwitchValues.notScanning.rawValue)
        scanningModeSegmentedSwitch?.setLabel(scanningModeSegmentedSwitch?.label(forSegment: ScanningModeSwitchValues.scanning.rawValue)?.localizedVariant ?? "ERROR", forSegment: ScanningModeSwitchValues.scanning.rawValue)
        updateUI()
    }
    
    /* ################################################################## */
    /**
     Called just before the screen appears.
     We use this to register with the app delegate.
     */
    override func viewWillAppear() {
        super.viewWillAppear()
        appDelegateObject.screenList.addScreen(self)
    }
    
    /* ################################################################## */
    /**
     Called just before the screen disappears.
     We use this to un-register with the app delegate.
     */
    override func viewWillDisappear() {
        super.viewWillDisappear()
        appDelegateObject.screenList.removeScreen(self)
    }
    
    /* ################################################################## */
    /**
     Sets up the various accessibility labels.
     */
    override func setUpAccessibility() {
        reloadButton?.setAccessibilityLabel("SLUG-ACC-RELOAD-BUTTON".localizedVariant)
        reloadButton?.toolTip = "SLUG-ACC-RELOAD-BUTTON".localizedVariant
        scanningModeSegmentedSwitch?.setAccessibilityLabel(("SLUG-ACC-SCANNING-BUTTON-O" + ((ScanningModeSwitchValues.notScanning.rawValue == scanningModeSegmentedSwitch?.selectedSegment) ? "FF" : "N").localizedVariant))
        scanningModeSegmentedSwitch?.toolTip = ("SLUG-ACC-SCANNING-BUTTON-O" + ((ScanningModeSwitchValues.notScanning.rawValue == scanningModeSegmentedSwitch?.selectedSegment) ? "FF" : "N")).localizedVariant
        
        stackView?.setAccessibilityLabel("SLUG-ACC-DEVICELIST-TABLE-MAC".localizedVariant)
        stackView?.toolTip = "SLUG-ACC-DEVICELIST-TABLE-MAC".localizedVariant
    }
}

/* ###################################################################################################################################### */
// MARK: - IBAction Handlers -
/* ###################################################################################################################################### */
extension MacOS_DiscoveryViewController {
    /* ################################################################## */
    /**
     Called when the scanning/not scanning segmented switch changes.
     
     - parameter inSwitch: The switch object.
     */
    @IBAction func scanningChanged(_ inSwitch: NSSegmentedControl) {
        mainSplitView?.collapseSplit()
        selectedDevice = nil
        
        if ScanningModeSwitchValues.notScanning.rawValue == inSwitch.selectedSegment {
            centralManager?.stopScanning()
        } else {
            centralManager?.scanCriteria = prefs.scanCriteria
            centralManager?.minimumRSSILevelIndBm = prefs.minimumRSSILevel
            centralManager?.duplicateFilteringIsOn = !prefs.continuouslyUpdatePeripherals
            centralManager?.discoverOnlyConnectablePeripherals = prefs.discoverOnlyConnectableDevices
            centralManager?.allowEmptyNames = prefs.allowEmptyNames
            centralManager?.startScanning(duplicateFilteringIsOn: prefs.continuouslyUpdatePeripherals)
        }
        
        updateUI()
    }

    /* ################################################################## */
    /**
     This is the "Start Over From Scratch" button.
     
     - parameter: ignored
     */
    @IBAction func reloadButtonHit(_: NSButton) {
        mainSplitView?.collapseSplit()
        selectedDevice = nil
        centralManager?.startOver()
        updateUI()
    }
    
    /* ################################################################## */
    /**
     */
    @IBAction func connectButtonHit(_ inButton: MacOS_Clicker) {
        if  !(centralManager?.isScanning ?? true),
            let discoveryInfo = inButton.discoveryInfo {
            let wasConnected = discoveryInfo.identifier == selectedDevice?.identifier
            discoveryInfo.disconnect()
            selectedDevice = nil
            _reloadStackView()
            MacOS_AppDelegate.appDelegateObject.collapseSplit()
            if  !wasConnected,
                let newController = storyboard?.instantiateController(withIdentifier: MacOS_PeripheralViewController.storyboardID) as? MacOS_PeripheralViewController {
                selectedDevice = discoveryInfo
                newController.peripheralInstance = discoveryInfo
                mainSplitView?.setPeripheralViewController(newController)
            }
            _reloadStackView()
        }
    }
}

/* ###################################################################################################################################### */
// MARK: - MacOS_Base_ViewController_Protocol Conformance -
/* ###################################################################################################################################### */
extension MacOS_DiscoveryViewController: MacOS_ControllerList_Protocol {
    /* ################################################################## */
    /**
     This forces the UI elements to be updated.
     */
    func updateUI() {
        noBTImage?.isHidden = centralManager?.isBTAvailable ?? true
        scanningModeSegmentedSwitch?.isHidden = !(noBTImage?.isHidden ?? false)
        scrollView?.isHidden = !(noBTImage?.isHidden ?? false)
        reloadButton?.isHidden = sortedPeripherals.isEmpty
        scanningModeSegmentedSwitch?.setSelected(true, forSegment: (centralManager?.isScanning ?? false) ? ScanningModeSwitchValues.scanning.rawValue : ScanningModeSwitchValues.notScanning.rawValue)
        setUpAccessibility()
        _reloadStackView()
    }
}

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

import Foundation
import ClockKit

/* ###################################################################################################################################### */
// MARK: - Complication Controller Class -
/* ###################################################################################################################################### */
/**
 This adds support for the various complications provided by this app.
 
 These complications are about as simple as you can get. They just bring up the app. No state info is displayed.
 */
class CGA_ComplicationController: NSObject {
}

/* ###################################################################################################################################### */
// MARK: - Private Methods
/* ###################################################################################################################################### */
extension CGA_ComplicationController {
    /* ################################################################## */
    /**
     This is a generic template generator.
     
     - parameter for: The complication we're generating this for.
     
     - returns: a Complication Template object.
     */
    private func _makeTemplateObject(for inComplication: CLKComplication) -> CLKComplicationTemplate? {
        #if DEBUG
            print("Template requested for complication (Part 1): \(inComplication.family)")
        #endif
        
        switch inComplication.family {
        case .circularSmall:
            #if DEBUG
                print("Template requested for circularSmall")
            #endif
            if let templateImage = UIImage(named: "Complication/Circular") {
                let templateTmp = CLKComplicationTemplateCircularSmallSimpleImage()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            } else {
                #if DEBUG
                    print("Complication/Circular Not Available")
                #endif
            }
        case .extraLarge:
            #if DEBUG
                print("Template requested for extraLarge")
            #endif
            if let templateImage = UIImage(named: "Complication/Extra Large") {
                let templateTmp = CLKComplicationTemplateExtraLargeSimpleImage()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            } else {
                #if DEBUG
                    print("Complication/Extra Large Not Available")
                #endif
            }
        default:
            return _makeModularTemplateObject(for: inComplication)
        }
        
        return nil
    }
    
    /* ################################################################## */
    /**
     This is a modular template generator.
     
     - parameter for: The complication we're generating this for.
     
     - returns: a Complication Template object.
     */
    private func _makeModularTemplateObject(for inComplication: CLKComplication) -> CLKComplicationTemplate? {
        #if DEBUG
            print("Template requested for complication (Part 2): \(String(describing: inComplication))")
        #endif
        
        switch inComplication.family {
        case .modularSmall:
            #if DEBUG
                print("Template requested for modularSmall")
            #endif
            if let templateImage = UIImage(named: "Complication/Modular") {
                let templateTmp = CLKComplicationTemplateModularSmallSimpleImage()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            } else {
                #if DEBUG
                    print("Complication/Modular Not Available")
                #endif
            }
        default:
            return _makeUtilitarianTemplateObject(for: inComplication)
        }
        
        return nil
    }
    
    /* ################################################################## */
    /**
     This is a utilitarian template generator.
     
     - parameter for: The complication we're generating this for.
     
     - returns: a Complication Template object.
     */
    private func _makeUtilitarianTemplateObject(for inComplication: CLKComplication) -> CLKComplicationTemplate? {
        #if DEBUG
            print("Template requested for complication (Part 3): \(String(describing: inComplication))")
        #endif
        
        switch inComplication.family {
        case .utilitarianSmall:
            #if DEBUG
                print("Template requested for utilitarianSmall")
            #endif
            if let templateImage = UIImage(named: "Complication/Utilitarian") {
                let templateTmp = CLKComplicationTemplateUtilitarianSmallSquare()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            } else {
                #if DEBUG
                    print("Complication/Utilitarian Not Available (Small)")
                #endif
            }
        case .utilitarianSmallFlat:
            #if DEBUG
                print("Template requested for utilitarianSmallFlat")
            #endif
            if let templateImage = UIImage(named: "Complication/Utilitarian") {
                let templateTmp = CLKComplicationTemplateUtilitarianSmallFlat()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            } else {
                #if DEBUG
                    print("Complication/Utilitarian Not Available (Small Flat)")
                #endif
            }
        case .utilitarianLarge:
            #if DEBUG
                print("Template requested for utilitarianLarge")
            #endif
            if let templateImage = UIImage(named: "Complication/Utilitarian") {
                let templateTmp = CLKComplicationTemplateUtilitarianLargeFlat()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            } else {
                #if DEBUG
                    print("Complication/Utilitarian Not Available (Large)")
                #endif
            }
        default:
            return _makeGraphicTemplateObject(for: inComplication)
        }
        
        return nil
    }
    
    /* ################################################################## */
    /**
     This is a graphic template generator.
     
     - parameter for: The complication we're generating this for.
     
     - returns: a Complication Template object.
     */
    private func _makeGraphicTemplateObject(for inComplication: CLKComplication) -> CLKComplicationTemplate? {
        #if DEBUG
            print("Template requested for complication (Part 4): \(String(describing: inComplication))")
        #endif
        
        switch inComplication.family {
        case .graphicCircular:
            #if DEBUG
                print("Template requested for graphicCircular")
            #endif
            if  let image = UIImage(named: "Complication/Graphic Circular") {
                let templateTmp = CLKComplicationTemplateGraphicCircularImage()
                templateTmp.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
                return templateTmp
            } else {
                #if DEBUG
                    print("Complication/Graphic Circular Not Available")
                #endif
            }
        case .graphicCorner:
            #if DEBUG
                print("Template requested for graphicCorner")
            #endif
            if  let image = UIImage(named: "Complication/Graphic Corner") {
                let templateTmp = CLKComplicationTemplateGraphicCornerCircularImage()
                templateTmp.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
                return templateTmp
            } else {
                #if DEBUG
                    print("Complication/Graphic Corner Not Available")
                #endif
            }
        case .graphicBezel:
            #if DEBUG
                print("Template requested for graphicBezel")
            #endif
            if let image = UIImage(named: "Complication/Graphic Bezel") {
                let circularItem = CLKComplicationTemplateGraphicCornerCircularImage()
                circularItem.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
                return circularItem
            } else {
                #if DEBUG
                    print("Complication/Graphic Bezel Not Available")
                #endif
            }
        case .graphicRectangular:
            #if DEBUG
                print("Template requested for graphicRectangular")
            #endif
            if let templateImage = UIImage(named: "Complication/Graphic Large Rectangular") {
                let templateTmp = CLKComplicationTemplateGraphicRectangularLargeImage()
                templateTmp.imageProvider = CLKFullColorImageProvider(fullColorImage: templateImage)
                templateTmp.textProvider = CLKSimpleTextProvider(text: Bundle.main.appDisplayName)
                return templateTmp
            } else {
                #if DEBUG
                    print("Complication/Graphic Large Rectangular Not Available")
                #endif
            }
        default:
            #if DEBUG
                print("Giving up for: \(inComplication.family)")
            #else
                break
            #endif
        }
        
        return nil
    }
}

/* ###################################################################################################################################### */
// MARK: - CLKComplicationDataSource Conformance -
/* ###################################################################################################################################### */
/**
 This adds support for the various complications provided by this app.
 */
extension CGA_ComplicationController: CLKComplicationDataSource {
    func getNextRequestedUpdateDateWithHandler(handler inHandler: (NSDate?) -> Void) {
        #if DEBUG
            print("Timeline Next Refresh Requested.")
        #endif
        inHandler(NSDate(timeIntervalSinceNow: 1))
    }

    /* ################################################################## */
    /**
     This sets the current timeline entry for the complication.
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getCurrentTimelineEntry(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        #if DEBUG
            print("Timeline Entry Requested for: \(String(describing: inComplication))")
        #endif
        if let templateObject = _makeTemplateObject(for: inComplication) {
            switch inComplication.family {
            case .modularLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateModularLargeStandardBody {
                    #if DEBUG
                        print("Modular Large Returned.")
                    #endif
                    inHandler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject))
                } else {
                    #if DEBUG
                        print("Modular Large Not Available.")
                    #endif
                    inHandler(nil)
                }
            case .utilitarianSmall:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianSmallFlat {
                    #if DEBUG
                        print("Utilitarian Small Flat Returned.")
                    #endif
                    inHandler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject))
                } else {
                    #if DEBUG
                        print("Utilitarian Small Flat Not Available.")
                    #endif
                    inHandler(nil)
                }
            case .utilitarianLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianLargeFlat {
                    #if DEBUG
                        print("Utilitarian Large Flat Returned.")
                    #endif
                    inHandler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject))
                } else {
                    #if DEBUG
                        print("Utilitarian Large Flat Not Available.")
                    #endif
                    inHandler(nil)
                }
            case .graphicRectangular:
                if  let tObject = templateObject as? CLKComplicationTemplateGraphicRectangularStandardBody {
                    #if DEBUG
                        print("Graphic Rectangular Standard Returned.")
                    #endif
                    inHandler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject))
                } else {
                    #if DEBUG
                        print("Graphic Rectangular Standard Not Available.")
                    #endif
                    inHandler(nil)
                }
            default:
                inHandler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: templateObject))
            }
        } else {
            inHandler(nil)
        }
    }
    
    /* ################################################################## */
    /**
     This sets the supported placeholder for the composer.
     
     - parameter complication: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getLocalizableSampleTemplate(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTemplate?) -> Void) {
        #if DEBUG
            print("Localizable Template Placeholder Requested for: \(String(describing: inComplication))")
        #endif
        getPlaceholderTemplateForComplication(complication: inComplication, withHandler: inHandler)
    }
    
    /* ################################################################## */
    /**
     This sets the supported placeholder.
     
     - parameter complication: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    public func getPlaceholderTemplateForComplication(complication inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTemplate?) -> Void) {
        #if DEBUG
            print("Placeholder Requested for: \(String(describing: inComplication))")
        #endif
        if let templateObject = _makeTemplateObject(for: inComplication) {
            switch inComplication.family {
            case .modularLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateModularLargeStandardBody {
                    #if DEBUG
                        print("Modular Large Returned (Template).")
                    #endif
                    inHandler(tObject)
                } else {
                    #if DEBUG
                        print("Modular Large Not Available (Template).")
                    #endif
inHandler(nil)
                }
            case .utilitarianSmall:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianSmallFlat {
                    #if DEBUG
                        print("Utilitarian Small Returned (Template).")
                    #endif
                    inHandler(tObject)
                } else {
                    #if DEBUG
                        print("Utilitarian Small Not Available (Template).")
                    #endif
                    inHandler(nil)
                }
            case .utilitarianLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianLargeFlat {
                    #if DEBUG
                        print("Utilitarian Large Returned (Template).")
                    #endif
                    inHandler(tObject)
                } else {
                    #if DEBUG
                        print("Utilitarian Large Not Available (Template).")
                    #endif
                    inHandler(nil)
                }
            case .graphicRectangular:
                if  let tObject = templateObject as? CLKComplicationTemplateGraphicRectangularLargeImage {
                    #if DEBUG
                        print("Graphic Rectangular Returned (Template).")
                    #endif
                    inHandler(tObject)
                } else {
                    #if DEBUG
                        print("Graphic Rectangular Not Available (Template).")
                    #endif
                    inHandler(nil)
                }
            default:
                inHandler(templateObject)
            }
        } else {
            inHandler(nil)
        }
    }
    
    /* ################################################################## */
    /**
     This sets the supported Time Travel directions (We don't do any).
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getSupportedTimeTravelDirections(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        #if DEBUG
            print("Supported Timeline Directions Requested for: \(String(describing: inComplication))")
        #endif
        inHandler([])
    }
    
    /* ################################################################## */
    /**
     This sets the template object for the complication when in "always on" mode.
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getAlwaysOnTemplate(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTemplate?) -> Void) {
        #if DEBUG
            print("Always On Template Requested for: \(String(describing: inComplication))")
        #endif
        getLocalizableSampleTemplate(for: inComplication, withHandler: inHandler)
    }
    
    /* ################################################################## */
    /**
     Sets the (non-existent) end date for the (non-existent) timeline.
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getTimelineEndDate(for inComplication: CLKComplication, withHandler inHandler: @escaping (Date?) -> Void) {
        #if DEBUG
            print("Timeline End Date Requested for: \(String(describing: inComplication))")
        #endif
        inHandler(nil)
    }
    
    /* ################################################################## */
    /**
     This is called to populate a set of timeline entries (should never be called).
     
     - parameter for: The complication we're generating this for.
     - parameter before: The date, before which the entries should be provided.
     - parameter limit: The number of entries to provide.
     - parameter withHandler: The inHandler method to be called.
     */
    func getTimelineEntries(for inComplication: CLKComplication, before inDate: Date, limit inLimit: Int, withHandler inHandler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        #if DEBUG
            print("Timeline Entries Before \(inDate) Requested for: \(String(describing: inComplication))")
        #endif
        if let templateObject = _makeTemplateObject(for: inComplication) {
            switch inComplication.family {
            case .modularLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateModularLargeStandardBody {
                    inHandler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject)])
                } else {
                    inHandler(nil)
                }
            case .utilitarianSmall:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianSmallFlat {
                    inHandler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject)])
                } else {
                    inHandler(nil)
                }
            case .utilitarianLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianLargeFlat {
                    inHandler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject)])
                } else {
                    inHandler(nil)
                }
            case .graphicRectangular:
                if  let tObject = templateObject as? CLKComplicationTemplateGraphicRectangularStandardBody {
                    inHandler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject)])
                } else {
                    inHandler(nil)
                }
            default:
                inHandler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: templateObject)])
            }
        } else {
            inHandler(nil)
        }
    }
    
    /* ################################################################## */
    /**
     This is called to populate a set of timeline entries (should never be called).
     
     - parameter for: The complication we're generating this for.
     - parameter after: The date, after which the entries should be provided.
     - parameter limit: The number of entries to provide.
     - parameter withHandler: The inHandler method to be called.
     */
    func getTimelineEntries(for inComplication: CLKComplication, after inDate: Date, limit inLimit: Int, withHandler inHandler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        #if DEBUG
            print("Timeline Entries After \(inDate) Requested for: \(String(describing: inComplication))")
        #endif
        if let templateObject = _makeTemplateObject(for: inComplication) {
            switch inComplication.family {
            case .modularLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateModularLargeStandardBody {
                    inHandler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject)])
                } else {
                    inHandler(nil)
                }
            case .utilitarianSmall:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianSmallFlat {
                    inHandler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject)])
                } else {
                    inHandler(nil)
                }
            case .utilitarianLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianLargeFlat {
                    inHandler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject)])
                } else {
                    inHandler(nil)
                }
            case .graphicRectangular:
                if  let tObject = templateObject as? CLKComplicationTemplateGraphicRectangularStandardBody {
                    inHandler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject)])
                } else {
                    inHandler(nil)
                }
            default:
                inHandler([CLKComplicationTimelineEntry(date: Date(), complicationTemplate: templateObject)])
            }
        } else {
            inHandler(nil)
        }
    }

    /* ################################################################## */
    /**
     This is called to say whether or not to display the complication in lock.
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getPrivacyBehavior(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        #if DEBUG
            print("Timeline Privacy Behavior Requested for: \(String(describing: inComplication))")
        #endif
        inHandler(.showOnLockScreen)
    }
}

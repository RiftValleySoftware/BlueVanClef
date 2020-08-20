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
        switch inComplication.family {
        case .circularSmall:
            if let templateImage = UIImage(named: "Complication/Circular") {
                let templateTmp = CLKComplicationTemplateCircularSmallSimpleImage()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            }
        case .extraLarge:
            if let templateImage = UIImage(named: "Complication/ExtraLarge") {
                let templateTmp = CLKComplicationTemplateExtraLargeSimpleImage()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
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
        switch inComplication.family {
        case .modularSmall:
            if let templateImage = UIImage(named: "Complication/Modular") {
                let templateTmp = CLKComplicationTemplateModularSmallSimpleImage()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
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
        switch inComplication.family {
        case .utilitarianSmall:
            if let templateImage = UIImage(named: "Complication/Utilitarian") {
                let templateTmp = CLKComplicationTemplateUtilitarianSmallSquare()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            }
        case .utilitarianSmallFlat:
            if let templateImage = UIImage(named: "Complication/Utilitarian") {
                let templateTmp = CLKComplicationTemplateUtilitarianSmallFlat()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            }
        case .utilitarianLarge:
            if let templateImage = UIImage(named: "Complication/Utilitarian") {
                let templateTmp = CLKComplicationTemplateUtilitarianLargeFlat()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                templateTmp.textProvider = CLKTextProvider(format: "SLUG-APP-NAME".localizedVariant)
                return templateTmp
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
        switch inComplication.family {
        case .graphicCircular:
            if  let image = UIImage(named: "Complication/GraphicCircular") {
                let templateTmp = CLKComplicationTemplateGraphicCircularImage()
                templateTmp.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
                return templateTmp
            }
        case .graphicCorner:
            if  let image = UIImage(named: "Complication/GraphicCorner") {
                let templateTmp = CLKComplicationTemplateGraphicCornerCircularImage()
                templateTmp.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
                return templateTmp
            }
        case .graphicRectangular:
            if let templateImage = UIImage(named: "Complication/GraphicLargeRectangular") {
                let templateTmp = CLKComplicationTemplateGraphicRectangularLargeImage()
                templateTmp.imageProvider = CLKFullColorImageProvider(fullColorImage: templateImage)
                templateTmp.textProvider = CLKSimpleTextProvider(text: "SLUG-APP-NAME".localizedVariant)
                return templateTmp
            }
        default:
            break
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
    /* ################################################################## */
    /**
     This sets the current timeline entry for the complication.
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getCurrentTimelineEntry(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        if let templateObject = _makeTemplateObject(for: inComplication) {
            switch inComplication.family {
            case .modularLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateModularLargeStandardBody {
                    inHandler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject))
                } else {
                    inHandler(nil)
                }
            case .utilitarianSmall:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianSmallFlat {
                    inHandler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject))
                } else {
                    inHandler(nil)
                }
            case .utilitarianLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianLargeFlat {
                    inHandler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject))
                } else {
                    inHandler(nil)
                }
            case .graphicRectangular:
                if  let tObject = templateObject as? CLKComplicationTemplateGraphicRectangularStandardBody {
                    inHandler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: tObject))
                } else {
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
     This sets the supported placeholder.
     
     - parameter complication: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    public func getPlaceholderTemplateForComplication(complication inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTemplate?) -> Void) {
        if let templateObject = _makeTemplateObject(for: inComplication) {
            switch inComplication.family {
            case .modularLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateModularLargeStandardBody {
                    inHandler(tObject)
                } else {
                    inHandler(nil)
                }
            case .utilitarianSmall:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianSmallFlat {
                    inHandler(tObject)
                } else {
                    inHandler(nil)
                }
            case .utilitarianLarge:
                if  let tObject = templateObject as? CLKComplicationTemplateUtilitarianLargeFlat {
                    inHandler(tObject)
                } else {
                    inHandler(nil)
                }
            case .graphicRectangular:
                if  let tObject = templateObject as? CLKComplicationTemplateGraphicRectangularLargeImage {
                    inHandler(tObject)
                } else {
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
     This is called to populate a set of timeline entries (should never be called).
     
     - parameter for: The complication we're generating this for.
     - parameter before: The date, before which the entries should be provided.
     - parameter limit: The number of entries to provide.
     - parameter withHandler: The inHandler method to be called.
     */
    func getTimelineEntries(for inComplication: CLKComplication, before inDate: Date, limit inLimit: Int, withHandler inHandler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
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
     This sets the template object for the complication when in "always on" mode.
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getAlwaysOnTemplate(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTemplate?) -> Void) { getLocalizableSampleTemplate(for: inComplication, withHandler: inHandler) }
    
    /* ################################################################## */
    /**
     This sets the supported placeholder for the composer.
     
     - parameter complication: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getLocalizableSampleTemplate(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTemplate?) -> Void) { getPlaceholderTemplateForComplication(complication: inComplication, withHandler: inHandler) }

    /* ################################################################## */
    /**
     Sets the (non-existent) end date for the (non-existent) timeline.
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getTimelineEndDate(for inComplication: CLKComplication, withHandler inHandler: @escaping (Date?) -> Void) { inHandler(nil) }

    /* ################################################################## */
    /**
     This is called to say whether or not to display the complication in lock.
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getPrivacyBehavior(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationPrivacyBehavior) -> Void) { inHandler(.showOnLockScreen) }
    
    /* ################################################################## */
    /**
     This sets the supported Time Travel directions (We don't do any).
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getSupportedTimeTravelDirections(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTimeTravelDirections) -> Void) { inHandler([]) }
    
    /* ################################################################## */
    /**
     This returns the (nonexistent) refresh period.
     
     - parameter withHandler: The inHandler method to be called.
     */
    func getNextRequestedUpdateDateWithHandler(handler inHandler: (NSDate?) -> Void) { inHandler(nil) }
}

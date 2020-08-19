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
            if let templateImage = UIImage(named: "Complication/Circular") {
                let templateTmp = CLKComplicationTemplateCircularSmallSimpleImage()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            }
        case .extraLarge:
            if let templateImage = UIImage(named: "Complication/Extra Large") {
                let templateTmp = CLKComplicationTemplateExtraLargeStackImage()
                templateTmp.line1ImageProvider = CLKImageProvider(onePieceImage: templateImage)
                templateTmp.line2TextProvider = CLKRelativeDateTextProvider(date: Date(), style: CLKRelativeDateStyle.natural, units: [.day])
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
        #if DEBUG
            print("Template requested for complication (Part 2): \(String(describing: inComplication.family))")
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
            print("Template requested for complication (Part 3): \(String(describing: inComplication.family))")
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
            }
        case .utilitarianSmallFlat:
            #if DEBUG
                print("Template requested for utilitarianSmallFlat")
            #endif
            if let templateImage = UIImage(named: "Complication/Utilitarian") {
                let templateTmp = CLKComplicationTemplateUtilitarianSmallFlat()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
                return templateTmp
            }
        case .utilitarianLarge:
            #if DEBUG
                print("Template requested for utilitarianLarge")
            #endif
            if let templateImage = UIImage(named: "Complication/Utilitarian") {
                let templateTmp = CLKComplicationTemplateUtilitarianLargeFlat()
                templateTmp.imageProvider = CLKImageProvider(onePieceImage: templateImage)
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
        #if DEBUG
            print("Template requested for complication (Part 4): \(String(describing: inComplication.family))")
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
            }
        case .graphicCorner:
            #if DEBUG
                print("Template requested for graphicCorner")
            #endif
            if  let image = UIImage(named: "Complication/Graphic Corner") {
                let templateTmp = CLKComplicationTemplateGraphicCornerCircularImage()
                templateTmp.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
                return templateTmp
            }
        case .graphicBezel:
            #if DEBUG
                print("Template requested for graphicBezel")
            #endif
            if let image = UIImage(named: "Complication/Graphic Bezel") {
                let circularItem = CLKComplicationTemplateGraphicCircularImage()
                circularItem.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
                return circularItem
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
        #if DEBUG
            print("Timeline Entry Requested for: \(inComplication.family)")
        #endif
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
    public func getPlaceholderTemplateForComplication(complication inComplication: CLKComplication, withHandler inHandler: (CLKComplicationTemplate?) -> Void) {
        #if DEBUG
            print("Placeholder Requested for: \(inComplication.family)")
        #endif
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
     This sets the supported Time Travel directions (We don't do any).
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getSupportedTimeTravelDirections(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        inHandler([])
    }
    
    /* ################################################################## */
    /**
     This sets the template object for the complication.
     
     - parameter for: The complication we're generating this for.
     - parameter withHandler: The inHandler method to be called.
     */
    func getLocalizableSampleTemplate(for inComplication: CLKComplication, withHandler inHandler: @escaping (CLKComplicationTemplate?) -> Void) {
        inHandler(_makeTemplateObject(for: inComplication))
    }
}

//
//  RGBChannelBrightnessAndContrast.swift
//  filters
//
//  Created by Toni Jovanoski on 2/8/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import CoreImage

class RGBChannelBrightnessAndContrast: CIFilter {
    var inputImage: CIImage?
    
    var inputRedBrightness: CGFloat = 0
    var inputRedContrast: CGFloat = 1
    
    var inputGreenBrightness: CGFloat = 0
    var inputGreenContrast: CGFloat = 1
    
    var inputBlueBrightness: CGFloat = 0
    var inputBlueContrast: CGFloat = 1
    
    let rgbChannelCompositing = RGBChannelCompositing()
    
    override func setDefaults()
    {
        inputRedBrightness = 0
        inputRedContrast = 1
        
        inputGreenBrightness = 0
        inputGreenContrast = 1
        
        inputBlueBrightness = 0
        inputBlueContrast = 1
    }
    
    override var attributes: [String : Any] {
        return [
            kCIAttributeFilterDisplayName: "RGB Brightness And Contrast",
            
            "inputImage": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIImage",
                kCIAttributeDisplayName: "Image",
                kCIAttributeType: kCIAttributeTypeImage],
            
            "inputRedBrightness": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 0,
                kCIAttributeDisplayName: "Red Brightness",
                kCIAttributeMin: 1,
                kCIAttributeSliderMin: -1,
                kCIAttributeSliderMax: 1,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputRedContrast": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 1,
                kCIAttributeDisplayName: "Red Contrast",
                kCIAttributeMin: 0.25,
                kCIAttributeSliderMin: 0.25,
                kCIAttributeSliderMax: 4,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputGreenBrightness": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 0,
                kCIAttributeDisplayName: "Green Brightness",
                kCIAttributeMin: 1,
                kCIAttributeSliderMin: -1,
                kCIAttributeSliderMax: 1,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputGreenContrast": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 1,
                kCIAttributeDisplayName: "Green Contrast",
                kCIAttributeMin: 0.25,
                kCIAttributeSliderMin: 0.25,
                kCIAttributeSliderMax: 4,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputBlueBrightness": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 0,
                kCIAttributeDisplayName: "Blue Brightness",
                kCIAttributeMin: 1,
                kCIAttributeSliderMin: -1,
                kCIAttributeSliderMax: 1,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputBlueContrast": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 1,
                kCIAttributeDisplayName: "Blue Contrast",
                kCIAttributeMin: 0.25,
                kCIAttributeSliderMin: 0.25,
                kCIAttributeSliderMax: 4,
                kCIAttributeType: kCIAttributeTypeScalar]
        ]
    }
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        
        let red = inputImage.applyingFilter("CIColorControls", withInputParameters: [kCIInputBrightnessKey: inputRedBrightness, kCIInputContrastKey: inputRedContrast])
        
        let green = inputImage.applyingFilter("CIColorControls", withInputParameters: [kCIInputBrightnessKey: inputGreenBrightness, kCIInputContrastKey: inputGreenContrast])
        
        let blue = inputImage.applyingFilter("CIColorControls", withInputParameters: [kCIInputBrightnessKey: inputBlueBrightness, kCIInputContrastKey: inputBlueContrast])
        
        rgbChannelCompositing.inputRedImage = red
        rgbChannelCompositing.inputGreenImage = green
        rgbChannelCompositing.inputBlueImage = blue
        
        return rgbChannelCompositing.outputImage
    }
}

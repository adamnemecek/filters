//
//  StarBurst.swift
//  filters
//
//  Created by Toni Jovanoski on 2/7/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import CoreImage

class StarBustFilter: CIFilter {
    var inputImage: CIImage?
    var inputThreshold: CGFloat = 0.9
    var inputRadius: CGFloat = 20
    var inputAngle: CGFloat = 0
    var inputBeamCount: Int = 3
    var inputStarbustBrightness: CGFloat = 0
    
    let thresholdFilter = ThresholdFilter()
    
    override var attributes: [String : Any] {
        return [
            kCIAttributeFilterDisplayName: "Starburst Filter",
            "inputImage": [kCIAttributeIdentity: 0,
                           kCIAttributeClass: "CIImage",
                           kCIAttributeDisplayName: "Image",
                           kCIAttributeType: kCIAttributeTypeImage],
            
            "inputThreshold": [kCIAttributeIdentity: 0,
                               kCIAttributeClass: "NSNumber",
                               kCIAttributeDefault: 0.9,
                               kCIAttributeDisplayName: "Threshold",
                               kCIAttributeMin: 0,
                               kCIAttributeSliderMin: 0,
                               kCIAttributeSliderMax: 1,
                               kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputRadius": [kCIAttributeIdentity: 0,
                            kCIAttributeClass: "NSNumber",
                            kCIAttributeDefault: 20,
                            kCIAttributeDisplayName: "Radius",
                            kCIAttributeMin: 0,
                            kCIAttributeSliderMin: 0,
                            kCIAttributeSliderMax: 100,
                            kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputAngle": [kCIAttributeIdentity: 0,
                           kCIAttributeClass: "NSNumber",
                           kCIAttributeDefault: 0,
                           kCIAttributeDisplayName: "Angle",
                           kCIAttributeMin: 0,
                           kCIAttributeSliderMin: 0,
                           kCIAttributeSliderMax: M_PI,
                           kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputStarburstBrightness": [kCIAttributeIdentity: 0,
                                         kCIAttributeClass: "NSNumber",
                                         kCIAttributeDefault: 0,
                                         kCIAttributeDisplayName: "Starburst Brightness",
                                         kCIAttributeMin: -1,
                                         kCIAttributeSliderMin: -1,
                                         kCIAttributeSliderMax: 0.5,
                                         kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputBeamCount": [kCIAttributeIdentity: 0,
                               kCIAttributeClass: "NSNumber",
                               kCIAttributeDefault: 3,
                               kCIAttributeDisplayName: "Beam Count",
                               kCIAttributeMin: 1,
                               kCIAttributeSliderMin: 1,
                               kCIAttributeSliderMax: 10,
                               kCIAttributeType: kCIAttributeTypeInteger]
        ]
    }
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        
        thresholdFilter.inputThreshold = inputThreshold
        thresholdFilter.inputImage = inputImage
        
        let thresholdImage = thresholdFilter.outputImage!
        
        let starBustAccumulator = CIImageAccumulator(extent: thresholdImage.extent, format: kCIFormatARGB8)
        
        for i in 0..<inputBeamCount {
            let angle = CGFloat((M_PI / Double(inputBeamCount)) * Double(i))
            
            let starBust = thresholdImage.applyingFilter("CIMotionBlur", withInputParameters: [kCIInputRadiusKey: inputRadius, kCIInputAngleKey: inputAngle + angle]).cropping(to: thresholdImage.extent).applyingFilter("CIAdditionCompositing", withInputParameters: [kCIInputBackgroundImageKey: starBustAccumulator?.image()])
            
            starBustAccumulator?.setImage(starBust)
        }
        
        let adjustedStarBust = starBustAccumulator?.image().applyingFilter("CIColorControls", withInputParameters: [kCIInputBrightnessKey: inputStarbustBrightness])
        
        let final = inputImage.applyingFilter("CIAdditionCompositing", withInputParameters: [kCIInputBackgroundImageKey: adjustedStarBust!])
        
        return final
    }
    
}

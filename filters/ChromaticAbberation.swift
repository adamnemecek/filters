//
//  ChromaticAbberation.swift
//  filters
//
//  Created by Toni Jovanoski on 2/9/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import CoreImage
import CoreGraphics

let tau = CGFloat(M_PI * 2)

class ChromaticAbberation: CIFilter {
    var inputImage: CIImage?
    
    var inputAngle: CGFloat = 0
    var inputRadius: CGFloat = 2
    
    let rgbChannelCompositing = RGBChannelCompositing()
    
    override func setDefaults() {
        inputAngle = 0
        inputRadius = 2
    }
    
    override var attributes: [String : Any] {
        return [
            kCIAttributeFilterDisplayName: "Chromatic Abberation",
            
            "inputImage": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIImage",
                kCIAttributeDisplayName: "Image",
                kCIAttributeType: kCIAttributeTypeImage],
            
            "inputAngle": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 0,
                kCIAttributeDisplayName: "Angle",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: tau,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputRadius": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 2,
                kCIAttributeDisplayName: "Radius",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 25,
                kCIAttributeType: kCIAttributeTypeScalar],
        ]
    }

    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        
        let redAngle = inputAngle + tau
        let greenAngle = inputAngle + tau * 0.333
        let blueAngle = inputAngle + tau * 0.666
        
        let redTransform = CGAffineTransform(translationX: sin(redAngle) * inputRadius, y: cos(redAngle) * inputRadius)
        let greenTransform = CGAffineTransform(translationX: sin(greenAngle) * inputRadius, y: cos(greenAngle) * inputRadius)
        let blueTransform = CGAffineTransform(translationX: sin(blueAngle) * inputRadius, y: cos(blueAngle) * inputRadius)
        
        let red = inputImage.applyingFilter("CIAffineTransform", withInputParameters: [kCIInputTransformKey: NSValue(cgAffineTransform: redTransform)]).cropping(to: inputImage.extent)
        
        let green = inputImage.applyingFilter("CIAffineTransform", withInputParameters: [kCIInputTransformKey: NSValue(cgAffineTransform: greenTransform)]).cropping(to: inputImage.extent)
        
        let blue = inputImage.applyingFilter("CIAffineTransform", withInputParameters: [kCIInputTransformKey: NSValue(cgAffineTransform: blueTransform)]).cropping(to: inputImage.extent)
        
        rgbChannelCompositing.inputRedImage = red
        rgbChannelCompositing.inputGreenImage = green
        rgbChannelCompositing.inputBlueImage = blue
        
        return rgbChannelCompositing.outputImage
    }
}

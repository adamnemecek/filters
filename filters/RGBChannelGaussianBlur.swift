//
//  RGBChannelGaussianBlur.swift
//  filters
//
//  Created by Toni Jovanoski on 2/8/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import CoreImage

class RGBChannelGaussianBlur: CIFilter {
    var inputImage: CIImage?
    
    var inputRedRadius: CGFloat = 2
    var inputGreenRadius: CGFloat = 4
    var inputBlueRadius: CGFloat = 8
    
    let rgbChannelCompositing = RGBChannelCompositing()
    
    override func setDefaults()
    {
        inputRedRadius = 2
        inputGreenRadius = 4
        inputBlueRadius = 8
    }
    
    override var attributes: [String : Any] {
        return [
            kCIAttributeFilterDisplayName: "RGB Channel Gaussian Blur",
            
            "inputImage": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIImage",
                kCIAttributeDisplayName: "Image",
                kCIAttributeType: kCIAttributeTypeImage],
            
            "inputRedRadius": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 2,
                kCIAttributeDisplayName: "Red Radius",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 100,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputGreenRadius": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 4,
                kCIAttributeDisplayName: "Green Radius",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 100,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputBlueRadius": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 8,
                kCIAttributeDisplayName: "Blue Radius",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 100,
                kCIAttributeType: kCIAttributeTypeScalar]
        ]
    }

    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
            return nil
        }
        
        let red = inputImage.applyingFilter("CIGaussianBlur", withInputParameters: [kCIInputRadiusKey: inputRedRadius]).cropping(to: inputImage.extent)
        let green = inputImage.applyingFilter("CIGaussianBlur", withInputParameters: [kCIInputRadiusKey: inputGreenRadius]).cropping(to: inputImage.extent)
        let blue = inputImage.applyingFilter("CIGaussianBlur", withInputParameters: [kCIInputRadiusKey: inputBlueRadius]).cropping(to: inputImage.extent)
        
        rgbChannelCompositing.inputRedImage = red
        rgbChannelCompositing.inputGreenImage = green
        rgbChannelCompositing.inputBlueImage = blue
        
        return rgbChannelCompositing.outputImage
    }
}

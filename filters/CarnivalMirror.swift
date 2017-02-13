//
//  CarnivalMirror.swift
//  filters
//
//  Created by Toni Jovanoski on 2/14/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import CoreImage

class CarnivalMirror: CIFilter {
    var inputImage: CIImage?
    
    var inputHorWavelength: CGFloat = 10
    var inputHorAmount: CGFloat = 20
    
    var inputVerWavelength: CGFloat = 10
    var inputVerAmount: CGFloat = 20
    
    override func setDefaults() {
        inputHorWavelength = 10
        inputHorAmount = 20
        inputVerWavelength = 10
        inputVerAmount = 20
    }
    
    override var attributes: [String : Any] {
        return [
            kCIAttributeFilterDisplayName: "Carnival Mirror",
            
            "inputImage": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIImage",
                kCIAttributeDisplayName: "Image",
                kCIAttributeType: kCIAttributeTypeImage],
            
            "inputHorizontalWavelength": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 10,
                kCIAttributeDisplayName: "Horizontal Wavelength",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 100,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputHorizontalAmount": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 20,
                kCIAttributeDisplayName: "Horizontal Amount",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 100,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputVerticalWavelength": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 10,
                kCIAttributeDisplayName: "Vertical Wavelength",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 100,
                kCIAttributeType: kCIAttributeTypeScalar],
            
            "inputVerticalAmount": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 20,
                kCIAttributeDisplayName: "Vertical Amount",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 100,
                kCIAttributeType: kCIAttributeTypeScalar]
        ]
    }
    
    let carnivalMirrorKernel = CIWarpKernel(string:
        "kernel vec2 carnivalMirror(float xWavelength, float xAmount, float yWavelength, float yAmount)" +
        "{" +
        "   float y = destCoord().y + sin(destCoord().y / yWavelength) * yAmount; " +
        "   float x = destCoord().x + sin(destCoord().x / xWavelength) * xAmount; " +
        "   return vec2(x, y);" +
        "}")
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage, let kernel = carnivalMirrorKernel else {
                return nil
        }
        
        let arguments = [inputHorWavelength, inputHorAmount, inputVerWavelength, inputVerAmount]
        
        let extent = inputImage.extent
        
        return kernel.apply(withExtent: extent, roiCallback: { (index, rect) -> CGRect in
            return rect
        }, inputImage: inputImage, arguments: arguments)
    }
}

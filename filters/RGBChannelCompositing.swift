//
//  RGBChannelCompositing.swift
//  filters
//
//  Created by Toni Jovanoski on 2/7/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import CoreImage

class RGBChannelCompositing: CIFilter {
    var inputRedImage: CIImage?
    var inputGreenImage: CIImage?
    var inputBlueImage: CIImage?
    
    let kernel = CIColorKernel(string:
        "kernel vec4 rgbChannelCompositing(__sample red, __sample green, __sample blue)" +
        "{" +
        "   return vec4(red.r, green.g, blue.b, 1.0);" +
        "}");
    
    override var attributes: [String : Any] {
        return [
            kCIAttributeFilterDisplayName: "RGB Compositing",
            
            "inputRedImage": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIImage",
                kCIAttributeDisplayName: "Red Image",
                kCIAttributeType: kCIAttributeTypeImage],
            
            "inputGreenImage": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIImage",
                kCIAttributeDisplayName: "Green Image",
                kCIAttributeType: kCIAttributeTypeImage],
            
            "inputBlueImage": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIImage",
                kCIAttributeDisplayName: "Blue Image",
                kCIAttributeType: kCIAttributeTypeImage]
        ]
    }
    
    override var outputImage: CIImage? {
        guard let inputRedImage = inputRedImage,
              let inputGreenImage = inputGreenImage,
              let inputBlueImage = inputBlueImage,
              let kernel = kernel else {
                return nil
        }
        
        let extent = inputRedImage.extent.union(inputGreenImage.extent.union(inputBlueImage.extent))
        
        let arguments = [inputRedImage, inputGreenImage, inputBlueImage]
        
        return kernel.apply(withExtent: extent, arguments: arguments)
    }
}

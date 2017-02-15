//
//  MaskedBlur.swift
//  filters
//
//  Created by Toni Jovanoski on 2/15/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import CoreImage

class MaskedBlur: CIFilter {
    var inputImage: CIImage?
    var inputBlurImage: CIImage?
    var inputBlurRadius: CGFloat = 5
    
    override var attributes: [String : Any] {
        return [
            kCIAttributeFilterDisplayName: "Metal Pixellate",
            
            "inputImage": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIImage",
                kCIAttributeDisplayName: "Image",
                kCIAttributeType: kCIAttributeTypeImage],
            
            "inputBlurImage": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "CIImage",
                kCIAttributeDisplayName: "Image",
                kCIAttributeType: kCIAttributeTypeImage],
            
            "inputBlurRadius": [kCIAttributeIdentity: 0,
                kCIAttributeClass: "NSNumber",
                kCIAttributeDefault: 5,
                kCIAttributeDisplayName: "Blur Radius",
                kCIAttributeMin: 0,
                kCIAttributeSliderMin: 0,
                kCIAttributeSliderMax: 100,
                kCIAttributeType: kCIAttributeTypeScalar]
        ]
    }

    let maskedBlur = CIKernel(string:
    "kernel vec4 lumaVariableBlur(sampler image, sampler blurImage, float blurRadius) " +
    "{ " +
    "   vec2 d = destCoord(); " +
    "   vec3 blurPixel = sample(blurImage, samplerCoord(blurImage)).rgb; " +
    "   float blurAmount = dot(blurPixel, vec3(0.2126, 0.7152, 0.0072)); " +
    "   float n = 0.0; " +
    "   int radius = int(blurAmount * blurRadius); " +
    "   vec3 accumulator = vec3(0.0, 0.0, 0.0); " +
    "   for (int x = -radius; x <= radius; x++) " +
    "   { " +
    "       for (int y = -radius; y <= radius; y++) " +
    "       { " +
    "           vec2 workingSpaceCoord = d + vec2(x, y); " +
    "           vec2 imageSpaceCoord = samplerTransform(image, workingSpaceCoord); " +
    "           vec3 color = sample(image, imageSpaceCoord).rgb; " +
    "           accumulator += color; " +
    "           n += 1.0; " +
    "       } " +
    "   } " +
    "   accumulator /= n; " +
    "   return vec4(accumulator, 1.0); " +
    "} ")
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage,
            let inputBlurImage = inputBlurImage else {
                return nil
        }
        
        let extent = inputImage.extent
        
        let scaledBlurImage = inputBlurImage.applying(CGAffineTransform(scaleX: inputImage.extent.width / inputBlurImage.extent.width, y: inputImage.extent.height / inputBlurImage.extent.height))
        
        let blur = maskedBlur?.apply(withExtent: inputImage.extent,
                                     roiCallback: {
                                        (index, rect) in
                                        
                                        if index == 0 {
                                            return rect.insetBy(dx: -self.inputBlurRadius, dy: -self.inputBlurRadius)
                                        } else {
                                            return scaledBlurImage.extent
                                        }
        },
                                     arguments: [inputImage, scaledBlurImage, inputBlurRadius])
        
        return blur?.cropping(to: extent)
    }
}

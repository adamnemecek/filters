//
//  ThresholdFilter.swift
//  filters
//
//  Created by Toni Jovanoski on 2/2/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation
import CoreImage

class ThresholdFilter: CIFilter {
    var inputImage: CIImage?
    var inputThreshold: CGFloat = 0.75
    var thresholdKernel: CIColorKernel?
    
    override var attributes: [String : Any] {
        return [
            kCIAttributeFilterName: "Threshold Filter",
            "inputImage": [kCIAttributeIdentity: 0,
                           kCIAttributeClass: "CIImage",
                           kCIAttributeDisplayName: "Image",
                           kCIAttributeType: kCIAttributeTypeImage],
            "inputThreshold": [kCIAttributeIdentity: 0,
                               kCIAttributeClass: "NSNumber",
                               kCIAttributeDefault: 0.75,
                               kCIAttributeDisplayName: "Threshold",
                               kCIAttributeMin: 0,
                               kCIAttributeSliderMin: 0,
                               kCIAttributeSliderMax: 1,
                               kCIAttributeType: kCIAttributeTypeScalar]
        ]
    }
    
    override func setDefaults() {
        inputThreshold = 0.5
    }
    
    override init() {
        super.init()
        
        thresholdKernel = CIColorKernel(string:
        "kernel vec4 thresholdFilter(__sample image, float threshold)" +
        "{ " +
        "   float luma = dot(image.rgb, vec3(0.2126, 0.7152, 0.0722)); " +
        "   return vec4(step(threshold, luma)); " +
        "}")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("dont listed i dont have nscode")
    }
    
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else {
                return nil
        }
        
        let extent = inputImage.extent
        let arguments = [inputImage, inputThreshold] as [Any]
        
        return thresholdKernel!.apply(withExtent: extent, arguments: arguments)
    }
}

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

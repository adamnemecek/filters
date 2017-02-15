//
//  ViewController.swift
//  filters
//
//  Created by Toni Jovanoski on 1/31/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CameraCaptureHelperDelegate {

    let imageView = MetalImageView()
    
    let cameraCaptureHelper = CameraCaptureHelper(cameraPosition: .front)
    //let starBurstFilter = StarBustFilter()
    //let rgbCompositing = RGBChannelCompositing()
    //let rgb
    //let rgbChannelGaussianBlur = RGBChannelGaussianBlur()
    //let chromaAber = ChromaticAbberation()
    //let carnivalMirror = CarnivalMirror()
    //let maskedBlur = MaskedBlur()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        cameraCaptureHelper.delegate = self
        
        CustomFiltersVendor.registerFilters()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
        imageView.frame = view.bounds.insetBy(dx: 5, dy: 5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func newCameraImage(_ cameraCaptureHelper: CameraCaptureHelper, image: CIImage) {
        //starBurstFilter.setValue(image, forKey: kCIInputImageKey)
        
        let gradientImage = CIFilter(
            name: "CIRadialGradient",
            withInputParameters: [kCIInputCenterKey: CIVector(x: 310, y: 390),
                                  "inputRadius0": 100,
                                  "inputRadius1": 300,
                                  "inputColor0": CIColor(red: 0, green: 0, blue: 0),
                                  "inputColor1": CIColor(red: 1, green: 1, blue: 1)]
            )?.outputImage?.cropping(to: image.extent)
        
        
        
        imageView.image = image.applyingFilter("MaskedBlur", withInputParameters: ["inputBlurRadius": 10, "inputBlurImage": gradientImage!])
    }
}


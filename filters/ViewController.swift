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
    let rgbCompositing = RGBChannelCompositing()
    
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
        
        let redImage = image.applyingFilter("CIColorControls", withInputParameters: [kCIInputContrastKey: 2.8])
        let greenImage = image.applyingFilter("CIColorControls", withInputParameters: [kCIInputContrastKey: 2.25, kCIInputBrightnessKey: 0.25])
        let blueImage = image.applyingFilter("CIColorControls", withInputParameters: [kCIInputBrightnessKey: -0.25])
        
        rgbCompositing.inputRedImage = redImage
        rgbCompositing.inputGreenImage = greenImage
        rgbCompositing.inputBlueImage = blueImage
        
        imageView.image = rgbCompositing.outputImage
    }
}


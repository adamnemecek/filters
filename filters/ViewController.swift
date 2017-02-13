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
    let carnivalMirror = CarnivalMirror()
    
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
        
        carnivalMirror.inputImage = image
        
        imageView.image = carnivalMirror.outputImage
    }
}


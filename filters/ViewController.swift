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
    
    let cameraCaptureHelper = CameraCaptureHelper(cameraPosition: .back)
    
    let crystalize = CIFilter(name: "CICrystallize", withInputParameters: [kCIInputRadiusKey: 30])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        cameraCaptureHelper.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
        imageView.frame = view.bounds.insetBy(dx: 50, dy: 50)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func newCameraImage(_ cameraCaptureHelper: CameraCaptureHelper, image: CIImage) {
        crystalize.setValue(image, forKey: kCIInputImageKey)
        
        imageView.image = crystalize.outputImage
    }
}


//
//  RegisterFilters.swift
//  filters
//
//  Created by Toni Jovanoski on 2/3/17.
//  Copyright © 2017 Antonie Jovanoski. All rights reserved.
//

import Foundation

import CoreImage

let CategoryCustomFilters = "Custom Filters"

class CustomFiltersVendor: NSObject, CIFilterConstructor
{
    static func registerFilters()
    {
        CIFilter.registerName(
            "ThresholdFilter",
            constructor: CustomFiltersVendor(),
            classAttributes: [
                kCIAttributeFilterCategories: [CategoryCustomFilters]
            ])
        
        CIFilter.registerName("StarBurstFilter", constructor: CustomFiltersVendor(), classAttributes: [kCIAttributeFilterCategories: [CategoryCustomFilters]])
        
        CIFilter.registerName("RGBChannelCompositing", constructor: CustomFiltersVendor(), classAttributes: [kCIAttributeFilterCategories: [CategoryCustomFilters]])
    }
    
    func filter(withName: String) -> CIFilter?
    {
        switch withName
        {
        case "ThresholdFilter":
            return ThresholdFilter()
            
        case "StarBurstFilter":
            return StarBustFilter()
            
        case "RGBChannelCompositing":
            return RGBChannelCompositing();
            
        default:
            return nil
        }
    }
}

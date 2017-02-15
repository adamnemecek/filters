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
        
        CIFilter.registerName("RGBChannelBrightnessAndContrast", constructor: CustomFiltersVendor(), classAttributes: [kCIAttributeFilterCategories: [CategoryCustomFilters]])
        
        CIFilter.registerName("RGBChannelGaussianBlur", constructor: CustomFiltersVendor(), classAttributes: [kCIAttributeFilterCategories: [CategoryCustomFilters]])
        
        CIFilter.registerName("ChromaticAbberation", constructor: CustomFiltersVendor(), classAttributes: [kCIAttributeFilterCategories: [CategoryCustomFilters]])
        
        CIFilter.registerName("CarnivalMirror", constructor: CustomFiltersVendor(), classAttributes: [kCIAttributeFilterCategories: [CategoryCustomFilters]])
        
        CIFilter.registerName("MaskedBlur", constructor: CustomFiltersVendor(), classAttributes: [kCIAttributeFilterCategories: [CategoryCustomFilters]])

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
            
        case "RGBChannelBrightnessAndContrast":
            return RGBChannelBrightnessAndContrast()
            
        case "RGBChannelGaussianBlur":
            return RGBChannelGaussianBlur()
        
        case "ChromaticAbberation":
            return ChromaticAbberation()
            
        case "CarnivalMirror":
            return CarnivalMirror()
        
        case "MaskedBlur":
            return MaskedBlur()
            
        default:
            return nil
        }
    }
}

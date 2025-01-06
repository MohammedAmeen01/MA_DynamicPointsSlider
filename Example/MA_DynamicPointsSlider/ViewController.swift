//
//  ViewController.swift
//  MA_DynamicPointsSlider
//
//  Created by Ameen N on 01/06/2025.
//  Copyright (c) 2025 Ameen N. All rights reserved.
//

import MA_DynamicPointsSlider
import SwiftUI

struct ViewController: View {
    @State private var sliderValue: Double = 3
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading) {
                Text("testing slider")
                Spacer().frame(height: 16)
                let minSliderValue = 1.0
                let maxSliderValue = 7.2
                CustomSliderWithText(currentValue: $sliderValue,minSliderValue: minSliderValue,maxSliderValue: maxSliderValue,unit: "KW",step: 0.1)
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
    
}

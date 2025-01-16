//
//  ViewController.swift
//  MA_DynamicPointsSlider
//
//  Created by Ameen N on 01/06/2025.
//  Copyright (c) 2025 Ameen N. All rights reserved.
//

import MA_DynamicPointsSlider
import UIKit
import SwiftUI


class ViewController : UIViewController {
    
    @IBOutlet weak var sliderParentView:UIView!
    
    @State var sliderValue: Double = 80
    
    override func viewDidLoad() {
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let hostedView = UIHostingController(rootView: CustomSliderWithText(currentValue: sliderValue, minSliderValue: 10.0, maxSliderValue: 100.0, unit: "KG", step: 1.0))
        addChildViewController(hostedView)
        sliderParentView.addSubview(hostedView.view)
        // Notify the UIHostingController that it has been added as a child
        hostedView.didMove(toParent: self)
        hostedView.view.frame = sliderParentView.bounds

    }
    
    
}



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
import Combine


class ViewController : UIViewController {
    
    @IBOutlet weak var sliderParentView:UIView!
    
    private var subs: [AnyCancellable] = []
    private var notifier: PassedCurrentValue = PassedCurrentValue()

    
    override func viewDidLoad() {
       
        notifier.$currentVal.sink { updatedValue in
            //slider current value is printed below
            print(updatedValue)
        }.store(in: &subs)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let hostedView = UIHostingController(rootView: CustomSliderWithText(currentValue: notifier, initialSliderValue: 80, minSliderValue: 10, maxSliderValue: 100, unit: "KG", step: 1).environmentObject(notifier))
        addChildViewController(hostedView)
        sliderParentView.addSubview(hostedView.view)
        // Notify the UIHostingController that it has been added as a child
        hostedView.didMove(toParent: self)
        hostedView.view.frame = sliderParentView.bounds

    }
    
    
}



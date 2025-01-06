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
    
    override func viewDidLoad() {
        _ = SwiftUIViewController(coder: <#NSCoder#>)
    }
    
    
}

class SwiftUIViewController: UIHostingController<CustomSliderWithText> {
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: CustomSliderWithText())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

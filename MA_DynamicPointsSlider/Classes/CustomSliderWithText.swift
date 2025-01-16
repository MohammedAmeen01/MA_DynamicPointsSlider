//
//  CustomSliderWithText.swift
//  MA_DynamicPointsSlider
//
//  Created by N Mohammed Ameen on 12/09/24.
//

import SwiftUI

class PassedCurrentValue: ObservableObject {
    @Published var currentVal = 0.0
}


public struct CustomSliderWithText: View {
    
    @ObservedObject var currentValue : PassedCurrentValue
    public var minSliderValue:Double
    public var maxSliderValue:Double
    public var unit:String
    public var step: Double
    public var slidingValueBGImage = "chat_Icon"
    public var thumbIcon = "slider_thumb"
    public var fontFamily = "HelveticaNeue"
    public var fontsize = 14.0
    public var foregroundColorY:Color = .blue
    public var foregroundColorX:Color = .white

    
    @State public var sliderCurrentValTextWidth: CGFloat = 0
    
    public init(currentValue: Double, minSliderValue: Double, maxSliderValue: Double, unit: String, step: Double, slidingValueBGImage: String = "chat_Icon", thumbIcon: String = "slider_thumb", fontFamily: String = "HelveticaNeue", fontsize: Double = 14.0, foregroundColorY: Color = .blue, sliderCurrentValTextWidth: CGFloat = 0) {
        self.currentValue = PassedCurrentValue()
        self.minSliderValue = minSliderValue
        self.maxSliderValue = maxSliderValue
        self.unit = unit
        self.step = step
        self.slidingValueBGImage = slidingValueBGImage
        self.thumbIcon = thumbIcon
        self.fontFamily = fontFamily
        self.fontsize = fontsize
        self.foregroundColorY = foregroundColorY
        self.sliderCurrentValTextWidth = sliderCurrentValTextWidth
        self.currentValue.currentVal = currentValue
    }
    
    
    public var body: some View {
        let percentage = ((currentValue.currentVal-minSliderValue)/(maxSliderValue-minSliderValue))*100
        GeometryReader { geometry in
            VStack(spacing: 0) {
                let widthOfStack = (geometry.size.width)
                
                VStack {
                    let floatingValue = String(format: "%0.1f", currentValue.currentVal)
                    Text("\(floatingValue) \(unit)")
                        .font(Font.custom(fontFamily, size: fontsize).weight(.regular))
                        .foregroundColor(foregroundColorX)
//                        .frame(width: 44, height: 27)
                        .padding(.init(top: 2, leading: 4, bottom: 4, trailing: 4))
                        .modifier(GetWidthModifier(width: $sliderCurrentValTextWidth))
                        .background(
                            Image(slidingValueBGImage)
                                .resizable()
                        )
                }
                .offset(x: getoffset(widthOfStack,percentage,sliderCurrentValTextWidth))
                .frame(maxWidth : .infinity, alignment: .leading)
                Slider(
                    value: $currentValue.currentVal,
                    in: minSliderValue...maxSliderValue, step: step
                )
                HStack {
                    let minValue = String(format: "%0.1f", minSliderValue)
                    Text("\(minValue) \(unit)")
                        .font(Font.custom(fontFamily, size: fontsize).weight(.regular))
                        .foregroundColor(foregroundColorY)
                    Spacer()
                    let maxValue = String(format: "%0.1f", maxSliderValue)
                    Text("\(maxValue) \(unit)")
                        .font(Font.custom(fontFamily, size: fontsize).weight(.regular))
                        .foregroundColor(foregroundColorY)
                }
            }.onAppear(perform: {
                let thumbImage = UIImage(named: thumbIcon)
                UISlider.appearance().setThumbImage(thumbImage, for: .normal)
            })
        }
    }
    
    public func getoffset(_ widthOfStack: Double, _ percentage: Double,_ sliderCurrentValTextWidth: Double) -> Double {
        
        let offsetValue = CGFloat(((widthOfStack/100)*percentage) - (sliderCurrentValTextWidth/2.0))
        if offsetValue.sign == .minus {
            return 0.0
        } else if offsetValue > (widthOfStack - (sliderCurrentValTextWidth)) {
            return (widthOfStack - (sliderCurrentValTextWidth))
        } else {
           return offsetValue
        }
    }
    
}

public struct GetWidthModifier: ViewModifier {
    @Binding public var width: CGFloat

    public func body(content: Content) -> some View {
        content.background(
            GeometryReader { geo -> Color in
                DispatchQueue.main.async {
                    width = geo.size.width
                }
                return Color.clear
            }
        )
    }
}


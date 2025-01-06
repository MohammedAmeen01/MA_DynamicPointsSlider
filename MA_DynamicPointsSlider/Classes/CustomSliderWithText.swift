//
//  CustomSliderWithText.swift
//  MA_DynamicPointsSlider
//
//  Created by N Mohammed Ameen on 12/09/24.
//

import SwiftUI

struct CustomSliderWithText: View {
    
    @Binding var currentValue:Double
    var minSliderValue:Double
    var maxSliderValue:Double
    var unit:String
    var step: Double
    var slidingValueBGImage = "chat_Icon"
    var thumbIcon = "slider_thumb"
    var fontFamily = "HelveticaNeue"
    var fontsize = 14.0
    var foregroundColor:Color = .blue
    
    @State private var sliderCurrentValTextWidth: CGFloat = 0
    
    var body: some View {
        let percentage = ((currentValue-minSliderValue)/(maxSliderValue-minSliderValue))*100
        GeometryReader { geometry in
            VStack(spacing: 0) {
                let widthOfStack = (geometry.size.width)
                
                VStack {
                    Text("\((currentValue, specifier: (currentValue.truncatingRemainder(dividingBy: 1) == 0) ? "%.0f" : "%.1f")) \(unit)")
                        .font(Font.custom(fontFamily, size: fontsize).weight(.regular))
                        .foregroundColor(foregroundColor)
                        .frame(width: 44, height: 27)
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
                    value: $currentValue,
                    in: minSliderValue...maxSliderValue, step: step
                )
                HStack {
                    Text("\((minSliderValue, specifier: (minSliderValue.truncatingRemainder(dividingBy: 1) == 0) ? "%.0f" : "%.1f")) \(unit)")
                        .font(Font.custom(fontFamily, size: fontsize).weight(.regular))
                        .foregroundColor(foregroundColor)
                    Spacer()
                    Text("\((maxSliderValue, specifier: (maxSliderValue.truncatingRemainder(dividingBy: 1) == 0) ? "%.0f" : "%.1f")) \(unit)")
                        .font(Font.custom(fontFamily, size: fontsize).weight(.regular))
                        .foregroundColor(foregroundColor)
                }
            }.onAppear(perform: {
                let thumbImage = UIImage(named: thumbIcon)
                UISlider.appearance().setThumbImage(thumbImage, for: .normal)
            })
        }
    }
    
    func getoffset(_ widthOfStack: Double, _ percentage: Double,_ sliderCurrentValTextWidth: Double) -> Double {
        
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

struct GetWidthModifier: ViewModifier {
    @Binding var width: CGFloat

    func body(content: Content) -> some View {
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

extension View {
    func Print(_ item: Any) -> some View {
        #if DEBUG
        print(item)
        #endif
        return self
    }
}


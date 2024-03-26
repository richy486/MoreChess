//
//  ButtonStyles.swift
//  MoreChess (iOS)
//
//  Created by Richard Adem on 3/24/24.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  
  func makeBody(configuration: Configuration) -> some View {
    
    var backgroundColor: Color {
      if isEnabled == false {
        // Disabled
        Color.disabled
      } else if configuration.isPressed {
        // Highlighted, just the background changes.
        Color.accentColor.opacity(StyleConstants.highlightedOpacity)
      } else {
        // Normal
        Color.accentColor
      }
    }
    
    configuration.label
      .padding(12)
      .font(StyleFont.button)
      .strikethrough(isEnabled == false, color: Color.disabled)
      .foregroundStyle(Color.background)
      .background{
        RoundedRectangle(cornerRadius: StyleConstants.cornerRadius)
          .fill(backgroundColor)
          .animation(.easeOut(duration: StyleConstants.animationTime),
                     value: configuration.isPressed)
      }
  }
}

struct SecondaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled

  func makeBody(configuration: Configuration) -> some View {
    
    var backgroundColor: Color {
      if isEnabled == false {
        // Disabled
        Color.disabled
      } else if configuration.isPressed {
        // Highlighted
        Color.accentColor
      } else {
        // Normal
        Color.accentColor
      }
    }
    
    configuration.label
      .padding(10)
      .font(StyleFont.button)
      .strikethrough(isEnabled == false, color: Color.disabled)
      .foregroundStyle(Color.accentColor)
      .background{
        RoundedRectangle(cornerRadius: StyleConstants.cornerRadius)
          .stroke(backgroundColor, lineWidth: StyleConstants.lineWidth)
          .animation(.easeOut(duration: StyleConstants.animationTime), 
                     value: configuration.isPressed)
      }
      // Change whole button on pressed.
      .opacity(configuration.isPressed ? StyleConstants.highlightedOpacity : 1.0)
  }
}

struct SolidButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .background(Color.accentColor)
      .foregroundStyle(Color.background)
      .font(.headline)
      .clipShape(Capsule())
      .scaleEffect(configuration.isPressed ? 1.2 : 1)
      .animation(.easeOut(duration: StyleConstants.animationTime), value: configuration.isPressed)
  }
}

struct FunkyButtonStyle: ButtonStyle {
  
  @Environment(\.colorScheme) var colorScheme
  
  fileprivate struct CurvedLine: Shape {
    func path(in rect: CGRect) -> Path {
      Path { path in
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                          control: CGPoint(x: rect.width * 1.0, y: rect.height * -0.4))
        
      }
    }
  }
  
  func makeBody(configuration: Configuration) -> some View {
    let foregroundColor = colorScheme == .dark ? Color.foreground : Color.background
    
    configuration.label
      .padding()
      .background(LinearGradient(gradient: Gradient(colors: [.accentColor, .black]), 
                                 startPoint: .top,
                                 endPoint: .bottom))
      .overlay{
        VStack {
          CurvedLine()
            .stroke(.white, style: StrokeStyle(lineWidth: 4, lineCap: .round))
            .frame(height: 10)
            .padding(.vertical, 6)
            .padding(.leading, 19)
            .padding(.trailing, 14)
          Spacer()
        }
      }
      .foregroundStyle(foregroundColor)
      .font(.headline)
      .clipShape(Capsule())
      .scaleEffect(configuration.isPressed ? 1.2 : 1)
      .rotationEffect(.degrees(configuration.isPressed ? 30 : 0))
      .animation(.easeOut(duration: StyleConstants.animationTime), value: configuration.isPressed)
  }
}

#Preview {
  VStack {
    
    Button("Button") { }.buttonStyle(PrimaryButtonStyle())
    Button("Disabled") { }.buttonStyle(PrimaryButtonStyle())
      .disabled(true)
    
    Button("Button") { }.buttonStyle(SecondaryButtonStyle())
    Button("Disabled") { }.buttonStyle(SecondaryButtonStyle())
      .disabled(true)
      
    
    Button("Press Me") { }
      .buttonStyle(SolidButtonStyle())
    
    Button("Press Me") { }
      .buttonStyle(FunkyButtonStyle())
    
    Button("Very long text for a button") { }
      .buttonStyle(FunkyButtonStyle())
  }
  .style()
}

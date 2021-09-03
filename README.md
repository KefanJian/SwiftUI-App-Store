# SwiftUI-App-Store  
<a href="url"><img src="https://github.com/KefanJian/SwiftUI-App-Story/blob/main/preview.gif" height="896" width="414" ></a> 
## Goal
Mock app store
## Condition
* support iOS 13
* purer SwiftUI better
## Problems and Solutions
* No blur view in SwiftUI (iOS 13).    
  > Use UIKit and APPKit.  
  > (SwiftUI has `VisualEffectBlur()` on iOS 14)
* No way to hide original tab bar. (We need to customize one)
  > Use UIKit.
* AnimatableModifier bug inside containers.
  > Use a clear color to wrape the view.  
  >`Color.clear.overlay(the view)`  
  >[reference](https://swiftui-lab.com/animatablemodifier-inside-containers-bug/ "Title").
* Can not get real size size for autosizing child view.
  > User `GeometryReader` and `PreferenceChange` to redraw.  
  >[reference](https://stackoverflow.com/questions/56573373/swiftui-get-size-of-child/ "Title").
* No way to get scroll view's offset (iOS 13).
  > I add a flat view(0 height) with `GeometryReader` and `PreferenceChange` to monitor it's position.  
  > (There is `ScrollViewReader` on iOS 14). 
* There is no way to know animation is completed.
  > Use GCD to change a flag with same duration as the animation at begining.  
  > `DispatchQueue.main.asyncAfter(deadline: .now() + duration`
## Problem not solved

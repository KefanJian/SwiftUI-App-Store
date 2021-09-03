# SwiftUI-App-Store  
<a href="url"><img src="https://github.com/KefanJian/SwiftUI-App-Story/blob/main/preview.gif" height="810" width="414" ></a> 
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
* Can not get real size for self-sizing child view.
  > User `GeometryReader` and `PreferenceChange` to redraw.  
  >[reference](https://stackoverflow.com/questions/56573373/swiftui-get-size-of-child/ "Title").
* No way to get scroll view's offset (iOS 13).
  > I add a flat view(0 height) with `GeometryReader` and `PreferenceChange` to monitor it's position.  
  > (There is `ScrollViewReader` on iOS 14). 
* There is no way to know animation is completed.
  > Use GCD to change a flag with same duration as the animation at begining.  
  > `DispatchQueue.main.asyncAfter(deadline: .now() + duration)`
## Problem not solved
* Status bar bug
  > SwiftUI's modifier `statusBar(hidden: true)` does work if view is wrapped in NavigationView.  
  > Have tried many solutions from stackoverflow, but they don't work.  
  > Expect this [workaround with UIKit](https://developer.apple.com/forums/thread/653153?answerId=683918022#683918022/ "Title") can work.  
  > But I'm tired of wrapping UIKit, so i didn't try.
* The expected offset cannot be set when the scroll view end scrolling.
  > `ScrollView` in SwiftUI has no function to set offset likes `targetContentOffset` do in UIScrollview's delegate.  
  > The only way to slove it, I think is wrapping `UIScrollView`.  
  > But I'm tired of wrapping UIKit again!
* Can not access the gesture of `Scrollview` in SwiftUI. It's no way to handle conflicts of gestures.  
  > Wrapping `UIScrollView` and  setting `UIGestureRecognizer`'s delegate will be easier.  
  > But I'm tired of wrapping UIKit anymore!

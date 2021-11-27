# SplitViewController
SplitViewController implementation with triple column and double column

## SplitViewController initializer.
The code uses different `UISplitViewController` initializer for iOS 14(or later) vs iOS version prior to it.

Initialzer for iOS 14 or later, we specifiy triple column, to include one primary controller, a supplementary controller and an secondary controller.

```swift
UISplitViewController(style: .tripleColumn)
```
The style it uses is `.twoBesideSecondary` which helps to show two controllers next to the secondary controller. Those two controllers with sidebar are primary viewcontroller and supplementary controller.

For iOS versions prior to iOS 14 we can't use the above initalizer and can have only two controllers.





## iOS 14 with Supplementary view(Folder as year)

https://user-images.githubusercontent.com/1470780/139196074-0e5ee57f-2bc9-4488-b1d2-a76bb59e905d.mov


## Prior iOS 14 without Supplementary view, there are only two columns.


https://user-images.githubusercontent.com/1470780/143667136-ee73c99e-43b7-4388-bf6b-f7ee4e39386c.mov



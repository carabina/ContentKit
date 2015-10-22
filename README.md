# ContentKit

### CocoaPods Support

ContentKit is on CocoaPods under the name [CK](https://cocoapods.org/?q=CK).

### Resize UIImage

Images come in all shapes and sizes. UIImage resize is a flexible way to resize images on the fly. The below example shows you how.

![MKPreview](http://www.materialkit.io/github/contentkit/vid1.gif)

```swift
let p1: UIImage? = UIImage(named: "img1")
let p2: UIImage? = p1?.resize(toWidth: 300)
let p3: UIImage? = p1?.resize(toHeight: 200)
let p4: UIImage? = p1?.resize(toWidth: 100)

// Display with MaterialKit.
let v1: MaterialView = MaterialView(frame: CGRectMake(57.7, 50, p2!.width, p2!.height))
v1.image = p2

// Add to UIViewController.
view.addSubview(v1)

let v2: MaterialView = MaterialView(frame: CGRectMake(114, p2!.height + 100, p3!.width, p3!.height))
v2.image = p3

view.addSubview(v2)

let v3: MaterialView = MaterialView(frame: CGRectMake(171.5, p2!.height + p3!.height + 125, p4!.width, p4!.height))
v3.image = p4

view.addSubview(v3)
```

### Crop UIImage

Crop images easily with UIImage crop. Below is an example:

```swift
let p1: UIImage? = UIImage(named: "img1")
let p2: UIImage? = p1?.crop(toWidth: 400, toHeight: 200)
```

### Save To Photo Library

Keep the moment by saving your images to Photo Library. Below is an example of cropping an image and saving it to the devices PhotoLibrary.

```swift
let p: UIImage? = UIImage(named: "img1")
p?.crop(toWidth: 300, toHeight: 75)?.writeToPhotoLibrary()
```

### Lines of Text

Cycle through lines of text in any String. Below is an example of iterating through all lines of text in a String.

```swift
let text: String = "This is a\nblock of text\nthat has\nnewlines."
for line in text.lines {
	print(line)
}
// output:
// This is a
// block of text
// that has
// newlines.
```

### Trim Whitespace

Remove the spaces and newlines from the beginning and end of a text block. Below is an example.

```swift
let text: String = "     \n  Hello World    \n     "
print(text.trim()) // output: Hello World
```

### License

[AGPLv3](http://choosealicense.com/licenses/agpl-3.0/)

### Contributors

* [Daniel Dahan](https://github.com/danieldahan)
* [Adam Dahan](https://github.com/adamdahan)
* [Michael Reyder](https://github.com/michaelReyder)

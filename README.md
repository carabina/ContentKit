# ContentKit

### CocoaPods Support

ContentKit is on CocoaPods under the name [CK](https://cocoapods.org/?q=CK).

### Resize Image

Images come in all shapes and sizes. UIImage resize is a flexible way to resize images on the fly. The below example shows you how.

```swift
let p1: UIImage? = UIImage(named: "img1")
let p2: UIImage? = p1?.resize(toWidth: 300)
let p3: UIImage? = p1?.resize(toHeight: 200)
```

### Crop Image

Crop images easily with UIImage crop. Below is an example:

```swift
let p1: UIImage? = UIImage(named: "img1")
let p2: UIImage? = p1?.crop(toWidth: 400, toHeight: 200)
```

### Save To Photo Library

Keep the moment by saving your images to Photo Library. Below is an example of cropping an image and saving it to the devices PhotoLibrary.

```swift
let p: UIImage? = UIImage(named: "img1")
p?.crop(toWidth: 400, toHeight: 200)?.writeToPhotoLibrary()
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

### File System

Get helpful directories.

```swift
print(File.applicationDirectoryPath) // output: ../Applications/
print(File.documentDirectoryPath) // output: ../Documents/
print(File.libraryDirectoryPath) // output: ../Library/
print(File.cachesDirectoryPath) // output: ../Library/Caches/
print(File.tmpDirectoryPath)  // output: ../tmp/
```

### Create Directory

Easily create directories in different search paths.

```swift
let result: Bool = File.createDirectory("TestDirectory", inDirectory: .DocumentDirectory)
print(result) // output: true
```

### Remove Directory

As simple as it is to create a directory, it is to remove it.

```swift
let result: Bool = File.removeDirectory("TestDirectory", inDirectory: .DocumentDirectory)
print(result) // output: true
```

### License

[AGPL-3.0](http://choosealicense.com/licenses/agpl-3.0/)

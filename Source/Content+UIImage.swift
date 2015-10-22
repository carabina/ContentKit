//
// Copyright (C) 2015 GraphKit, Inc. <http://graphkit.io> and other GraphKit contributors.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program located at the root of the software package
// in a file called LICENSE.  If not, see <http://www.gnu.org/licenses/>.
//

import UIKit
import AssetsLibrary

public enum ContentImageFormatType {
	case PNG
	case JPEG
}

@objc(ContentImageDelegate)
public protocol ContentImageDelegate {
	
}

public extension UIImage {
	/**
		:name:	width
	*/
	public var width: CGFloat {
		return size.width
	}
	
	/**
		:name:	height
	*/
	public var height: CGFloat {
		return size.height
	}
	
	/**
		:name:	resize
	*/
	public func resize(var toWidth w: CGFloat = 0, var toHeight h: CGFloat = 0) -> UIImage? {
		if 0 < w {
			h = height * w / width
		} else if 0 < h {
			w = width * h / height
		}
		
		let g: UIImage?
		let t: CGRect = CGRectMake(0, 0, w, h)
		UIGraphicsBeginImageContext(t.size)
		drawInRect(t, blendMode: .Normal, alpha: 1)
		g = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return g
	}
	
	/**
		:name:	crop
	*/
	public func crop(var toWidth w: CGFloat, var toHeight h: CGFloat) -> UIImage? {
		let g: UIImage?
		let b: Bool = width > height
		let s: CGFloat = b ? h / height : w / width
		let t: CGSize = CGSizeMake(w, h)
		
		w = width * s
		h = height * s
		
		UIGraphicsBeginImageContext(t)
		drawInRect(b ? CGRectMake(-1 * (w - t.width) / 2, 0, w, h) : CGRectMake(0, -1 * (h - t.height) / 2, w, h), blendMode: .Normal, alpha: 1)
		g = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return g!
	}
	
	/**
		:name:	saveToFile
	*/
	public func saveToFile(path: String, format: ContentImageFormatType, quality: CGFloat = 1) -> Bool {
		do {
			let documentsDirectory: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
			try NSFileManager.defaultManager().createDirectoryAtPath(documentsDirectory, withIntermediateDirectories: true, attributes: nil)
			let url: NSURL = NSURL.fileURLWithPath(documentsDirectory + "/" + path, isDirectory: false)
			
			if let v = url.path {
				try toNSData(format, quality: quality)?.writeToFile(v, options: .DataWritingAtomic)
				return true
			}
		} catch {}
		return false
	}
	
	/**
		:name:	toNSData
	*/
	public func toNSData(format: ContentImageFormatType, quality: CGFloat = 1) -> NSData? {
		switch format {
		case .JPEG:
			return UIImageJPEGRepresentation(self, quality)
		case .PNG:
			return UIImagePNGRepresentation(self)
		}
	}
	
	/**
		:name:	writeToPhotoLibrary
	*/
	public func writeToPhotoLibrary(completion: ((path: NSURL!, error: NSError?) -> Void)? = nil) {
		UIImageWriteToSavedPhotosAlbum(self, self, nil, nil)
	}
	
	/**
		:name:	writeToAssetsLibrary
	*/
	public func writeToAssetsLibrary(completion: ((path: NSURL!, error: NSError?) -> Void)? = nil) {
		let library: ALAssetsLibrary = ALAssetsLibrary()
		library.writeImageToSavedPhotosAlbum(CGImage, orientation: ALAssetOrientation(rawValue: imageOrientation.rawValue)!, completionBlock: completion)
	}
}
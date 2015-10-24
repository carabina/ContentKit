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

import Foundation

public struct File {
    /**
		:name:	path to documents directory
    */
	public static let documentsDirectoryPath: NSURL? = File.pathForDirectory(.DocumentDirectory, domainMask: .UserDomainMask)
    
    /**
		:name:	path to application directory
    */
	public static let applicationDirectoryPath: NSURL? = File.pathForDirectory(.ApplicationDirectory, domainMask: .UserDomainMask)
    
    /**
		:name:	path to library directory
    */
	public static let libraryDirectoryPath: NSURL? = File.pathForDirectory(.LibraryDirectory, domainMask: .UserDomainMask)
    
    /**
		:name:	path to caches directory
    */
	public static let cachesDirectoryPath: NSURL? = File.pathForDirectory(.CachesDirectory, domainMask: .UserDomainMask)
    
    /**
		:name:	path to temp directory
    */
	public static let tmpDirectoryPath: NSURL? = NSURL(string: NSTemporaryDirectory())
    
    /**
		:name:	create directory with name in directory
    */
    public static func createDirectory(name: String, inDirectory directory: NSSearchPathDirectory) -> Bool {
        if let fullPath = path(name, inDirectory: directory)?.URLByAppendingPathComponent(name) {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(fullPath.path!, withIntermediateDirectories: true, attributes: nil)
                return true
            } catch let error as NSError {
                NSLog("Unable to create directory \(error.debugDescription)")
            }
        }
        return false
    }
    
    /**
		:name:	remove directory with name in directory
    */
    public static func removeDirectory(name: String, inDirectory directory: NSSearchPathDirectory) -> Bool {
        if let fullPath = path(name, inDirectory: directory)?.URLByAppendingPathComponent(name) {
            do {
                try NSFileManager().removeItemAtURL(fullPath)
                return true
            } catch let error as NSError {
                NSLog("Unable to remove directory \(error.debugDescription)")
            }
        }
        return false
    }
    
    /**
		:name:	path for directory name
    */
    public static func path(name: String, inDirectory directory: NSSearchPathDirectory) -> NSURL? {
        switch(directory) {
        case .DocumentDirectory:
            return File.documentsDirectoryPath
        case .ApplicationDirectory:
            return File.applicationDirectoryPath
        case .LibraryDirectory:
            return File.libraryDirectoryPath
        case .CachesDirectory:
            return File.cachesDirectoryPath
        default:
            return nil
        }
    }
    
    /**
		:name:	helper for getting paths to directories.
    */
    public static func pathForDirectory(searchPath: NSSearchPathDirectory, domainMask: NSSearchPathDomainMask) -> NSURL? {
        return try? NSFileManager().URLForDirectory(searchPath, inDomain: domainMask, appropriateForURL: nil, create: true)
    }
}
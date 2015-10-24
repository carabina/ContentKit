//
//  File.swift
//  ContentKit
//
//  Created by Adam Dahan on 2015-10-23.
//  Copyright © 2015 GraphKit Inc. All rights reserved.
//

import Foundation

public class File {
    /**
    :name:	path to documents directory
    */
    public static func documentsDirectoryPath() -> NSURL? {
        return pathForDirectory(.DocumentDirectory, domainMask: .UserDomainMask)
    }
    
    /**
    :name:	path to application directory
    */
    public static func applicationDirectoryPath() -> NSURL? {
        return pathForDirectory(.ApplicationDirectory, domainMask: .UserDomainMask)
    }
    
    /**
    :name:	path to library directory
    */
    public static func libraryDirectoryPath() -> NSURL? {
        return pathForDirectory(.LibraryDirectory, domainMask: .UserDomainMask)
    }
    
    /**
    :name:	path to caches directory
    */
    public static func cachesDirectoryPath() -> NSURL? {
        return pathForDirectory(.CachesDirectory, domainMask: .UserDomainMask)
    }
    
    /**
    :name:	path to temp directory
    */
    public static func tmpDirectoryPath() -> NSURL? {
        return NSURL(string: NSTemporaryDirectory())
    }
    
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
            return documentsDirectoryPath()
        case .ApplicationDirectory:
            return applicationDirectoryPath()
        case .LibraryDirectory:
            return libraryDirectoryPath()
        case .CachesDirectory:
            return cachesDirectoryPath()
        default:
            return nil
        }
    }
    
    /**
    :name:	helper for getting paths to directories.
    */
    public static func pathForDirectory(searchPath: NSSearchPathDirectory, domainMask: NSSearchPathDomainMask) -> NSURL? {
        if let path = try? NSFileManager().URLForDirectory(searchPath, inDomain: domainMask, appropriateForURL: nil, create: true) {
            return path
        }
        return nil
    }
}
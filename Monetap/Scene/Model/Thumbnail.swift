//
//  Thumbnail.swift
//
//  Created by Garry Patel on 06/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Thumbnail: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let source = "source"
    static let height = "height"
    static let width = "width"
  }

  // MARK: Properties
  public var source: String?
  public var height: Int?
  public var width: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    source = json[SerializationKeys.source].string
    height = json[SerializationKeys.height].int
    width = json[SerializationKeys.width].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = source { dictionary[SerializationKeys.source] = value }
    if let value = height { dictionary[SerializationKeys.height] = value }
    if let value = width { dictionary[SerializationKeys.width] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.source = aDecoder.decodeObject(forKey: SerializationKeys.source) as? String
    self.height = aDecoder.decodeObject(forKey: SerializationKeys.height) as? Int
    self.width = aDecoder.decodeObject(forKey: SerializationKeys.width) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(source, forKey: SerializationKeys.source)
    aCoder.encode(height, forKey: SerializationKeys.height)
    aCoder.encode(width, forKey: SerializationKeys.width)
  }

}

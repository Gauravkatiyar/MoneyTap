//
//  Continue.swift
//
//  Created by Garry Patel on 06/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Continue: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let gpsoffset = "gpsoffset"
    static let continues = "continue"
  }

  // MARK: Properties
  public var gpsoffset: Int?
  public var continues: String?

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
    gpsoffset = json[SerializationKeys.gpsoffset].int
    continues = json[SerializationKeys.continues].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = gpsoffset { dictionary[SerializationKeys.gpsoffset] = value }
    if let value = continues { dictionary[SerializationKeys.continues] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.gpsoffset = aDecoder.decodeObject(forKey: SerializationKeys.gpsoffset) as? Int
    self.continues = aDecoder.decodeObject(forKey: SerializationKeys.continues) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(gpsoffset, forKey: SerializationKeys.gpsoffset)
    aCoder.encode(continues, forKey: SerializationKeys.continues)
  }

}

//
//  Query.swift
//
//  Created by Garry Patel on 06/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Query: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let pages = "pages"
  }

  // MARK: Properties
  public var pages: [Pages]?

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
    if let items = json[SerializationKeys.pages].array { pages = items.map { Pages(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = pages { dictionary[SerializationKeys.pages] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.pages = aDecoder.decodeObject(forKey: SerializationKeys.pages) as? [Pages]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(pages, forKey: SerializationKeys.pages)
  }

}

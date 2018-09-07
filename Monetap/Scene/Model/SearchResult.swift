//
//  SearchResult.swift
//
//  Created by Garry Patel on 06/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SearchResult: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let batchcomplete = "batchcomplete"
    static let continues = "continue"
    static let query = "query"
  }

  // MARK: Properties
  public var batchcomplete: Bool? = false
  public var continues: Continue?
  public var query: Query?

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
    batchcomplete = json[SerializationKeys.batchcomplete].boolValue
    continues = Continue(json: json[SerializationKeys.continues])
    query = Query(json: json[SerializationKeys.query])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.batchcomplete] = batchcomplete
    if let value = continues { dictionary[SerializationKeys.continues] = value.dictionaryRepresentation() }
    if let value = query { dictionary[SerializationKeys.query] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.batchcomplete = aDecoder.decodeBool(forKey: SerializationKeys.batchcomplete)
    self.continues = aDecoder.decodeObject(forKey: SerializationKeys.continues) as? Continue
    self.query = aDecoder.decodeObject(forKey: SerializationKeys.query) as? Query
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(batchcomplete, forKey: SerializationKeys.batchcomplete)
    aCoder.encode(continues, forKey: SerializationKeys.continues)
    aCoder.encode(query, forKey: SerializationKeys.query)
  }

}

//
//  Pages.swift
//
//  Created by Garry Patel on 06/09/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Pages: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let pageid = "pageid"
    static let title = "title"
    static let terms = "terms"
    static let ns = "ns"
    static let thumbnail = "thumbnail"
    static let index = "index"
  }

  // MARK: Properties
  public var pageid: Int?
  public var title: String?
  public var terms: Terms?
  public var ns: Int?
  public var thumbnail: Thumbnail?
  public var index: Int?

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
    pageid = json[SerializationKeys.pageid].int
    title = json[SerializationKeys.title].string
    terms = Terms(json: json[SerializationKeys.terms])
    ns = json[SerializationKeys.ns].int
    thumbnail = Thumbnail(json: json[SerializationKeys.thumbnail])
    index = json[SerializationKeys.index].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = pageid { dictionary[SerializationKeys.pageid] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = terms { dictionary[SerializationKeys.terms] = value.dictionaryRepresentation() }
    if let value = ns { dictionary[SerializationKeys.ns] = value }
    if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value.dictionaryRepresentation() }
    if let value = index { dictionary[SerializationKeys.index] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.pageid = aDecoder.decodeObject(forKey: SerializationKeys.pageid) as? Int
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.terms = aDecoder.decodeObject(forKey: SerializationKeys.terms) as? Terms
    self.ns = aDecoder.decodeObject(forKey: SerializationKeys.ns) as? Int
    self.thumbnail = aDecoder.decodeObject(forKey: SerializationKeys.thumbnail) as? Thumbnail
    self.index = aDecoder.decodeObject(forKey: SerializationKeys.index) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(pageid, forKey: SerializationKeys.pageid)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(terms, forKey: SerializationKeys.terms)
    aCoder.encode(ns, forKey: SerializationKeys.ns)
    aCoder.encode(thumbnail, forKey: SerializationKeys.thumbnail)
    aCoder.encode(index, forKey: SerializationKeys.index)
  }

}

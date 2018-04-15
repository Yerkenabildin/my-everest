//
//  EncodableFactory.swift
//  GoBiker-V2
//
//  Created by Nour Helmi on 12/02/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import Foundation

// Keeping the jsonEncoder and jsonDecoder in memory for optimizations reasons
struct EncodableFactory {
    static func makeJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }

    static func makeJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }
}

public let jsonEncoder: JSONEncoder = EncodableFactory.makeJSONEncoder()
public let jsonDecoder: JSONDecoder = EncodableFactory.makeJSONDecoder()

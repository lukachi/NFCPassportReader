//
//  DataGroup12.swift
//
//  Created by Andy Qua on 01/02/2021.
//

import Foundation

@available(iOS 13, macOS 10.15, *)
public class DataGroup12 : DataGroup {
    public public(set) var issuingAuthority : String?
    public public(set) var dateOfIssue : String?
    public public(set) var otherPersonsDetails : String?
    public public(set) var endorsementsOrObservations : String?
    public public(set) var taxOrExitRequirements : String?
    public public(set) var frontImage : [UInt8]?
    public public(set) var rearImage : [UInt8]?
    public public(set) var personalizationTime : String?
    public public(set) var personalizationDeviceSerialNr : String?

    public override var datagroupType: DataGroupId { .DG12 }

    required init( _ data : [UInt8] ) throws {
        try super.init(data)
    }

    override func parse(_ data: [UInt8]) throws {
        var tag = try getNextTag()
        try verifyTag(tag, equals: 0x5C)

        // Skip the taglist - ideally we would check this but...
        let _ = try getNextValue()
        
        repeat {
            tag = try getNextTag()
            let val = try getNextValue()
            
            if tag == 0x5F19 {
                issuingAuthority = String( bytes:val, encoding:.utf8)
            } else if tag == 0x5F26 {
                dateOfIssue = parseDateOfIssue(value: val)
            } else if tag == 0xA0 {
                // Not yet handled
            } else if tag == 0x5F1B {
                endorsementsOrObservations = String( bytes:val, encoding:.utf8)
            } else if tag == 0x5F1C {
                taxOrExitRequirements = String( bytes:val, encoding:.utf8)
            } else if tag == 0x5F1D {
                frontImage = val
            } else if tag == 0x5F1E {
                rearImage = val
            } else if tag == 0x5F55 {
                personalizationTime = String( bytes:val, encoding:.utf8)
            } else if tag == 0x5F56 {
                personalizationDeviceSerialNr = String( bytes:val, encoding:.utf8)
            }
        } while pos < data.count
    }
    
    public func parseDateOfIssue(value: [UInt8]) -> String? {
        if value.count == 4 {
            return decodeBCD(value: value)
        } else {
            return decodeASCII(value: value)
        }
    }
    
    public func decodeASCII(value: [UInt8]) -> String? {
        return String(bytes:value, encoding:.utf8)
    }
    
    public func decodeBCD(value: [UInt8]) -> String? {
        value.map({ String(format: "%02X", $0) }).joined()
    }
}

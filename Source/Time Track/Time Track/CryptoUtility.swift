//
//  CryptoUtility.swift
//  Time Track
//
//  Created by Heath Sinclair on 7/22/24.
//

import Foundation
import CryptoKit

class CryptoUtility{
    
    let key:SymmetricKey
    
    init(){
        key = SymmetricKey(data: SHA256.hash(data:"vyUZFsBDNjtO3TKGOK6nwoV9WDS0j6dq".data(using: .utf8)!.base64EncodedData()))
    }
    
    func encrypt(str: String) throws -> Data {
        guard let data = str.data(using: .utf8) else { return Data() }
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }

    func decrypt(data: Data) throws -> String {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        let string = String(decoding: decryptedData, as: UTF8.self)
        return string
    }
    
}


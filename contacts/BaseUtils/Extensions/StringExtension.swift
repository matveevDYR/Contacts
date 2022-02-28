//
//  StringExtension.swift
//  contacts
//
//  Created by Денис Матвеев on 27.02.2022.
//  Copyright © 2022 SkbkonturMobile. All rights reserved.
//

import Foundation

extension String {
    
    func replaceExtraSymbols(symbols: [String]) -> String {
        var text = self
        symbols.forEach({ symbol in
            let newText = text.replacingOccurrences(of: symbol, with: "")
            text = newText
        })
        return text
    }
    
    func formattingDate(fromMask: String, toMask: String) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = fromMask

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toMask

        guard let date = dateFormatterGet.date(from: self) else {return nil}
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func formattingByMask(replaceSymbols: [String], mask: String, maskSymbol: String.Element) -> String {
        guard self != "" else {return self}
        let clearText = self.replaceExtraSymbols(symbols: replaceSymbols)

        var formatedText = ""
        var maskArray = Array(mask)
        var indexLastChangedCharacter: Int?
        
        clearText.forEach{
            guard let index = maskArray.firstIndex(of: maskSymbol) else {return}
            maskArray[index] = $0
            indexLastChangedCharacter = index
        }
        guard let limit = indexLastChangedCharacter else {return ""}
        
        for index in 0...limit {
            formatedText.append(maskArray[index])
        }

        return formatedText
    }
    
}

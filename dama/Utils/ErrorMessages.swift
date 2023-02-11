//
//  ErrorMessages.swift
//  dama
//
//  Created by Hoonjoo Park on 2023/02/12.
//

import Foundation

enum ErrorMessages: String, Error {
    case InvalidUrl = "URL이 올바르지 않습니다. 다시 시도해 주세요"
    case InvalidResponse = "올바르지 않은 응답입니다. 다시 시도해 주세요"
    case InvalidData = "데이터가 올바르지 않습니다. 다시 시도해 주세요"
    case Unknown = "오류가 발생했습니다. 다시 시도해 주세요"
}

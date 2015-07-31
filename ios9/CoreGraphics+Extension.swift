//
//  CoreGraphics+Extension.swift
//  ios9
//
//  Created by Ono Masashi on 2015/06/15.
//  Copyright © 2015年 akisute. All rights reserved.
//

import UIKit

extension CGPoint: CustomStringConvertible {
    public var description: String {
        return String(NSStringFromCGPoint(self))
    }
}

extension CGSize: CustomStringConvertible {
    public var description: String {
        return String(NSStringFromCGSize(self))
    }
}

extension CGRect: CustomStringConvertible {
    public var description: String {
        return String(NSStringFromCGRect(self))
    }
}

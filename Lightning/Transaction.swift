//
//  Zap
//
//  Created by Otto Suess on 21.01.18.
//  Copyright © 2018 Otto Suess. All rights reserved.
//

import BTCUtil
import Foundation
import SwiftLnd

public protocol Transaction {
    var id: String { get }
    var amount: Satoshi { get }
    var date: Date { get }
}

extension Transaction {
    public func isTransactionEqual(to transaction: Transaction) -> Bool {
        if let lhs = self as? OnChainConfirmedTransaction, let rhs = transaction as? OnChainConfirmedTransaction {
            return lhs == rhs
        } else if let lhs = self as? Invoice, let rhs = transaction as? Invoice {
            return lhs == rhs
        } else if let lhs = self as? Payment, let rhs = transaction as? Payment {
            return lhs == rhs
        } else {
            return false
        }
    }
}

extension OnChainConfirmedTransaction: OnChainTransaction {}

extension Payment: Transaction {}

extension Invoice: Transaction {}

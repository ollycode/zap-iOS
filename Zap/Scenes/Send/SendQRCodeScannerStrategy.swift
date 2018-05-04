//
//  Zap
//
//  Created by Otto Suess on 25.04.18.
//  Copyright © 2018 Zap. All rights reserved.
//

import BTCUtil
import Foundation

struct SendQRCodeScannerStrategy: QRCodeScannerStrategy {
    let viewControllerHeight: CGFloat = 300
    let title = "scene.deposit.send".localized
    let addressTypes: [AddressType] = [.bitcoinAddress, .lightningInvoice]
    
    func viewControllerForAddressType(_ type: AddressType, address: String, viewModel: ViewModel) -> UIViewController? {
        switch type {
        case .lightningInvoice:
            let viewController = Storyboard.send.instantiate(viewController: SendLightningInvoiceViewController.self)
            viewController.sendViewModel = SendLightningInvoiceViewModel(viewModel: viewModel, lightningInvoice: address)
            return viewController
        case .bitcoinAddress:
            let viewController = Storyboard.withdraw.instantiate(viewController: WithdrawViewController.self)
            viewController.withdrawViewModel = WithdrawViewModel(viewModel: viewModel, address: address)
            return viewController
        default:
            return nil
        }
    }
}
//
//  Zap
//
//  Created by Otto Suess on 22.01.18.
//  Copyright © 2018 Otto Suess. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func instantiateOpenChannelViewController(with openChannelViewModel: OpenChannelViewModel) -> OpenChannelViewController {
        let viewController = Storyboard.openChannel.initial(viewController: OpenChannelViewController.self)
        viewController.openChannelViewModel = openChannelViewModel
        return viewController
    }
}

final class OpenChannelViewController: UIViewController, QRCodeScannerChildViewController {
    weak var delegate: QRCodeScannerChildDelegate?
    
    @IBOutlet private weak var helpLabel: UILabel!
    @IBOutlet private weak var helpImageView: UIImageView!
    @IBOutlet private weak var amountInputView: AmountInputView!
    @IBOutlet private weak var gradientLoadingButton: GradientLoadingButtonView!
    
    fileprivate var openChannelViewModel: OpenChannelViewModel?
    let contentHeight: CGFloat = 550 // QRCodeScannerChildViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Style.label.apply(to: helpLabel)
        
        helpImageView.tintColor = UIColor.zap.black
        helpLabel.text = "scene.open_channel.help_label".localized
        
        gradientLoadingButton.title = "scene.open_channel.add_button".localized
        
        amountInputView.satoshis = 1000000
        amountInputView.validRange = (Lnd.Constants.minChannelSize...Lnd.Constants.maxChannelSize)
    }
    
    @IBAction private func presentHelp(_ sender: Any) {
        print("halp")
    }
    
    @IBAction private func updateAmount(_ sender: Any) {
        openChannelViewModel?.amount = amountInputView.satoshis
    }
    
    @IBAction private func openChannel(_ sender: Any) {
        openChannelViewModel?.openChannel { [weak self] in
            self?.delegate?.dismissSuccessfully()
        }
    }    
}

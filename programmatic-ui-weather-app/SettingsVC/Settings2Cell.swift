//
// Copyright (c) 2021 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

//-----------------------------------------------------------------------------------------------------------------------------------------------
class Settings2Cell: UITableViewCell {

	@IBOutlet var imageViewSetting: UIImageView!
	@IBOutlet var labelTitle: UILabel!
	@IBOutlet var switchButton: UISwitch!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func bindData(setting: [String: Any]) {

		guard let image = setting["image"] as? String else { return }
		guard let title = setting["title"] as? String else { return }
		guard let isSwitch = setting["isSwitch"] as? Bool else { return }

		if image == "" {
			imageViewSetting.isHidden = true
		}
		else {
			imageViewSetting.isHidden = false
			imageViewSetting.image = UIImage(systemName: image)
		}

		labelTitle.text = title

		if isSwitch {
			switchButton.isHidden = false
			accessoryType = .none
			selectionStyle = .none
		}
		else {
			switchButton.isHidden = true
			accessoryType = .disclosureIndicator
			selectionStyle = .default
		}
	}

	// MARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionSwitch(_ sender: Any) {

		print(#function)
	}
}

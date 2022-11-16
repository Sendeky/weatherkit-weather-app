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
class Settings2View: UIViewController {

	@IBOutlet var tableView: UITableView!
    let gradientLayer = CAGradientLayer()

	private var settings: [[String: Any]] = []

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Settings"

		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(actionMore))

		tableView.register(UINib(nibName: "Settings2Cell", bundle: nil), forCellReuseIdentifier: "Settings2Cell")
        tableView.backgroundColor = .clear
		loadData()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let colorTop =  UIColor(red: 0/255.0, green: 235.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 100.0/255.0, green: 50.0/255.0, blue: 235.0/255.0, alpha: 1.0).cgColor
        
        gradientLayer.removeFromSuperlayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

	// MARK: - Data methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loadData() {

		settings.removeAll()

		var section1Settings: [[String: Any]] = []
		var section1Dict: [String: Any] = [:]
		var section2Settings: [[String: Any]] = []
		var section2Dict: [String: Any] = [:]
		var section3Settings: [[String: Any]] = []
		var section3Dict: [String: Any] = [:]

		var dict1: [String: Any] = [:]
		dict1["image"] = ""
		dict1["title"] = "General"
		dict1["isSwitch"] = false
		section1Settings = [dict1]

		section1Dict["title"] = "General"
		section1Dict["data"] = section1Settings

		var dict2: [String: Any] = [:]
		dict2["image"] = ""
		dict2["title"] = "All New Posts"
		dict2["isSwitch"] = true

		var dict3: [String: Any] = [:]
		dict3["image"] = ""
		dict3["title"] = "Friends"
		dict3["isSwitch"] = true

		var dict4: [String: Any] = [:]
		dict4["image"] = ""
		dict4["title"] = "New Places"
		dict4["isSwitch"] = true
		section2Settings = [dict2, dict3, dict4]

		section2Dict["title"] = "NOTIFICATIONS"
		section2Dict["data"] = section2Settings

		var dict5: [String: Any] = [:]
		dict5["image"] = ""
		dict5["title"] = "Label"
		dict5["isSwitch"] = false

		var dict6: [String: Any] = [:]
		dict6["image"] = ""
		dict6["title"] = "Privacy Settings"
		dict6["isSwitch"] = false

		var dict7: [String: Any] = [:]
		dict7["image"] = ""
		dict7["title"] = "Support"
		dict7["isSwitch"] = false
		section3Settings = [dict5, dict6, dict7]

		section3Dict["title"] = "OTHER"
		section3Dict["data"] = section3Settings

		var dict8: [String: Any] = [:]
		dict8["image"] = "globe"
		dict8["title"] = "Facebook"
		dict8["isSwitch"] = true
        

		settings = [section1Dict, section2Dict, section3Dict]

		refreshTableView()
	}

	// MARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionMore() {

		print(#function)
	}

	// MARK: - Refresh methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func refreshTableView() {

		tableView.reloadData()
	}
}

// MARK: - UITableViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension Settings2View: UITableViewDataSource {
    
    //-------------------------------------------------------------------------------------------------------------------------------------------
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return settings.count
    }
    
    //-------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let dataCount = settings[section]["data"] as? [[String: Any]] {
            return dataCount.count
        }
        
        return 0
    }
    
    //-------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let dataCount = settings[section]["title"] as? String {
            return dataCount
        }
        
        return ""
    }
    
    //-------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    //-------------------------------------------------------------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let dataCount = settings[indexPath.section]["data"] as? [[String: Any]] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Settings2Cell", for: indexPath) as! Settings2Cell
            cell.bindData(setting: dataCount[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension Settings2View: UITableViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		print("didSelectItemAt \(indexPath.row)")

		tableView.deselectRow(at: indexPath, animated: true)
	}
}

// Corona-Warn-App
//
// SAP SE and all other contributors
// copyright owners license this file to you under the Apache
// License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import UIKit

final class HomeHighRiskCellConfigurator: HomeRiskLevelCellConfigurator {
	private var numberRiskContacts: Int
	private var daysSinceLastExposure: Int?

	// MARK: Creating a Home Risk Cell Configurator

	init(
		numberRiskContacts: Int,
		daysSinceLastExposure: Int?,
		lastUpdateDate: Date?,
		detectionMode: DetectionMode
	) {
		self.numberRiskContacts = numberRiskContacts
		self.daysSinceLastExposure = daysSinceLastExposure
		super.init(
			isLoading: false,
			isButtonEnabled: true,
			isButtonHidden: detectionMode == .automatic,
			// we never want to hide the detection interval label
			detectionIntervalLabelHidden: false,
			lastUpdateDate: lastUpdateDate
		)
	}

	// MARK: Configuration

	override func configure(cell: RiskLevelCollectionViewCell) {
		cell.delegate = self

		let title: String = isLoading ? AppStrings.Home.riskCardStatusCheckTitle : AppStrings.Home.riskCardHighTitle
		let titleColor: UIColor = .white
		cell.configureTitle(title: title, titleColor: titleColor)
		cell.configureBody(text: "", bodyColor: titleColor, isHidden: true)

		let color = UIColor.preferredColor(for: .negativeRisk)
		let separatorColor = UIColor.white.withAlphaComponent(0.15)
		var itemCellConfigurators: [HomeRiskViewConfiguratorAny] = []
		if isLoading {
			let isLoadingItem = HomeRiskLoadingItemViewConfigurator(title: AppStrings.Home.riskCardStatusCheckBody, titleColor: titleColor, isLoading: true, color: color, separatorColor: separatorColor)
			itemCellConfigurators.append(isLoadingItem)
		} else {
			let numberOfDaysSinceLastExposure = daysSinceLastExposure ?? 0
			let numberContactsTitle = String(format: AppStrings.Home.riskCardNumberContactsItemTitle, numberRiskContacts)
			let item1 = HomeRiskImageItemViewConfigurator(title: numberContactsTitle, titleColor: titleColor, iconImageName: "Icons_RisikoBegegnung", iconTintColor: titleColor, color: color, separatorColor: separatorColor)
			let lastContactTitle = String(format: AppStrings.Home.riskCardLastContactItemTitle, numberOfDaysSinceLastExposure)
			let item2 = HomeRiskImageItemViewConfigurator(title: lastContactTitle, titleColor: titleColor, iconImageName: "Icons_Calendar", iconTintColor: titleColor, color: color, separatorColor: separatorColor)
			let dateTitle = String(format: AppStrings.Home.riskCardDateItemTitle, lastUpdateDateString)
			let item3 = HomeRiskImageItemViewConfigurator(title: dateTitle, titleColor: titleColor, iconImageName: "Icons_Aktualisiert", iconTintColor: titleColor, color: color, separatorColor: separatorColor)
			itemCellConfigurators.append(contentsOf: [item1, item2, item3])
		}
		cell.configureRiskViews(cellConfigurators: itemCellConfigurators)
		cell.configureBackgroundColor(color: color)

		cell.configureChevron(image: UIImage(named: "Icons_Chevron_White"), tintColor: nil)

		let buttonTitle: String = isLoading ? AppStrings.Home.riskCardStatusCheckButton : AppStrings.Home.riskCardHighButton

		let interval = "\(48)"
		let intervalTitle = String(format: AppStrings.Home.riskCardIntervalUpdateTitle, interval)
		cell.configureDetectionIntervalLabel(
			text: intervalTitle,
			isHidden: detectionIntervalLabelHidden
		)
		
		cell.configureUpdateButton(
			title: buttonTitle,
			isEnabled: isButtonEnabled,
			isHidden: isButtonHidden
		)
	}
}

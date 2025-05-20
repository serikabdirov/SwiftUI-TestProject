import DesignSystem
import Factory
import Platform
import SwiftUI

struct FirstView: View {
    @InjectedObservable(\FirstContainer.viewState)
    private var viewState

    var body: some View {
        VStack {
            Text(viewState.dataString ?? "No data")

            Button("Update data") {
                viewState.updateDataButtonTapped()
            }

            Button("Show second") {
                viewState.showSecondButtonTapped()
            }

            Button("Present second") {
                viewState.presentSecondButtonTapped()
            }

            Button("Show main") {
                viewState.showMainButtonTapped()
            }
        }
        .loadingState($viewState.isLoading)
        .errorAlert($viewState.errorMessage)
    }
}

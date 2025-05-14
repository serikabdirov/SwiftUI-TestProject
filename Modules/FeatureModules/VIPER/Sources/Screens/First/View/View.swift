import Factory
import SwiftUI
import DesignSystem

struct FirstView: View {
    @InjectedObservable(\FirstContainer.viewState)
    private var viewState

    var body: some View {
        VStack {
            Text(viewState.dataString ?? "No data")

            Button("Update data")  {
                viewState.updateDataButtonTapped()
            }
        }
        .loadingState($viewState.isLoading)
        .errorAlert($viewState.errorMessage)
    }
}

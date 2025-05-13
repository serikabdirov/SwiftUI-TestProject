import Factory
import SwiftUI

struct ContentView: View {
    @InjectedObservable(\VIPERContainer.viewState)
    private var viewState

    var body: some View {
        VStack {
            Text(viewState.dataString ?? "No data")

            Button("Update data")  {
                viewState.updateDataButtonTapped()
            }
        }
    }
}

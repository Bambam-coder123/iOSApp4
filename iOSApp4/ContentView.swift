import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var editName: String = ""
    @State private var editAge: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter your info")) {
                    TextField("Name", text: $viewModel.name)
                    TextField("Age", text: $viewModel.ageText)
                        .keyboardType(.numberPad)

                    Button("Save") {
                        viewModel.save()
                    }
                }

                Section(header: Text("All Users")) {
                    List {
                        ForEach(viewModel.users) { user in
                            VStack(alignment: .leading) {
                                Text(user.name).bold()
                                Text("Age: \(user.age)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .onTapGesture {
                                // Prepare edit fields
                                viewModel.selectedUser = user
                                editName = user.name
                                editAge = "\(user.age)"
                                viewModel.isEditing = true
                            }
                        }
                        .onDelete(perform: viewModel.deleteUser)
                    }
                }
            }
            .navigationTitle("User Info")
            .onAppear { viewModel.fetchAll() }
            .sheet(isPresented: $viewModel.isEditing) {
                VStack(spacing: 20) {
                    Text("Edit User")
                        .font(.title2)

                    TextField("Name", text: $editName)
                        .textFieldStyle(.roundedBorder)

                    TextField("Age", text: $editAge)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)

                    Button("Save Changes") {
                        viewModel.updateUser(newName: editName, newAgeText: editAge)
                    }
                    .padding(.top)

                    Button("Cancel", role: .cancel) {
                        viewModel.isEditing = false
                    }
                }
                .padding()
            }
        }
    }
}

struct NewTaskView: View {
    // ... existing properties ...
    
    var body: some View {
        NavigationView {
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack(spacing: 20) {
                        // Title section at top
                        VStack(alignment: .leading, spacing: 8) {
                            // ... existing title TextField ...
                        }
                        .padding(.horizontal)
                        
                        // Categories section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Category")
                                .font(.headline)
                                .foregroundColor(.gray)
                            // ... existing categories ...
                        }
                        .padding(.horizontal)
                        
                        // Subtasks section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("SUBTASKS")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            VStack(spacing: 0) {
                                ForEach($subtasks) { $subtask in
                                    VStack(spacing: 0) {
                                        HStack {
                                            TextField("T", text: $subtask.title)
                                                .textFieldStyle(.plain)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                if let index = subtasks.firstIndex(where: { $0.id == subtask.id }) {
                                                    subtasks.remove(at: index)
                                                }
                                            }) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        .padding(.vertical, 12)
                                        
                                        Divider()
                                    }
                                }
                                
                                // Add subtask button
                                Button(action: {
                                    withAnimation {
                                        let newSubtask = Subtask(title: "")
                                        subtasks.append(newSubtask)
                                        // Scroll to the new subtask after adding
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation {
                                                scrollProxy.scrollTo("bottomAnchor", anchor: .bottom)
                                            }
                                        }
                                    }
                                }) {
                                    HStack {
                                        Text("New subtask")
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.blue)
                                    }
                                    .padding(.vertical, 12)
                                }
                            }
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        // Bottom anchor for scrolling
                        Color.clear
                            .frame(height: 1)
                            .id("bottomAnchor")
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            // ... existing toolbar ...
        }
    }
} 
//
//  ManageSlidesView.swift
//  iOS_GrandHotel
//

import SwiftUI
import SwiftData
import PhotosUI
import UIKit

struct ManageSlidesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \OnboardingSlide.order) private var slides: [OnboardingSlide]
    @State private var editor: SlideEditor?

    var body: some View {
        List {
            ForEach(slides) { slide in
                Button {
                    editor = .edit(slide)
                } label: {
                    SlideRow(slide: slide)
                }
                .buttonStyle(.plain)
            }
            .onDelete(perform: deleteSlides)
        }
        .navigationTitle("Manage Slides")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    editor = .add
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add Slide")
            }
        }
        .sheet(item: $editor) { editor in
            SlideEditorSheet(slide: editor.slide, nextOrder: nextOrder)
        }
    }

    private var nextOrder: Int {
        (slides.map(\.order).max() ?? -1) + 1
    }

    private func deleteSlides(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(slides[index])
        }
        try? modelContext.save()
    }
}

private enum SlideEditor: Identifiable {
    case add
    case edit(OnboardingSlide)

    var id: String {
        switch self {
        case .add: return "add"
        case .edit(let slide): return String(describing: slide.persistentModelID)
        }
    }

    var slide: OnboardingSlide? {
        if case .edit(let slide) = self { return slide }
        return nil
    }
}

private struct SlideRow: View {
    let slide: OnboardingSlide

    var body: some View {
        HStack(spacing: 14) {
            Group {
                if let data = slide.image, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "photo")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 52, height: 52)
            .background(Color.secondary.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(slide.title)
                .foregroundStyle(.primary)
            Spacer()
            Text("#\(slide.order + 1)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

private struct SlideEditorSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let slide: OnboardingSlide?
    let nextOrder: Int
    @State private var title: String
    @State private var details: String
    @State private var imageData: Data?
    @State private var selectedPhoto: PhotosPickerItem?

    init(slide: OnboardingSlide?, nextOrder: Int) {
        self.slide = slide
        self.nextOrder = nextOrder
        _title = State(initialValue: slide?.title ?? "")
        _details = State(initialValue: slide?.details ?? "")
        _imageData = State(initialValue: slide?.image)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Content") {
                    TextField("Title", text: $title)
                    TextEditor(text: $details)
                        .frame(minHeight: 120)
                }

                Section("Image") {
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        Label("Choose Photo", systemImage: "photo.on.rectangle")
                    }

                    if let imageData, let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 180)
                    }
                }
            }
            .navigationTitle(slide == nil ? "Add Slide" : "Edit Slide")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .onChange(of: selectedPhoto) { _, newItem in
                guard let newItem else { return }
                Task {
                    guard let data = try? await newItem.loadTransferable(type: Data.self),
                          let image = UIImage(data: data) else { return }
                    imageData = image.jpegData(compressionQuality: 0.8)
                }
            }
        }
    }

    private func save() {
        let cleanedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanedTitle.isEmpty else { return }

        if let slide {
            slide.title = cleanedTitle
            slide.details = details
            slide.image = imageData
        } else {
            modelContext.insert(OnboardingSlide(title: cleanedTitle, details: details, image: imageData, order: nextOrder))
        }
        try? modelContext.save()
        dismiss()
    }
}

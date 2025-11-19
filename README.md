# Sandwich Shop (sandwich_shop)

A small Flutter demo app that models a simple sandwich-order counter. The app
lets a user choose sandwich size (6-inch or footlong), select a bread type,
add an optional order note (e.g. "no onions"), and increment/decrement the
quantity. Buttons are disabled appropriately at the configured limits.

This repository is intended as a lightweight learning/example project and a
starting point for adding real ordering features.

---

## Features

- Select sandwich size: 6-inch or Footlong (toggle control).
- Choose bread type from a dropdown (white, wheat, wholemeal).
- Add a free-text note for the order (e.g., "no onions").
- Increment / decrement quantity with Add / Remove buttons.
- Buttons automatically disable at 0 (Remove) and at the configured maximum
	quantity (Add).

---

## Requirements

- Flutter SDK (stable) — the project requires a Dart SDK compatible with
	`>=2.17.0 <4.0.0` (see `pubspec.yaml`).
- A platform toolchain to run: Android SDK or desktop tooling if you run on
	Windows/macOS/Linux.

You can check your installed Flutter/Dart versions with:

```powershell
flutter --version
dart --version
```

---

## Installation & Setup

1. Install Flutter following the official guide: https://docs.flutter.dev/get-started/install
2. From the repository root, fetch packages:

```powershell
flutter pub get
```

3. Open the project in your editor (VS Code, Android Studio, IntelliJ).

Notes about package name and imports
- The package name declared in `pubspec.yaml` is `sandwich_shop` and the
	app code imports using `package:sandwich_shop/...`. If you ever rename the
	package in `pubspec.yaml`, update any `package:` imports or run `flutter
	pub get` and restart the analyzer.

If you previously saw an error like:

```
Target of URI doesn't exist: 'package:sandwitch_app/main.dart'.
```

that usually means either:

- your `pubspec.yaml` `name:` value doesn't match the package used in imports;
- or the imported file does not exist under `lib/`.

To fix: ensure `pubspec.yaml` `name:` matches the `package:` imports and that
files referenced by `package:` URIs are present inside `lib/`.

---

## Running the App (Windows / PowerShell)

To run on an attached device or emulator:

```powershell
# fetch deps
flutter pub get

# run on the default connected device/emulator
flutter run
```

To run on a specific device (e.g., Windows desktop) use:

```powershell
flutter run -d windows
```

If you use VS Code you can press F5 or use the Run and Debug pane.

---

## Usage (what the app does)

1. Start the app. The main screen shows the current sandwich line with a count
	 and a preview of the sandwich emoji repeated for the current quantity.
2. Use the size toggle to pick `6-inch` or `footlong`. The displayed label
	 updates accordingly.
3. Choose bread type from the dropdown; the selection is shown in the line
	 preview.
4. Enter any special requests in the note text field (e.g., "no onions").
5. Tap `Add` to increase quantity (note is captured when the button is pressed).
6. Tap `Remove` to decrease quantity. Buttons are disabled when they cannot
	 perform an action (0 for Remove, configured max for Add).

---

## Project Structure (important files)

- `lib/main.dart` — main app UI and logic (OrderScreen, OrderItemDisplay,
	StyledButton). This file demonstrates the UI for size selection, bread type
	dropdown, notes input, and Add/Remove behavior.
- `lib/views/app_styles.dart` — shared `TextStyle` constants used by the UI.
- `lib/repositories/order_repository.dart` — a small repository class that
	stores the current order quantity and enforces `maxQuantity`.
- `pubspec.yaml` — package metadata and dependencies.

---

## Technologies & Packages

- Flutter (uses material.dart widgets)
- Dart language
- No third-party packages beyond `cupertino_icons` in `pubspec.yaml`.

---

## Extending the App (ideas)

- Persist orders to local storage (shared_preferences or a lightweight DB).
- Implement multiple order lines (support different notes per line item).
- Add a cart screen and checkout flow.
- Add input validation and better UX for long notes.

---

## Troubleshooting

- If widgets or imports report missing package URIs, run `flutter pub get`
	and restart your editor's Dart/Flutter analyzer.
- If the app doesn't start on a device, make sure an emulator is running or a
	device is connected (`flutter devices`).

---

## Contact / Author

This is a small demo project. For changes, open the repository in your IDE
and modify `lib/main.dart` or the small supporting files under `lib/views`
and `lib/repositories`.

---



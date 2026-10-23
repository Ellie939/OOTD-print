# OOTD PRINT 👗

OOTD PRINT is a SwiftUI app that randomly selects an outfit and presents its clothing pieces, color palette, and styling notes. Inspired by a receipt printer, each outfit is revealed through a playful printing animation.

## Features

- **Random Outfit Generator** — Discover a randomly selected outfit with one tap.
- **Outfit Inspiration** — Explore five curated outfits with different styles and color combinations.
- **Color Palettes** — View the colors used in each look.
- **Styling Details** — See outfit items and short styling descriptions.
- **Receipt Printing Animation** — Watch your outfit recommendation appear as a printed receipt.

## Outfit Collection

1. Leopard Lemon Yellow（豹紋檸檬黃）
2. Mint Chocolate（薄荷巧克力）
3. American Denim（美式丹寧）
4. Blue Sky & White Clouds（藍天白雲）
5. Forest Girl（森系女孩）

## Built With

- Swift
- SwiftUI
- Xcode

## How It Works

The app uses a custom `Outfit` struct to organize outfit information, with five outfits stored in an Array.

When the user taps **PRINT MY LOOK**, a random outfit is selected. SwiftUI's `@State` updates the displayed information, while a simple animation gradually reveals the outfit receipt.

## About This Project

This app was created as a SwiftUI practice project to explore data models, arrays, state management, random selection, and interactive UI design.

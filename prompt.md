# Sandwich Shop Cart Modification Feature

## Overview
Implement cart item modification functionality to allow users to adjust quantities and remove items from their cart on the CartScreen.

## Features to Implement

### 1. Modify Item Quantity
**Description:** Allow users to change the quantity of items already in their cart.

**User Actions:**
- User taps on a cart item or sees quantity controls (increment/decrement buttons) next to each item
- User can increase quantity by tapping a plus icon/button
- User can decrease quantity by tapping a minus icon/button
- User cannot decrease below 1 (minus button should be disabled at quantity 1)

**Expected Behavior:**
- The item's subtotal price updates instantly when quantity changes
- The cart's total price updates instantly
- The item count in the cart updates if quantity reaches 0 (item removed)
- A confirmation message or toast appears showing the quantity change (e.g., "Updated Tuna Melt quantity to 3")

### 2. Remove Item from Cart
**Description:** Allow users to delete items entirely from their cart.

**User Actions:**
- User sees a delete/remove icon (trash icon or X button) on each cart item
- User taps the delete button
- A confirmation dialog appears asking "Remove this item from cart?" with Cancel and Confirm buttons (optional but recommended)

**Expected Behavior:**
- If user confirms, the item is removed from the cart
- The cart total price updates
- The item count updates
- The item count in the OrderScreen's cart summary updates
- If the cart becomes empty, display "Your cart is empty" message
- A confirmation message appears (e.g., "Removed Tuna Melt from cart")

### 3. Clear Entire Cart
**Description:** Allow users to clear all items from their cart at once.

**User Actions:**
- User sees a "Clear Cart" or "Empty Cart" button at the bottom of the CartScreen (only visible if cart has items)
- User taps the button
- A confirmation dialog appears asking "Clear all items from cart?" with Cancel and Confirm buttons

**Expected Behavior:**
- If user confirms, all items are removed
- The cart becomes empty and displays "Your cart is empty"
- The item count and total in the OrderScreen's cart summary reset to 0
- User is returned to the OrderScreen or stays on CartScreen with empty state

## Technical Considerations

- **State Management:** Cart modifications should update both CartScreen and the cart summary display on OrderScreen
- **Pricing:** Use the existing `_priceFor()` pricing logic to calculate updated totals
- **Navigation:** User can navigate back to OrderScreen to add more items, or modify existing cart items
- **Empty State:** Handle the empty cart state gracefully with appropriate messaging
- **Testing:** Include widget tests for each modification action to ensure cart updates correctly

## Success Criteria

- Users can modify quantities without reloading the page
- Users can remove individual items or clear the entire cart
- All price calculations update in real-time
- User receives clear feedback for all actions taken
- Cart state persists while navigating between screens
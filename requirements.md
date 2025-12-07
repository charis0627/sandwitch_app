# Cart Modification Feature - Requirements Document

## 1. Feature Description

### Overview
The Cart Modification Feature enables users to adjust their sandwich orders after adding items to the cart. Users can increase or decrease item quantities, remove individual items, or clear their entire cart. This provides flexibility and control over their order before checkout.

### Purpose
- Allow users to correct mistakes in their orders
- Enable users to adjust quantities without restarting their order
- Provide a seamless shopping experience by letting users modify their cart without returning to the order screen
- Maintain real-time updates to cart totals and item counts across all screens

### Scope
This feature applies to the CartScreen and impacts the OrderScreen's cart summary display. It does not include checkout, payment, or order confirmation functionality.

---

## 2. User Stories

### User Story 1: Increase Item Quantity
**As a** customer  
**I want to** increase the quantity of an item in my cart  
**So that** I can order more of the same sandwich without adding it separately

**Acceptance Criteria:**
- Given I'm viewing my cart with at least one item
- When I tap the plus/increment button next to an item
- Then the item's quantity increases by 1
- And the item's subtotal price updates correctly
- And the cart total price updates immediately
- And a confirmation message appears (e.g., "Updated [Sandwich Name] quantity to X")

### User Story 2: Decrease Item Quantity
**As a** customer  
**I want to** decrease the quantity of an item in my cart  
**So that** I can reduce the number of sandwiches I'm ordering

**Acceptance Criteria:**
- Given I'm viewing my cart with an item having quantity > 1
- When I tap the minus/decrement button next to that item
- Then the item's quantity decreases by 1
- And the item's subtotal price updates correctly
- And the cart total price updates immediately
- And a confirmation message appears (e.g., "Updated [Sandwich Name] quantity to X")
- And the minus button remains enabled as long as quantity > 1

### User Story 3: Prevent Invalid Quantity
**As a** customer  
**I want** the minus button to be disabled when quantity is 1  
**So that** I don't accidentally go below the minimum quantity of 1

**Acceptance Criteria:**
- Given I'm viewing my cart with an item having quantity = 1
- When I look at the minus button for that item
- Then the button is disabled (grayed out/non-clickable)
- And attempting to tap it has no effect

### User Story 4: Remove Individual Item
**As a** customer  
**I want to** remove a specific item from my cart entirely  
**So that** I can delete items I no longer want to order

**Acceptance Criteria:**
- Given I'm viewing my cart with at least one item
- When I tap the delete/remove button (trash icon) on an item
- Then a confirmation dialog appears asking "Remove [Sandwich Name] from cart?"
- And the dialog has Cancel and Confirm buttons
- When I tap Confirm
- Then the item is removed from the cart
- And the cart total price updates
- And the item count updates
- And a confirmation message appears (e.g., "Removed [Sandwich Name] from cart")
- When I tap Cancel
- Then the dialog closes and no changes are made

### User Story 5: Clear Entire Cart
**As a** customer  
**I want to** clear all items from my cart at once  
**So that** I can start over with a fresh order

**Acceptance Criteria:**
- Given I'm viewing my cart with multiple items
- When I look at the bottom of the CartScreen
- Then I see a "Clear Cart" button
- When I tap the "Clear Cart" button
- Then a confirmation dialog appears asking "Clear all items from cart?"
- And the dialog has Cancel and Confirm buttons
- When I tap Confirm
- Then all items are removed from the cart
- And the cart displays "Your cart is empty"
- And the cart summary on OrderScreen shows Items: 0 and Total: $0.00
- And a confirmation message appears (e.g., "Cart cleared")
- When I tap Cancel
- Then the dialog closes and no changes are made

### User Story 6: Empty Cart Visibility
**As a** customer  
**I want to** only see the "Clear Cart" button when my cart has items  
**So that** I'm not distracted by irrelevant controls

**Acceptance Criteria:**
- Given my cart is empty or becomes empty
- Then the "Clear Cart" button is not displayed
- Given my cart has at least one item
- Then the "Clear Cart" button is visible and clickable

### User Story 7: Cart Summary Synchronization
**As a** customer  
**I want** the cart summary on the OrderScreen to update when I modify my cart  
**So that** I always see accurate cart totals even when switching between screens

**Acceptance Criteria:**
- Given I modify an item's quantity or remove an item while on CartScreen
- When I navigate back to OrderScreen
- Then the cart summary (Items count and Total price) reflects the changes
- And the prices are calculated correctly using the existing pricing logic

### User Story 8: Real-Time Total Updates
**As a** customer  
**I want** the cart total to update instantly when I change quantities  
**So that** I always know the current cost of my order

**Acceptance Criteria:**
- Given I'm viewing my cart
- When I change the quantity of any item (increase or decrease)
- Then the item's subtotal updates immediately
- And the cart total price updates immediately
- And all displayed prices are formatted to 2 decimal places (e.g., $22.50)

---

## 3. Acceptance Criteria Summary

### Functional Requirements
1. **Quantity Increment:** Users can increase item quantity with plus button; updates prices in real-time
2. **Quantity Decrement:** Users can decrease item quantity with minus button; minus button disabled at quantity 1; updates prices in real-time
3. **Item Removal:** Users can remove items with confirmation dialog; removes item and updates totals
4. **Cart Clearing:** Users can clear entire cart with confirmation dialog; hides button when cart is empty
5. **Real-Time Updates:** All prices and totals update immediately without page refresh
6. **Synchronization:** Cart summary on OrderScreen stays in sync with CartScreen modifications
7. **User Feedback:** Confirmation messages appear for all actions (quantity changes, removals)

### UI/UX Requirements
1. **Plus/Minus Buttons:** Clear increment/decrement controls next to each item quantity
2. **Delete Button:** Visible delete/trash icon on each item
3. **Clear Cart Button:** Visible only when cart has items; positioned at bottom
4. **Confirmation Dialogs:** Show for destructive actions (remove item, clear cart)
5. **Empty State:** Display "Your cart is empty" message when no items present
6. **Price Formatting:** All prices displayed with currency symbol and 2 decimal places

### Technical Requirements
1. **State Management:** Cart modifications update both CartScreen and OrderScreen cart summary
2. **Pricing Logic:** Use existing `_priceFor()` method for consistent calculations
3. **Navigation:** Users can modify cart and return to OrderScreen seamlessly
4. **Testing:** Widget tests for all modification actions
5. **Error Prevention:** Validation to prevent invalid quantities (< 1)

### Performance Requirements
1. **Real-Time Response:** UI updates immediately on user action (no delay)
2. **Memory Efficient:** No unnecessary state rebuilds or data duplication

---

## 4. Subtasks

### Backend/Logic Subtasks
- [ ] Implement quantity increment method in Cart class (or use existing `setQuantity`)
- [ ] Implement quantity decrement method in Cart class
- [ ] Implement remove item method in Cart class (already exists as `removeItem`)
- [ ] Implement clear cart method in Cart class (already exists as `clear`)
- [ ] Ensure pricing calculations are consistent across OrderScreen and CartScreen

### UI/Frontend Subtasks
- [ ] Add plus/minus buttons to each CartScreen item for quantity modification
- [ ] Add delete/trash icon button to each CartScreen item
- [ ] Implement quantity change confirmation messages
- [ ] Implement item removal confirmation dialog
- [ ] Add "Clear Cart" button to CartScreen (visible only when cart has items)
- [ ] Implement clear cart confirmation dialog
- [ ] Update CartScreen to show real-time total and item count
- [ ] Implement empty cart state UI

### Integration Subtasks
- [ ] Integrate quantity modifications into CartScreen UI
- [ ] Ensure OrderScreen cart summary updates when returning from CartScreen
- [ ] Test synchronization between OrderScreen and CartScreen
- [ ] Handle navigation between screens with modified carts

### Testing Subtasks
- [ ] Write widget test for quantity increment
- [ ] Write widget test for quantity decrement
- [ ] Write widget test for minus button disabled state
- [ ] Write widget test for item removal with confirmation
- [ ] Write widget test for cart clearing with confirmation
- [ ] Write widget test for empty cart state
- [ ] Write widget test for cart summary synchronization
- [ ] Write widget test for real-time total updates
- [ ] Write widget test for price formatting

---

## 5. Out of Scope

- Checkout functionality
- Payment processing
- Order confirmation and receipt generation
- Order history or saved carts
- Promotional codes or discounts
- Inventory management or stock checking
- User authentication or account management
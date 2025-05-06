# Team DimensionalDesign

## Team Members

- Ashton Glassell (jglssell@memphis.edu)
- Brianna Armstrong (brrmstr1@memphis.edu)
- Suchir Reganti (sreganti@memphis.edu)

## Brie's Documentation
* brie-add-product-pages branch

- (Product/Account/PaymentSource) Model and Controller created
- User model modified for one to one relationship with Account object
- All object relations added in corresponding model files and migration files
- Sign In and Sign Out functions added
- /products and /products/id and /products/id/download routes added

- /account page created and edit from made 
    - Unresolved: Update button doesn't successfully update

- /accounts/payments mock routes added (PageHolder for the index method and page)

- product download, index, and show html.erb pages fully complete and functional

- modified _navbar: Home directs to /products page and Text changed to "View Products" and "Account Details" to the /account page

- Seeded database for different test cases

M2 Contributions

* Branches:
  brie-global_and_navbar_styling_update
  brie-global_styling_update
  brie-navbar_update
  brie-product_bug_fix
  brie_index_and_show_styling

* Created Controller
- NavPages 

* Modified Files 
- _navbar.html.erb
- products_controller.rb
- layouts/application.html.erb
- nav_pages/home.html.erb (Added)
- nav_pages/about.html.erb (Added)
- products/index.html.erb
- products/show.html.erb

* Generalized Changes
- fixed product bug
  - User could only buy their own products, not other users' products
- Created Home and About Pages
- Styled NavBar
- Styled Product Index and Show Page



## Suchir's Documentation

**Branches:** `account`, `payment`, `routes`, `suchir-purchased-products`

---

### Models & Associations
- **Account** model implemented with attributes: `user_name`, `first_name`, `last_name`, `phone`, and `user_id`
- **User** model updated:
  - `has_one :account, dependent: :destroy`
  - `has_many :purchases`
  - `has_many :purchased_products, through: :purchases, source: :product`
  - `after_create :build_default_account` to auto-generate an account after sign-up
- **Purchase** model:
  - Created to track transactions between users and products
  - Belongs to both `user` and `product`
- All necessary model associations and validations added
- Validations updated to allow partial updates with `allow_blank: true`
- **PaymentSource** model created with:
  - Fields: `payment_type`, `card_number`, `cardholder_name`, `expiration_month`, `expiration_year`, `cvv`
  - `belongs_to :account`
  - Enum-like validation on `payment_type`

---

### Routes
- Existing `resource :account` routes (`/account`, `/account/edit`) used as-is
- Nested routes added in `payment` branch for payment methods under account:
  - `/account/payments`, `/account/payments/new`, `/account/payments/:id/edit`, etc.
- Full manual routing defined in `routes` branch with:
  - Custom paths for products, payments, listings, purchases, login, recovery, and account management
- Purchase-related product actions:
  - `/products/:id/buy_now`, `/products/:id/confirm_purchase`, `/products/:id/download`, etc.

---

### Controllers
- `AccountsController`:
  - `show` action updated to include `@purchased_products` using `current_user.purchased_products`
- `PaymentSourcesController` created with full CRUD support:
  - `index`, `new`, `create`, `edit`, `update`, and `destroy`
  - Proper validation and flash messaging
- `ProductsController`:
  - `confirm_purchase` action creates a new `Purchase` if one doesn't exist for the user/product
  - Purchase logic ensures duplicate purchases are prevented
- `ApplicationController` updated with:
  - `after_sign_in_path_for` → `/account`
  - `after_sign_up_path_for` → `/account`
  - `after_sign_out_path_for` → `/login`

---

### Views
- `accounts/show.html.erb`:
  - Displays user account and email info
  - Lists user’s uploaded products under **Your Products**
  - New **Purchased Products** section displays products the user bought
  - Shows appropriate message if no purchases exist
- `accounts/edit.html.erb`:
  - Includes read-only email
  - Allows partial updates of profile fields
  - Flash message on success or failure
- `payment_sources/index.html.erb`: list of all saved methods with Edit/Delete buttons
- `payment_sources/new.html.erb` and `edit.html.erb`: forms with validation feedback
- Global flash display via `app/views/shared/_flash.html.erb`

---

### Navbar
- `_navbar.html.erb`:
  - Shows **"View Products"** and **"Account Details"**
  - Adds Sign Out (with `method: :delete`) or Login link based on login state
- Fixed logout error by:
  - Pinning `@rails/ujs` with `importmap`
  - Importing and starting UJS in `application.js`
  - Adding it to `manifest.js` for precompilation

---

### Additional Fixes & Improvements
- Sign Out works as a DELETE request (not GET)
- Partial profile updates supported — fields can be left blank
- Redirect after profile update changed from homepage → `/account`
- All profile data correctly saves to `Account` model (not `User`)
- Payments validated and handled through controller, flash, and view feedback
- Editing/deleting payment methods fully functional
- Products controller updated to redirect users without a payment method back to account page with appropriate flash
- **Purchased Products section added** to `accounts#show`, dynamically updates after purchasing
- Confirmed data is persisted in `purchases` table and reflected in views

---

**Status:**  
F02: *Account Creation/Login* – Complete  
F04: *Payment Method Management* – Complete  
F06: *Purchases Tracking/View* – Complete  
Custom `routes.rb` structure – Complete



### Ashton's Documentation

Branches:
   M2:
   - ashton-listings-management
   - ashton-new-prod-hotfix1
   - ashton-multi-photos
   - ashton-sort-products
   M1:
   - ashton-seed-changes-2

product.rb:
   M2:
   - updated photos relation to has_many instead of has_one to allow for multiple photos

ProductsController:
   M2:
   - "authorization" method to restrict product manipulation
   - search and sort helper logic in "index" method
   - "update" method changed to avoid losing old data when editing products unless intended by seller.

   M1:
   - new and create methods for adding products
   - edit and update methods for modifying products
   - destroy method for removing products
   - helper method for strong product parameters

views/accounts/show
   M1:
   - Product management section that lists items for sale
   - can add new, edit, and remove from this section

views/products/new
   M2:
   - edited fields to allow multiple photos and files to be uploaded
   M1:
   - full form for uploading new product

views/products/edit
   M2: 
   - edited fields to allow multiple photos and files to be uploaded
   - previously uploaded files and photos can now be viewed and individually deleted
   M1:
   - full form to modify product, including uploading pictures

views/products/index
   M2:
   - Added search bar
   - Added "sort by" drop down
   M1:
   - Sign in button appears when not signed in

views/products/show
   M2:
   - additional photos are now displayed in a grid
   - photos can be clicked for a larger view
   M1:
   - buttons to edit or delete appear if viewed by seller

views/shared/_navbar.html
   M1:
   - Navbar shows team name
   - clicking logo returns to root

routes
   M1:
   - added routes corresponding with new methods in ProductsController

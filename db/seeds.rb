# frozen_string_literal: true

# db/seeds.rb
require 'open-uri'

puts 'Resetting data...'
PaymentSource.delete_all
Product.delete_all
Account.delete_all
User.delete_all

#
# ─── USER1: CAN BUY & DOWNLOAD ────────────────────────────────────────────────
#
puts 'Seeding User1...'
user1 = User.create!(
  email:                 'aliceangel123@gmail.com',
  password:              'password123',
  password_confirmation: 'password123'
)
acct1 = user1.account
acct1.update!(
  user_name:  'AliceAngel3',
  first_name: 'Alice',
  last_name:  'Anderson',
  phone:      '+15550001111'
)
acct1.payment_sources.create!(
  payment_type:     'Visa',
  card_number:      '4111111111111111',
  cardholder_name:  'Alice Anderson',
  expiration_month: 12,
  expiration_year:  2030,
  cvv:              '123'
)


# Product G: 3 images, 1 file
prod_g = acct1.products.create!(
  name:        'The Soldier',
  price:       20.00,
  description: 'AtteeeeeentION! The soldier from Team Fortress 2 is here! A simple statue of a rocket-wielding legend.' 
)

# Attach multiple local images
image_paths = [
  Rails.root.join("app/assets/seed_files/soldier/soldier.png"),
  Rails.root.join("app/assets/seed_files/soldier/soldier front.PNG"),
  Rails.root.join("app/assets/seed_files/soldier/soldier side.PNG")
]

image_paths.each do |image_path|
  image = File.open(image_path) # Correct method
  prod_g.photos.attach(
    io: image,
    filename: File.basename(image_path), # Correct method
    content_type: Marcel::MimeType.for(image_path) # Automatically detect file type
  )
end

# Attach various files as templates
file_paths = [
  Rails.root.join("app/assets/seed_files/soldier/tf2-soldier.zip")
]

file_paths.each do |file_path|
  file = File.open(file_path)
  prod_g.templates.attach( # Correct product reference
    io: file,
    filename: File.basename(file_path),
    content_type: Marcel::MimeType.for(file_path) # Auto-detect file type
  )
end


# Product F
prod_f = acct1.products.create!(
  name:        'Portal Gun',
  price:       10.00,
  description: 'A replica of the Portal Gun from the Portal game series. Ideal for prop creation or for a little easter egg in your collection!'
)

# Attach multiple local images
image_paths = [
  Rails.root.join("app/assets/seed_files/portalgun/protalgun preview.jpg"),
  Rails.root.join("app/assets/seed_files/portalgun/Portal Gun sides.jpg")
]

image_paths.each do |image_path|
  image = File.open(image_path) # Correct method
  prod_f.photos.attach(
    io: image,
    filename: File.basename(image_path), # Correct method
    content_type: Marcel::MimeType.for(image_path) # Automatically detect file type
  )
end

# Attach various files as templates
file_paths = [
  Rails.root.join("app/assets/seed_files/portalgun/PortalGun.rar")
]

file_paths.each do |file_path|
  file = File.open(file_path)
  prod_f.templates.attach( # Correct product reference
    io: file,
    filename: File.basename(file_path),
    content_type: Marcel::MimeType.for(file_path) # Auto-detect file type
  )
end



# Product A: 1 photo, 2 files
prod_a = acct1.products.create!(
  name:        'Car',
  price:       19.99,
  description: 'This is an old car, inspired loosely by the Mini-Cooper. Perfect for a town diorama or just practice painting!'
)

# Attach a local image
image_path = Rails.root.join("app/assets/seed_files/car/car.PNG") # Update the path
io = File.open(image_path)
prod_a.photos.attach(io: io, filename: "car.jpg", content_type: "image/jpeg")

# Attach files
file_paths = [
  Rails.root.join("app/assets/seed_files/car/source.zip"),
  Rails.root.join("app/assets/seed_files/car/textures.rar")
]

file_paths.each do |file_path|
  file = File.open(file_path)
  prod_a.templates.attach(
    io: file,
    filename: File.basename(file_path),
    content_type: Marcel::MimeType.for(file_path) # Automatically detect file type
  )
end


# Product B: 3 images, 1 file
prod_b = acct1.products.create!(
  name:        'Egg',
  price:       0.00,
  description: 'Hehehe, egg'
)

# Attach multiple local images
image_paths = [
  Rails.root.join("app/assets/seed_files/egg/egg view.PNG"),
  Rails.root.join("app/assets/seed_files/egg/egg front.PNG"),
  Rails.root.join("app/assets/seed_files/egg/egg top.PNG")
]

image_paths.each do |image_path|
  image = File.open(image_path) # Correct method
  prod_b.photos.attach(
    io: image,
    filename: File.basename(image_path), # Correct method
    content_type: Marcel::MimeType.for(image_path) # Automatically detect file type
  )
end

# Attach various files as templates
file_paths = [
  Rails.root.join("app/assets/seed_files/egg/EGG.fbx"),
]

file_paths.each do |file_path|
  file = File.open(file_path)
  prod_b.templates.attach( # Correct product reference
    io: file,
    filename: File.basename(file_path),
    content_type: Marcel::MimeType.for(file_path) # Auto-detect file type
  )
end


# Product C: 2 image, 1 file
prod_c = acct1.products.create!(
  name:        'Isosphere',
  price:       12.50,
  description: 'A simple Isosphere with removable panels'
)
image_paths = [
  Rails.root.join("app/assets/seed_files/isosphere/isosphere.PNG"),
  Rails.root.join("app/assets/seed_files/isosphere/iso exploded.PNG"),
]

image_paths.each do |image_path|
  image = File.open(image_path) # Correct method
  prod_c.photos.attach(
    io: image,
    filename: File.basename(image_path), # Correct method
    content_type: Marcel::MimeType.for(image_path) # Automatically detect file type
  )
end

# Attach various files as templates
file_paths = [
  Rails.root.join("app/assets/seed_files/isosphere/Isosphere.fbx"),
]

file_paths.each do |file_path|
  file = File.open(file_path)
  prod_c.templates.attach( # Correct product reference
    io: file,
    filename: File.basename(file_path),
    content_type: Marcel::MimeType.for(file_path) # Auto-detect file type
  )
end



#
# ─── USER2: CANNOT BUY (NO PAYMENT), HAS PRODUCTS ────────────────────────────
#
puts 'Seeding User2...'
user2 = User.create!(
  email:                 'zap105@yahoo.com',
  password:              'thisissafe',
  password_confirmation: 'thisissafe'
)
acct2 = user2.account
acct2.update!(
  user_name:  'zap105',
  first_name: 'Ashton',
  last_name:  'Glassell',
  phone:      '+15550002222'
)


# Product D: 3 images, 1 file
prod_d = acct2.products.create!(
  name:        'Chibirobo',
  price:       20.00,
  description: 'A small, stylized, wind-up robot. Comes rigged for ease of posing. Requires Blender v2.8 or later to open files!'
)

# Attach multiple local images
image_paths = [
  Rails.root.join("app/assets/seed_files/chibirobo/chibirobo render.png"),
  Rails.root.join("app/assets/seed_files/chibirobo/chibirobo front.PNG"),
  Rails.root.join("app/assets/seed_files/chibirobo/chibirobo side.PNG")
]

image_paths.each do |image_path|
  image = File.open(image_path) # Correct method
  prod_d.photos.attach(
    io: image,
    filename: File.basename(image_path), # Correct method
    content_type: Marcel::MimeType.for(image_path) # Automatically detect file type
  )
end

# Attach various files as templates
file_paths = [
  Rails.root.join("app/assets/seed_files/chibirobo/chibirobo.blend"),
]

file_paths.each do |file_path|
  file = File.open(file_path)
  prod_d.templates.attach( # Correct product reference
    io: file,
    filename: File.basename(file_path),
    content_type: Marcel::MimeType.for(file_path) # Auto-detect file type
  )
end


# Product E: 3 images, 1 file
prod_e = acct2.products.create!(
  name:        'Computer',
  price:       30.00,
  description: 'A computer who can walk and talk! Comes rigged for ease of posing. Requires Blender v2.8 or later to open files!'
)

# Attach multiple local images
image_paths = [
  Rails.root.join("app/assets/seed_files/computer/computer render.png"),
  Rails.root.join("app/assets/seed_files/computer/computer front.PNG"),
  Rails.root.join("app/assets/seed_files/computer/computer side.PNG")
]

image_paths.each do |image_path|
  image = File.open(image_path) # Correct method
  prod_e.photos.attach(
    io: image,
    filename: File.basename(image_path), # Correct method
    content_type: Marcel::MimeType.for(image_path) # Automatically detect file type
  )
end

# Attach various files as templates
file_paths = [
  Rails.root.join("app/assets/seed_files/computer/Computer.blend"),
]

file_paths.each do |file_path|
  file = File.open(file_path)
  prod_e.templates.attach( # Correct product reference
    io: file,
    filename: File.basename(file_path),
    content_type: Marcel::MimeType.for(file_path) # Auto-detect file type
  )
end



#
# ─── USER3: CAN MANAGE PAYMENT, NO PRODUCTS ──────────────────────────────────
#
puts 'Seeding User3...'
user3 = User.create!(
  email:                 'C_Clark@aol.com',
  password:              '5May1987',
  password_confirmation: '5May1987'
)
acct3 = user3.account
acct3.update!(
  user_name:  'Carol_Clark3',
  first_name: 'Carol',
  last_name:  'Clark',
  phone:      '+15550003333'
)
acct3.payment_sources.create!(
  payment_type:     'PayPal',
  card_number:      'carol@paypal.example',
  cardholder_name:  'Carol Clark',
  expiration_month: 1,
  expiration_year:  2035,
  cvv:              '000'
)


#
# ─── USER4: CANNOT BUY, NO PRODUCTS ──────────────────────────────────────────
#
puts 'Seeding User4...'
user4 = User.create!(
  email:                 'Davy555@gmail.com',
  password:              'Dsquared2',
  password_confirmation: 'Dsquared2'
)
acct4 = user4.account
acct4.update!(
  user_name:  'DavyJonesLocker',
  first_name: 'Dave',
  last_name:  'Davis',
  phone:      '+15550004444'
)

puts 'Seeding complete!'

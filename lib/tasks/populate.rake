namespace :populate do
  desc "Seed Data User"
  task seed_user: :environment do
    data_any? User
    User.create!(username: "superuser",
      email: "example@perfum.org",
      first_name: "Super",
      last_name: "User",
      password: "abcd1234",
      password_confirmation: "abcd1234",
      is_admin: true,
      is_active: true,
      activated_at: Time.zone.now,
      role_ids: Role.first.id)

    10.times do |n|
      username = Faker::Games::Dota.hero
      first_name = "Example"
      last_name = "User#{n + 1}"
      email = "example-#{n + 1}@perfum.org"
      password = "abcd1234"
      User.create!(username:  username,
                   last_name: last_name,
                   first_name: first_name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   is_active: true,
                   activated_at: Time.zone.now,
                   role_ids: Role.last.id)
    end
  end

  desc "Seed Data Category"
  task seed_category: :environment do
    data_any? Category
    5.times do |n|
      name = "Example Category#{n + 1}"
      description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
       Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
       when an unknown printer took a galley of type and scrambled it to make a type specimen book."
      Category.create!(
        category_name: name,
        description: description
      )
    end
  end

  desc "Seed Data Role"
  task seed_role: :environment do
    data_any? Role
    Role.create(
      role_name: "Administrator",
      description: "Administrator"
    )
    Role.create(
      role_name: "Moderator",
      description: "Moderator"
    )
    Role.create(
      role_name: "User",
      description: "User"
    )
  end

  desc "Seed Data Sense"
  task seed_sense: :environment do
    data_any? Sense
    20.times do
      sense_name = Faker::Verb.base
      Sense.create!(sense_name: sense_name)
    end
  end

  desc "Seed Data Brand"
  task seed_brand: :environment do
    data_any? Brand
    20.times do
      brand_name = Faker::Verb.base
      description = "This is description"
      Brand.create!(brand_name: brand_name, description: description)
    end
  end

  desc "Seed Data Supplier"
  task seed_supplier: :environment do
    data_any? Supplier
    10.times do
      company_name = Faker::Company.name
      contact_name = Faker::Name.name
      homepage = "https://google.com"
      address = Faker::Address.street_address
      city = Faker::Address.city
      Supplier.create!(
        company_name: company_name,
        contact_name: contact_name,
        homepage: homepage,
        address: address,
        city: city
      )
    end
  end

  desc "Seed Data Product"
  task seed_product: :environment do
    data_any? Product
    20.times do |n|
      product_name = Faker::Superhero.name
      quantity_per_init = rand(1..2)
      unit_price = 49.99
      unit_in_stock = rand(1..10)
      unit_in_order = rand(unit_in_stock)
      discontinue = false
      reorderlevel = rand(1..3)
      concentration = Faker::Number.number(3)
      product_style = Faker::Vehicle.style
      weight = rand(100...500)
      description = Faker::Lorem.paragraph
      picture_url = Faker::LoremPixel.image("400x600")
      category_id = rand(Category.first.id..Category.last.id)
      brand_id = rand(Brand.first.id..Brand.last.id)
      supplier_id = rand(Supplier.first.id..Supplier.last.id)
      sense_id = rand(Sense.first.id..Sense.last.id)
      Product.create!(
        product_name: product_name,
        quantity_per_init: quantity_per_init,
        unit_price: unit_price,
        unit_in_stock: unit_in_stock,
        unit_in_order: unit_in_order,
        discontinue: discontinue,
        reorderlevel: reorderlevel,
        concentration: concentration,
        product_style: product_style,
        weight: weight,
        description: description,
        picture_url: picture_url,
        category_id: category_id,
        brand_id: brand_id,
        supplier_id: supplier_id,
        sense_id: sense_id
      )
    end
  end

  desc "Seed Data Order Status"
  task seed_order_status: :environment do
    OrderStatus.delete_all
    OrderStatus.create! id: 1, name: "In Progress"
    OrderStatus.create! id: 2, name: "Placed"
    OrderStatus.create! id: 3, name: "Shipped"
    OrderStatus.create! id: 4, name: "Cancelled"
  end

  def data_any? instance
    if instance.any?
      instance.delete_all
    end
  end
end

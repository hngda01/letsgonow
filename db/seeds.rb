District.create!([
{name: "Hai Duong"},
{name: "Hung Yen"},
{name: "Ha Nam"},
{name: "Nam Dinh"},
{name: "Thai Binh"},
{name: "Hoa Binh"},
{name: "Quang Nam"},
{name: "Binh Duong"},
{name: "Long An"},
{name: "Ha Tay"},
{name: "Tuyen Quang"},
{name: "Cao Bang"},
])
District.create!([
{name: "Hai Duong"},
{name: "Hung Yen"},
{name: "Ha Nam"},
{name: "Nam Dinh"},
{name: "Thai Binh"},
{name: "Hoa Binh"},
{name: "Quang Nam"},
{name: "Binh Duong"},
{name: "Long An"},
{name: "Ha Tay"},
{name: "Tuyen Quang"},
{name: "Cao Bang"},
])
# Users
User.create!(name:  "Example User",
             email: "danghai@railstutorial.org",
             address: "Dong Da, Ha noi, Viet Nam",
             hobby: "xem phim, da bong",
             date_of_birth: "01-01-1998",
             phone_number: "0123456789",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  address = "Dong Da, Ha noi, Viet Nam"
  hobby = "xem phim, da bong"
  date_of_birth = "01-01-1998"
  phone_number = "0123456789"
  User.create!(name:  name,
               email: email,
               address: address,
               hobby: hobby,
               date_of_birth: date_of_birth,
               phone_number: phone_number,
               password:              password,
               password_confirmation: password)
end

# Microposts
Micropost.create!([{content: "What is the internet of things",
                                              title: "What is the internet of things",
                                              accept: true,
                                              district_id: 1,
                                              user_id: 1,
                                              picture: "s1.JPG"},
                                              {content: "What is the internet of things",
                                              title: "What is the internet of things",
                                              accept: true,
                                              district_id: 1,
                                              user_id: 1,
                                              picture: "s1.JPG"},
                                              {content: "What is the internet of things",
                                              title: "What is the internet of things",
                                              accept: true,
                                              district_id: 1,
                                              user_id: 1,
                                              picture: "s1.JPG"},
                                              {content: "What is the internet of things",
                                              title: "What is the internet of things",
                                              accept: true,
                                              district_id: 1,
                                              user_id: 1,
                                              picture: "s1.JPG"},
                                              {content: "What is the internet of things",
                                              title: "What is the internet of things",
                                              accept: true,
                                              district_id: 1,
                                              user_id: 1,
                                              picture: "s1.JPG"},
                                              {content: "What is the internet of things",
                                              title: "What is the internet of things",
                                              accept: true,
                                              district_id: 1,
                                              user_id: 1,
                                              picture: "s1.JPG"},
                                              {content: "What is the internet of things",
                                              title: "What is the internet of things",
                                              accept: true,
                                              district_id: 1,
                                              user_id: 1,
                                              picture: "s1.JPG"},
                                              {content: "What is the internet of things",
                                              title: "What is the internet of things",
                                              accept: true,
                                              district_id: 1,
                                              user_id: 1,
                                              picture: "s1.JPG"}

    ]) 

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

Like.create!([
{user_id: 1,micropost_id:1},
{user_id: 1,micropost_id:2},
{user_id: 1,micropost_id:3},
{user_id: 1,micropost_id:4},
{user_id: 1,micropost_id:5},
{user_id: 1,micropost_id:6},
{user_id: 1,micropost_id:7},
{user_id: 1,micropost_id:8}
])

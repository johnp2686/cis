user = User.new(email: 'admin@test.com', password: 'password', user_name: "Admin", first_name: "first name", 
  last_name:"last name", location:"BLR", dob:"12-12-1989", zip:"12345")
user.user_roles.build(role_id:"1")
user.save(:validate => false)

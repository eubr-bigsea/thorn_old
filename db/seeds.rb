# User.create(first_name: 'Matheus', last_name: 'Gonçalves', email: 'souzagonc@gmail.com', password: '123456')
user = User.find_by(email: 'admin@admin.com')
unless user
  password = ENV['ADMIN_PASSWORD'] || 123_456
  user = User.new(first_name: 'Admin', last_name: 'Admin', email: 'admin@admin.com', password: password)
  user.skip_confirmation_notification!
  user.save
  user.confirm
  user.add_role :admin
end

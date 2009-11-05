def ask(message)
  puts message + " "
  STDIN.gets.chomp
end

namespace :admin do
  
  desc "Create admin user"
  task :create => :environment do
    login = ask("Login:")
    password = ask("Password:")
    email = ask("E-mail:")

    user = User.new( :login => login, :password => password, :password_confirmation => password, :email => email )
    user.admin = true
    
    if user.save
      puts "Admin user is created"
    else
      puts "Could not create admin user...."
    end
  end

end
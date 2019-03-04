me = User.create(:username => "Tzviki123", :email => "4hbrody@gmail.com", :password => "Tzviki123")
me.resources << Resource.create(:name => "github", :link => "github.com", :icon => "/images/corneal-small.png", :rank => 9)
me.hardwares << Hardware.create(:name => "Airpods", :image1 => "/images/airpods.jpeg", :rank => 7)
my_setup = Setup.create(:name => "My Cool Pc", :image1 => "/images/cool-pc.jpg", :image2 => "/images/cool-pc-2.jpg", :image3 => "/images/cool-pc-3.jpg", :specs => "nvidia gt730, liquid cooling, led lighting", :rank => 10)
my_setup.hardwares << Hardware.create(:name => "nvidia730", :image1 => "/images/nvidia-730.jpg", :rank => 9)
me.setup = my_setup

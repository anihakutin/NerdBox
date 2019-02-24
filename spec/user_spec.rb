require 'pry'
describe 'User' do
  before do
    @user = User.create(:username => "test 123", :email => "test123@aol.com", :password => "test")
  end
  it 'can slug the username' do
    expect(@user.slug).to eq("test-123")
  end

  it 'can find a user based on the slug' do
    slug = @user.slug
    expect(User.find_by_slug(slug).username).to eq("test 123")
  end

  before do
    @resource = Resource.create(:name => "github", :link => "github.com", :icon => "../public/images", :rank => 10, :user_id => @user.id)
  end
  it 'can have resources' do
    expect(@resource).not_to be_nil
  end

  it 'resource belongs to user' do
    expect(@resource.user).to eq(@user)
  end

  before do
    @hardware = Hardware.create(:name => "github", :image1 => "../public/images", :link => "amazon.com", :rank => 10)
    @user.hardwares << @hardware
  end
  it 'can have hardware' do
    expect(@hardware).not_to be_nil
  end

  it 'hardware belongs to user' do
    expect(@hardware.hardwareable).to eq(@user)
  end

  before do
    @my_setup = Setup.create(:name => "My Cool Pc", :image1 => "./public/images/cool-pc.jpg", :image2 => "./public/images/cool-pc-2.jpg", :image3 => "./public/images/cool-pc-3.jpg", :specs => "nvidia gt730, liquid cooling, led lighting", :rank => 10)
    @my_setup.hardwares << Hardware.create(:name => "nvidia730", :image1 => "./public/images/nvidia-730.jpg", :rank => 9)
    @user.setup = @my_setup
  end
  it 'can have a setup' do
    expect(@my_setup).not_to be_nil
  end

  it 'setup belongs to a user' do
    expect(@my_setup.user).to eq(@user)
  end

  it 'setup can have hardware' do
    expect(@my_setup.hardwares.first.hardwareable).to eq(@my_setup)
  end

end

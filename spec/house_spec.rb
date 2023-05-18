require './lib/room'
require './lib/house'

RSpec.describe House do

  it "exists and has attributes" do
    house = House.new("$400000", "123 sugar lane")
    expect(house).to be_a House
    expect(house.price).to eq(400000)
    expect(house.address).to eq("123 sugar lane")
  end

  it "starts off with no rooms" do
    house = House.new("$400000", "123 sugar lane")  
    expect(house.rooms).to eq([])
  end

  it "can add rooms" do
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')    
    house.add_room(room_1)
    house.add_room(room_2)
    expect(house.rooms).to eq([room_1, room_2])
  end
  
  it "can check if above market average" do
    house = House.new("$400000", "123 sugar lane")
    expect(house.above_market_average?).to eq(false)  
  end

  it "can get rooms from category" do
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')    
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')
    house.add_room(room_1)
    house.add_room(room_2)    
    house.add_room(room_3)
    house.add_room(room_4)
    house.rooms_from_category(:bedroom)
    expect(house.rooms_from_category(:bedroom)).to eq([room_1, room_2])
    expect(house.rooms_from_category(:basement)).to eq([room_4])
  end

  it "can get area of all the rooms" do
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')    
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')
    house.add_room(room_1)
    house.add_room(room_2)    
    house.add_room(room_3)
    house.add_room(room_4)
    expect(house.area).to eq(1900)
  end

  it "can get details" do
    house = House.new("$400000", "123 sugar lane")
    expect(house.details).to eq({"price" => 400000, "address" => "123 sugar lane"})
  end

  it "can get price per square foot" do
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')
    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)
    expect(house.price_per_square_foot).to eq(210.53)
  end

  it "can get rooms sorted by area" do
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')
    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)
    expect(house.rooms_sorted_by_area).to eq([room_4, room_3, room_2, room_1])
  end

  it "can get rooms by category" do
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')
    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)
    expect(house.rooms_by_category).to eq({:bedroom=>[room_1, room_2], :living_room=> [room_3], :basement=> [room_4]})
  end
end

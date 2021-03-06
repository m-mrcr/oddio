require 'rails_helper'

RSpec.describe GoogleService, :vcr, type: :service do

  let(:service) { GoogleService.new }
  let(:landmarks) { TomTomService.category_search(categorySet: 7367).map {|landmark| landmark[:poi][:name]} }
  let(:expected) { ['ChIJP3JjmdR4bIcRQyfKKJGRt7s', 'ChIJb9SOIYGHa4cRnYWZfji6VLI'] }

  it 'exist' do
    expect(service).to be_a GoogleService
  end

  it '#get_place_id returns an array of place_id for landmarks generated by TomTomService' do
    results = landmarks.map do |landmark|
      service.get_place_id(landmark)
    end

    expect(results.class).to eq(Array)
    expect(results.first).to eq(expected[0])
    expect(results.second).to eq(expected[1])
  end

  it '::get_place_id returns an array of place_id for landmarks generated by TomTomService' do
    results = landmarks.map do |landmark|
      GoogleService.get_place_id(landmark)
    end

    expect(results.class).to eq(Array)
    expect(results.first).to eq(expected[0])
    expect(results.second).to eq(expected[1])
  end

  it '#get_details(id) returns landmarks details when given a place_id' do
    result = service.get_details(expected[0])

    expect(result).to have_key(:formatted_address)
    expect(result).to have_key(:formatted_phone_number)
    expect(result).to have_key(:geometry)
    expect(result).to have_key(:name)
    expect(result).to have_key(:website)
    expect(result[:place_id]).to eq(expected[0])
  end

  it '::get_details(id) returns landmarks details when given a place_id' do
    result = GoogleService.get_details(expected[0])

    expect(result).to have_key(:formatted_address)
    expect(result).to have_key(:formatted_phone_number)
    expect(result).to have_key(:geometry)
    expect(result).to have_key(:name)
    expect(result).to have_key(:website)
    expect(result[:place_id]).to eq(expected[0])
  end

  it '#get_picture(photo_reference) returns landmarks picture when given a photo reference' do
    expected = 'https://lh3.googleusercontent.com/p/AF1QipN1BHEE8SUqT85_qx3bjCIx4A2_92ND2eOqY8Oj=s1600-w800-h800'
    result = service.get_picture('CmRaAAAAh3TTyv0vzjZK0qEPpt2xfhu6io4RbhO89xLi2cHuj2coXNI_WyHqWI5Fsexwru9pEYVzLIEk2CYI3QFTxQPLM9kVa0T4fWnFRLuM5x84UnMBGq7wh4PSqCYqyg-rpC7bEhC3IgCuLlxpwn39FrLUM29LGhQS2dGxHj9KLeP_kGglXr5WFCBA7Q')

    expect(result).to eq(expected)
  end
end

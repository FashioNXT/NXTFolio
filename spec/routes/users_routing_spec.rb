# spec/routing/users_routing_spec.rb
require 'rails_helper'

RSpec.describe 'Users Routing', type: :routing do
  # Test routes for sign-up
  it 'routes GET /sign_up to login_info#new' do
    expect(get: '/sign_up').to route_to(controller: 'login_info', action: 'new')
  end

  it 'routes POST /sign_up to login_info#create' do
    expect(post: '/sign_up').to route_to(controller: 'login_info', action: 'create')
  end

  # Test routes for sign-in
  it 'routes GET /sign_in to devise/sessions#new' do
    expect(get: '/sign_in').to route_to(controller: 'devise/sessions', action: 'new')
  end

  it 'routes POST /sign_in to devise/sessions#create' do
    expect(post: '/sign_in').to route_to(controller: 'devise/sessions', action: 'create')
  end

  # Test routes for sign-out
  it 'routes GET /sign_out to devise/sessions#destroy' do
    expect(get: '/sign_out').to route_to(controller: 'devise/sessions', action: 'destroy')
  end

  # Test routes for email confirmation
  it 'routes GET /users/confirmation to devise/confirmations#show' do
    expect(get: '/users/confirmation').to route_to(controller: 'devise/confirmations', action: 'show')
  end

  it 'routes POST /users/confirmation to devise/confirmations#create' do
    expect(post: '/users/confirmation').to route_to(controller: 'devise/confirmations', action: 'create')
  end
end

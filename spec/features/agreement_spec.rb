require 'rails_helper'

RSpec.feature 'create a location', type: :feature do
  fixtures :users
  let(:user) { users(:user) }

  before :each do
    visit "/"
    sign_in user

    @agreement = Agreement.new(title: 'Rules', content:'Content')
    @agreement.save!
  end

  scenario 'SHOW' do
    visit agreements_path
    click_link 'Show'

    expect(page).to have_content('Rules')
    expect(page).to have_content('Content')
  end

  scenario 'EDIT when name is NOT given' do
    visit edit_agreement_path(@agreement.id)

    fill_in 'Title', with: nil
    click_on 'Update Agreement'

    expect(page).to have_content("Title can't be blank")
  end

  scenario 'EDIT when all expected information is given' do
    visit edit_agreement_path(@agreement.id)

    fill_in 'Title', with: 'Fake agreement'
    fill_in 'Content', with: 'Content of Fake agreement'
    click_on 'Update Agreement'

    expect(page).to have_content('agreement was successfully updated.')
    expect(page).to have_content('Fake agreement')
    expect(page).to have_content('Content of Fake agreement')
  end

  scenario 'DESTROY when delete button is clicked' do
    visit agreements_path
    click_link 'Destroy'
  
    expect(page).to have_content('agreement was successfully destroyed.')
  end

  scenario 'CREATE when title is NOT given' do
    visit agreements_path

    click_link('New Agreement')
    fill_in 'Title', with: nil
    fill_in 'Content', with: 'Content of Fake Agreement'
    click_on 'Create Agreement'

    expect(page).to have_content("Title can't be blank")
  end

  scenario 'CREATE when all expected information is given' do
    visit agreements_path

    click_link('New Agreement')
    fill_in 'Title', with: 'Fake Agreement'
    fill_in 'Content', with: 'Content of Fake Agreement'
    click_on 'Create Agreement'

    expect(page).to have_content('Agreement was successfully created.')
  end

end
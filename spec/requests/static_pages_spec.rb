require 'spec_helper'

describe "Static pages" do
  subject { page }

  shared_examples_for "all static pages" do
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    let(:page_title) { '' }

    before { visit root_path }

    it { should have_title('neodesign') }
    it { should_not have_title('| Home') }
    it { should_not have_selector('h1')}

    describe "Logo" do

      it { should have_selector('img') }
      it { should have_link('Logo Neodesign', href: root_path) }
    end
  end

  describe "About page" do
    let(:page_title) { 'O nas' }
    
    before { visit neodesign_path }

    it { should_not have_title('| About') }
    it { should have_css('div#boss') }
    it { should have_css('div#organization') }
    it { should have_css('div#people_wrapper') }
    it { should have_link("neodesign@neodesign.wroc.pl",
                          href: "mailto:neodesign@neodesign.wroc.pl") }
  end

  describe "Contact page" do
    let(:page_title) { 'Kontakt' }
    
    before { visit contact_path }

    it { should_not have_title('| Contact') }
    it { should have_content('contact') }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Neodesign"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "sample app"
    expect(page).to have_title(full_title(''))
  end
end

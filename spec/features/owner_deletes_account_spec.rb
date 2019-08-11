feature "Delete Account" do
  let(:subdomain) { generate(:subdomain) }
  let(:owner) { build(:user) }

  before(:each) do
    create(:account_with_schema, subdomain: subdomain, owner: owner)
  end

  context "as the owner of an account" do
    scenario "has a menu item to edit account" do
      sign_in_user(owner, subdomain: subdomain)

      within ".nav-user" do
        expect(page).to have_content "Edit Account"
      end
    end
  end

  context "as a regular user of an account" do
    before(:each) do
      Apartment::Tenant.switch(subdomain)

      user = create(:user)
      sign_in_user(user, subdomain: subdomain)
    end

    scenario "the account cannot be deleted" do
      expect {
        visit edit_account_url(subdomain: subdomain)
      }.to raise_error ActiveRecord::RecordNotFound
    end

    scenario "does not have a menu item to edit account" do
      within ".nav-user" do
        expect(page).to have_no_content "Edit Account"
      end
    end
  end
end

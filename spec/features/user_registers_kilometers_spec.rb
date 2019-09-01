feature "User registers kilometers" do
  let(:user) { build(:user) }
  let(:subdomain) { generate(:subdomain) }
  let(:capp11) { build(:project, name: "CAPP11") }
  let(:conversations) { build(:project, name: "Conversations") }

  before(:each) do
    create(:account_with_schema, subdomain: subdomain, owner: user)
    sign_in_user(user, subdomain: subdomain)
    capp11.save
    conversations.save

    visit root_url(subdomain: subdomain)
  end

  context "with valid data" do
    scenario "full data" do
      within "#mileages-tab" do
        select capp11.name, from: I18n.t("entries.index.project")
        fill_in (I18n.t("entries.index.mileages")), with: 20
        fill_in "mileage_date", with: "17/02/2015"

        click_button (I18n.t("helpers.submit.create"))
      end
      expect(page).to have_content(I18n.t("entry_created.mileages"))
    end
  end

  context "with invalid data" do
    scenario "blank text" do
      within "#mileages-tab" do
        select capp11.name, from: I18n.t("entries.index.project")
        fill_in (I18n.t("entries.index.mileages")), with: ""
        fill_in "mileage_date", with: "17/02/2015"

        click_button (I18n.t("helpers.submit.create"))
      end
      expect(page).to have_content(
        I18n.t("activerecord.attributes.mileage.value") + " can't be blank. " +
        I18n.t("activerecord.attributes.mileage.value") + " is not a number")
    end
  end
end

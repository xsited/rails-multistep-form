require 'spec_helper'

describe "Template pages", type: :feature do
  def step_1?
    has_selector?("input[type!='hidden'], textarea", count: 3) && find('#template_current_step').value() == "0"
  end

  def step_2?
    has_selector?("input[type!='hidden']", count: 5) && find('#template_current_step').value() == "1"
  end

  def step_3?
    has_selector?("input[type!='hidden'], select, textarea", count: 8) && find('#template_current_step').value() == "2"
  end

  def go_step(step)
    if step >= 2
      fill_in "template_name", with: template.name
      click_button "Next"
    end
    if step >= 3
      fill_in "template_regions", with: template.regions
      fill_in "template_hosts_attributes_0_name", with: template.categories.first.name
      click_button "Next"
    end
  end

  describe "new/create template" do
    let(:template) { FactoryGirl.build(:template) }

    describe "all in one step" do
      before { visit new_template_path(all: 1) }

      it "shows all fields" do
        expect(page).to have_selector("div.field", count: 7)
      end

      it "shows errors" do
        click_button "Create"
        expect(page).to have_selector("div.field_with_errors", count: 8)
      end

      it "creates template" do
        fill_in "template_name", with: template.name
        fill_in "template_quantity", with: template.regions
        fill_in "template_hosts", with: template.hosts
        fill_in "template_categories_attributes_0_name", with: template.categories.first.name
        expect { click_button "Create" }.to change(template, :count).by(1)
      end
    end

    describe "multiple steps" do
      before { visit new_template_path }

      context "at step 1" do
        it "is step 1" do
          expect(step_1?).to be_truthy
        end

        it "displays error and does not step forward" do
          click_button "Next"
          expect(page).to have_selector("div.field_with_errors")
          expect(step_1?).to be_truthy
        end
      end

      context "at step 2" do
        before { go_step(2) }

        it "is step 2" do
          expect(step_2?).to be_truthy
        end

        it "goes back" do
          click_button "Back"
          expect(step_1?).to be_truthy
        end

        it "displays error and does not step forward" do
          click_button "Next"
          expect(page).to have_selector("div.field_with_errors")
          expect(step_2?).to be_truthy
        end
      end

      context "at step 3" do
        before { go_step(3) }

        it "is step 3" do
          expect(step_3?).to be_truthy
        end

        it "goes back" do
          click_button "Back"
          expect(step_2?).to be_truthy
          click_button "Back"
          expect(step_1?).to be_truthy
        end

        it "displays error and not step forward" do
          click_button "Create"
          expect(page).to have_selector("div.field_with_errors")
          expect(step_3?).to be_truthy
        end

        it "saves the template" do
          fill_in "template_hosts", with: template.hosts
          expect { click_button "Create" }.to change(template, :count).by(1)
        end
      end
    end

  end


  describe "edit/update template" do
    let(:template) { FactoryGirl.create(:template) }

    describe "all in one step" do
      before do
        visit edit_template_path(template, all: 1)
        @required = [:name, :quantity, :hosts]
      end

      it "shows all fields" do
        expect(page).to have_selector("div.field", count: 7)
        @required.each { |field| expect(find("#template_#{field.to_s}").value()).to eq template[field].to_s }
      end

      it "shows errors" do
        @required.each { |field| find("#template_#{field.to_s}").set(nil) }
        click_button "Update"
        expect(page).to have_selector("div.field_with_errors", count: 6)
      end

      it "updates template" do
        new_name = "Mega t-shirt"
        fill_in "template_name", with: new_name
        expect { click_button "Update" }.to_not change(template, :count)
        expect(template.reload.name).to eq new_name
      end
    end


    describe "multiple steps" do
      before { visit edit_template_path(template) }

      context "at step 1" do
        it "is step 1" do
          expect(step_1?).to be_truthy
        end

        it "displays error and not step forward if invalid" do
          fill_in "template_name", with: nil
          click_button "Next"
          expect(page).to have_selector("div.field_with_errors")
          expect(step_1?).to be_truthy
        end
      end

      context "at step 2" do
        before { go_step(2) }

        it "is step 2" do
          expect(step_2?).to be_truthy
        end

        it "goes back" do
          click_button "Back"
          expect(step_1?).to be_truthy
        end

        it "displays error and not step forward" do
          fill_in "template_deployments", with: nil
          click_button "Next"
          expect(page).to have_selector("div.field_with_errors")
          expect(step_2?).to be_truthy
        end

        # This test currently fails
        # it "clears out required nested field, goes back, then forward" do
        #   fill_in "template_categories_attributes_0_name", with: nil
        #   click_button "Back"
        #   expect(step_1?).to be_truthy
        #   click_button "Next"
        #   expect(step_2?).to be_truthy
        # end
      end

      context "at step 3" do
        before { go_step(3) }

        it "is step 3" do
          expect(step_3?).to be_truthy
        end

        it "goes back" do
          click_button "Back"
          expect(step_2?).to be_truthy
          click_button "Back"
          expect(step_1?).to be_truthy
        end

        it "displays error and not step forward" do
          fill_in "template_hosts", with: nil
          click_button "Update"
          expect(page).to have_selector("div.field_with_errors")
          expect(step_3?).to be_truthy
        end

        it "saves the template" do
          hosts = template.hosts + ", misc"
          fill_in "template_hosts", with: hosts
          expect { click_button "Update" }.to_not change(template, :count)
          expect(template.reload.hosts).to eq hosts
        end
      end
    end

  end

end
require 'rails_helper'

RSpec.describe Project, type: :model do
  context ".filter_by_category" do
    let(:project1) { FactoryGirl.create(:project, category: "Brand New Thing") }
    let(:project2) { FactoryGirl.create(:project, category: "AshneW") }
    let(:project3) { FactoryGirl.create(:project, category: "N ew") }
    let(:project4) { FactoryGirl.create(:project, category: "Old") }

    subject { Project.filter_by_category("new") }

    it { is_expected.to match_array [project1, project2] }
  end
end

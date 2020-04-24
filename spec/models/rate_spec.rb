require 'spec_helper'

describe Rate do
  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :project }
  end
end

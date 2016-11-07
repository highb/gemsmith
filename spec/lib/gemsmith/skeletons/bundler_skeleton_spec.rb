# frozen_string_literal: true

require "spec_helper"

RSpec.describe Gemsmith::Skeletons::BundlerSkeleton, :temp_dir do
  let(:cli) { instance_spy Gemsmith::CLI, destination_root: temp_dir }
  let(:configuration) { {gem: {name: "tester"}} }
  subject { described_class.new cli, configuration: configuration }
  before { allow(subject).to receive(:`) }

  describe "#create" do
    before { subject.create }

    it "prints gem dependencies are being installed" do
      expect(cli).to have_received(:info).with("Installing gem dependencies...")
    end

    it "creates Gemfile.lock" do
      expect(subject).to have_received(:`).with("bundle install")
    end
  end
end

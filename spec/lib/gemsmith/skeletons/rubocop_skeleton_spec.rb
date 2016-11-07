# frozen_string_literal: true

require "spec_helper"

RSpec.describe Gemsmith::Skeletons::RubocopSkeleton, :temp_dir do
  let(:cli) { instance_spy Gemsmith::CLI, destination_root: temp_dir }
  let(:configuration) { {gem: {name: "tester"}, create: {rubocop: create_rubocop}} }
  subject { described_class.new cli, configuration: configuration }

  describe "#create" do
    before { subject.create }

    context "when enabled" do
      let(:create_rubocop) { true }

      it "creates configuration file" do
        expect(cli).to have_received(:template).with("%gem_name%/.rubocop.yml.tt", configuration)
      end

      it "creates Rake file" do
        template = "%gem_name%/lib/tasks/rubocop.rake.tt"
        expect(cli).to have_received(:template).with(template, configuration)
      end

      it "runs rubocop" do
        expect(cli).to have_received(:run).with("rubocop --auto-correct > /dev/null")
      end
    end

    context "when disabled" do
      let(:create_rubocop) { false }

      it "does not create configuration file" do
        expect(cli).to_not have_received(:template)
      end
    end
  end
end

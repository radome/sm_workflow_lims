require 'spec_helper'
require './app/presenters/asset/asset'

describe Presenter::AssetPresenter::Asset do

  shared_examples "shared behaviour" do
    let(:mock_type) { double('mock_type',name:'Type',identifier_type:'id',variable_samples:true)}
    let(:mock_workflow)  { double('mock_wf',  name:'Work',has_comment:true)}
    let(:date) { DateTime.parse('01-02-2012 13:15') }
    let(:comment) { double('comment',:comment=>'A comment')}

    let(:presenter) { Presenter::AssetPresenter::Asset.new(asset)}


    it "should return the identifier type for identifier_type" do
      presenter.identifier_type.should eq('id')
    end

    it "should return the identifier for identifier" do
      presenter.identifier.should eq('asset_1')
    end

    it "should return the sample count for sample_count" do
      presenter.sample_count.should eq(2)
    end

    it "should return the study_name for study" do
      presenter.study.should eq('study')
    end

    it "should return the workflow for workflow" do
      presenter.workflow.should eq('Work')
    end

    it "should return the created at time as a formatted string for created_at" do
      presenter.created_at.should eq('01/02/2012')
    end
  end

  context "with an asset with comments" do
    let(:asset) { double('asset',identifier:'asset_1',asset_type:mock_type,workflow:mock_workflow,study:'study',sample_count:2,created_at:date,comment:comment) }

    include_examples "shared behaviour"

    it "should return the comment for comments" do
      presenter.comments.should eq('A comment')
    end
  end

  context "with an asset without comments" do
    let(:asset) { double('asset',identifier:'asset_1',asset_type:mock_type,workflow:mock_workflow,study:'study',sample_count:2,created_at:date,comment:nil) }

    include_examples "shared behaviour"

    it "should return an empty string for comments"do
      presenter.comments.should eq('')
    end
  end

  context "an unfinished asset" do
    let(:asset) { double('asset',identifier:'asset_1',asset_type:mock_type,workflow:mock_workflow,study:'study',sample_count:2,created_at:date,completed_at:nil) }

    include_examples "shared behaviour"
    it "should return 'in progress' for completed_at" do
      presenter.completed_at.should eq('in progress')
    end
  end

  context "an unfinished asset" do
    let(:asset) { double('asset',identifier:'asset_1',asset_type:mock_type,workflow:mock_workflow,study:'study',sample_count:2,created_at:date,completed_at:date) }

    include_examples "shared behaviour"
    it "should return 'in progress' for completed_at" do
      presenter.completed_at.should eq('01/02/2012')
    end
  end

end
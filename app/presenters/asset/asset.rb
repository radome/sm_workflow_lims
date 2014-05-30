require './app/presenters/presenter'

module Presenter::AssetPresenter
  class Asset < Presenter

    attr_reader :asset

    def initialize(asset)
      @asset = asset
    end

    def identifier_type
      asset.asset_type.identifier_type
    end

    def identifier
      asset.identifier
    end

    def sample_count
      asset.sample_count
    end

    def study
      asset.study
    end

    def workflow
      asset.workflow.name
    end

    def created_at
      asset.created_at.strftime('%d/%m/%Y')
    end

    def comments
      return asset.comment.comment if asset.comment
      ''
    end

    def completed_at
      return asset.completed_at.strftime('%d/%m/%Y') if asset.completed_at
      'in progress'
    end

  end
end
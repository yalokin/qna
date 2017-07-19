module Attachable
  extend ActiveSupport::Concern

  included do
    has_many :attachments, as: :attachable
    accepts_nested_attributes_for :attachments, reject_if: :all_blank
  end
end
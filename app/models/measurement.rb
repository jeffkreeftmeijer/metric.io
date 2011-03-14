class Measurement < ActiveRecord::Base
  belongs_to :site

  after_save :push_changes

  def push_changes
    Pusher['measurements'].trigger('measurement-saved', attributes)
  end
end

module RollbackLogger
  extend ActiveSupport::Concern

  included do
    after_rollback :log_status, on: [:create, :update]
  end

  def log_status
    Rails.logger.info "Rollback caused by: #{self.errors.full_messages}"
  end
end

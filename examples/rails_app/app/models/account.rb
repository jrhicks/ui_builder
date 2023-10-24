class Account < ApplicationRecord
  enum status: [:active, :inactive]
end

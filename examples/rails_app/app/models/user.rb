class User < ApplicationRecord
  belongs_to :account
  enum role: [:admin, :manager, :employee]
end

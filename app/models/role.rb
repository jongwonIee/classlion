class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles

  belongs_to :resource,
             :polymorphic => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify


  # # 평가
  # def self.evaluator
  #   user = User.find(params[:id])
  #   user.add_role 'evaluator'
  # end
  #
  # # 위키
  # def self.wikier
  #   user = User.find(params[:id])
  #   user.add_role 'wikier'
  # end
end

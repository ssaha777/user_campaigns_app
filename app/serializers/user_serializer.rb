class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :campaigns_list, :created_at, :updated_at
end

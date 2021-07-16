class Character < ApplicationRecord

  enum category: { '麦わらの一味': 0, '海賊1': 1, '海賊2': 2, '海軍': 3, 'その他': 4, 'DLC': 5}
  enum action_type: { 'パワー': 0, 'スピード': 1, 'テクニック': 2, 'スカイ': 3}

  has_many :scores

end

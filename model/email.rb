class Email < ActiveRecord::Base
  validates_presence_of :email  
  validates_format_of :email,:with => /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i
end


User.create!(email: 's_user@mail.me',  login: 's_user',  password: '12345678', password_confirmation: '12345678', audit_comment: audit_text)
User.create!(email: 's_moder@mail.me', login: 's_moder', password: '12345678', password_confirmation: '12345678', role: 'moderator', audit_comment: audit_text)
User.create!(email: 's_admin@mail.me', login: 's_admin', password: '12345678', password_confirmation: '12345678', role: 'admin', audit_comment: audit_text)

author = User.first

end
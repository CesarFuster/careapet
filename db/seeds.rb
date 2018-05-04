Task.destroy_all
User.destroy_all
UserTask.destroy_all
Service.destroy_all
Pet.destroy_all


puts "Tasks..."
Task.create(name: "Companhia")
Task.create(name: "Passear")
Task.create(name: "Levar ao PetShop")
Task.create(name: "Levar ao Veterinário")
Task.create(name: "Adestrar")
Task.create(name: "Pernoite")

puts "2 Usuários caregiver: true"
u1 = User.create(first_name: "caregiver1", last_name: "caregiver1", address: "Rua Mourato Coelho, 1404 - Pinheiros, São Paulo", email: "caregiver1@caregiver1.com", phone_number: "9999-9999", caregiver: true, password: '123456', password_confirmation: '123456')
u2 = User.create(first_name: "caregiver2", last_name: "caregiver2", address: "Rua Domingos de Morais, 2450 - Vila Mariana", email: "caregiver2@caregiver2.com", caregiver: true, password: '123456', password_confirmation: '123456')

puts "3 user_tasks caregiver 1"
ust1 = UserTask.create(task_id: 5, user_id: 1, price: 100)
ust2 = UserTask.create(task_id: 6, user_id: 1, price: 50)
ust3 = UserTask.create(task_id: 2, user_id: 1, price: 100)

puts "1 user_tasks caregiver 2"
ust4 = UserTask.create(task_id: 5, user_id: 2, price: 90)

puts "3 Usuários caregiver: false, todos compradores"
u3 = User.create(first_name: "teste", last_name: "teste", address: "Rua Coronel Oscar Porto, 70 - Paraíso, São Paulo", email: "teste@teste.com", phone_number: "9999-9999", caregiver: false, password: '123456', password_confirmation: '123456')
u4 = User.create(first_name: "César", last_name: "Fuster", address: "Rua Nanuque, 115 - Vila Leopoldina, São Paulo", email: "cesar@cesar.com", phone_number: "9999-9999", caregiver: false, password: '123456', password_confirmation: '123456')
u5 = User.create(first_name: "teste2", last_name: "teste2", address: "Avenida Paulista, 900 - Bela Vista, São Paulo", email: "teste2@teste2.com", phone_number: "9999-9999", caregiver: false, password: '123456', password_confirmation: '123456')








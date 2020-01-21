john = User.create(username: "John", password:"password")
fnd = Goal.create(job: "Front End Dev", description: "Work with a team building apps!!")
wb = Goal.create(job: "Web Devys", description: "Build web apps with a team!!")

fnd.user_id = john.id
wb.user_id = john.id
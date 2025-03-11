resource random_pet  username {}
resource random_password  password {
    length=8
}

output username {
    value = random_pet.username.id
}

output password {
    value = random_password.password.id
    sensitive = true
}
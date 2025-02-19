variable some_var {}

resource random_pet  module3 {}

output module1_pet {
    value = random_pet.module1.id
}

output pet1 {
    value = var.some_var
}

output pet3 {
    value = random_pet.module3.id
}
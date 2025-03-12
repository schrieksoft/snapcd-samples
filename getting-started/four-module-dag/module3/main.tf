variable some_var {}

resource random_pet  module3 {}

output pet1 {
    value = var.some_var
}

output pet3 {
    value = random_pet.module3.id
}
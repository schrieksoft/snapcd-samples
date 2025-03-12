resource random_pet  module1 {}

output module1_pet {
    value = random_pet.module1.id
}
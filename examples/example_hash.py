import hashlib

def calc_hash(text):
    return hashlib.sha256(text.encode('utf-8')).hexdigest()


transaccion1 = "He minado 50 bitcoin\n"
hash1=calc_hash(transaccion1)
transaccion1 += "Hash: " + hash1

print("1")
print(transaccion1)

transaccion2 = "He pagado 25 bitcoin a Ana\n"
transaccion2 += "Juan me ha pagado 1000000 bitcoin\n"
transaccion2 += "Hash anterior: " + hash1 + "\n"
hash2=calc_hash(transaccion2)
transaccion2 += "Hash: " + hash2

print("2")
print(transaccion2)

transaccion3 = "He pagado 2 bitcoin a Pepe\n"
transaccion3 += "He pagado 1 bitcoin a Luisa\n"
transaccion3 += "Hash anterior: " + hash2 + "\n"
hash3=calc_hash(transaccion3)
transaccion3 += "Hash: " + hash3

print("3")
print(transaccion3)


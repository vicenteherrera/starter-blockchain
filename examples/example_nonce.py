import hashlib
import random
import math
def calc_hash(text):
    return hashlib.sha256(text.encode('utf-8')).hexdigest()
i=0
digitos=""
while digitos!="000000":
    num = math.floor(random.random()*100000000)
    transaccion1 = "He minado 50 bitcoin\n"
    transaccion1 = transaccion1 + "nonce:"+str(num)
    hash1=calc_hash(transaccion1)
    digitos=hash1[0:6]
    # print(str(digitos))
    i=i+1

print(transaccion1)
print("Hash: " + hash1)
print("Digito: " + digitos)
print("Iteraciones: "+ str(i))

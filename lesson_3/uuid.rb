def rnd_4_hex(rand_generator)
  s = "0000" + rand_generator.rand(2**16).to_s(16)
  s[-4, 4]
end

def make_uuid
  prng = Random.new
  rnd_4_hex(prng) + rnd_4_hex(prng) + "-" + rnd_4_hex(prng) + "-" +
    rnd_4_hex(prng) + "-" + rnd_4_hex(prng) + "-" +
    rnd_4_hex(prng) + rnd_4_hex(prng) + rnd_4_hex(prng)
end

def make_uuid2
  s = random_hex(32)
  s[0, 8] + "-" + s[8, 4] + "-" + s[12, 4] + "-" + s[16, 4] + "-" + s[20, 12]
end

def random_hex(length)
  rnd = Random.new.rand(16**length)
  s = "0" * length + rnd.to_s(16)
  s[-length, length]
end

p make_uuid
p make_uuid2

import json
with open("./spec.json", "r") as f1:
    file1 = json.loads(f1.read())
with open("../../HLS_FABulous/FABulous/fabric_generator/spec.json", "r") as f2:
    file2 = json.loads(f2.read())


a = [i for i, _ in file1["TileSpecs"]["X6Y0"].items()]
b = [i for i, _ in file2["TileSpecs"]["X6Y0"].items()]

print(set(a) ^ set(b))

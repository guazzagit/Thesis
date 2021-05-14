import json

# Divide in 3 resolver type
with open('DnsMeasures.txt', 'r') as json_file, open('InternalDNS.txt', 'w') as outfile1, open('DHCpDNS.txt', 'w') as outfile2, open('ExternalDNS.txt', 'w') as outfile3:
    for line in json_file:
        decoded = json.loads(line)
        # if true use resolver is inside the probe resolve_on_probe e use_probe_resolver sono a true
        if decoded["resolve_on_probe"] == 1:
            outfile1.write(json.dumps(decoded))
            outfile1.write('\n')
        # dhcp resolve
        if decoded["resolve_on_probe"] == 0 and "use_probe_resolver" in decoded and decoded["use_probe_resolver"] == 1:
            outfile2.write(json.dumps(decoded))
            outfile2.write('\n')
        # ext server dns resolve
        if decoded["resolve_on_probe"] == 0 and "use_probe_resolver" not in decoded :
            outfile3.write(json.dumps(decoded))
            outfile3.write('\n')
            # print(decoded["resolve_on_probe"])

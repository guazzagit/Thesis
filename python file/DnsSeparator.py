import json
import sys

Input_1 = sys.argv[1]
Output_1 = sys.argv[2] # internal dns
Output_2 = sys.argv[3] # dhcp dns
Output_3 = sys.argv[4] # external dns


# Divide in 3 resolver type
with open(Input_1, 'r') as json_file, open(Output_1, 'w') as outfile1, open(Output_2, 'w') as outfile2, open(Output_3, 'w') as outfile3:
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

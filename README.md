# Thesis: Impact of the COVID-19 pandemic on DNS performance: a two-year study
This thesis aimed to study the performance of DNS systems for the years 2019 and
2020 on several measurements collected by RIPE Atlas. This repository contains all the scripts used to reproduce the results and some .csv files needed for their operation.


Scripts:

**PreprocessingDNS**: Takes as input InputfileDNS 2019, Outputfile2019, InputfileDNS 2020, Outputfile2020.returns as output all files for analysis in particular the results file with only the probes active for at least 80% of the time.

**PreprocessingDNS_NSID**: Like the previous one, but returns files with additional information about the NSID field if it is present.

**PreprocessingPING**: Takes as input InputfilePING 2019, Outputfile2019, InputfilePING 2020, Outputfile2020.returns as output all files for analysis in particular the results file with only the probes active for at least 80% of the time.

**PreprocessingDHCP**: Takes as input InputfileDHCP 2019, Outputfile2019, InputfileDHCP 2020, Outputfile2020.returns as output all files for analysis in particular the results file with only the probes active for at least 80% of the time.

**ResponseTimeFixedResolver**: Takes input file2019DNSpreprocessed, nations-prb_id matching file2019, file2020DNSpreprocessed, nations-prb_id matching file 2020. Returns all median, 90th percentile and error plots as output. 

**PreprocessingDNS_NSID**: Like the previous one, but returns in addition comparative response time NSID graphs as output.

**RTTPING**: Takes input file2019preprocessed of PING measurement, nations-prb_id matching file2019, file2020preprocessed of PING measurement, nations-prb_id matching file 2020. Returns all median, 90th percentile and error plots as output. 

**ResponseTimeDHCP**: Takes input file2019DHCPpreprocessed, nations-prb_id matching file2019, file2020DHCPpreprocessed, nations-prb_id matching file 2020. Returns all median, 90th percentile and error plots as output. In addition returns the graphs of the 3 time slots analized (00-08,08-16,16-00).

**Anomaly**: Takes as input the two files 2019 and 2020 in csv of the measurement with DHCP and returns the graphs per AS of the anomaly detection

**ChangePoints**: It takes in the 2019 DHCP preprocessed file and the 2020 DHCP preprocessed file. Returns graphs showing where the mean varies most significantly.

**AfricaEuropa**: It takes in the 2019 DHCP preprocessed file and the 2019 DHCP preprocessed file, both with ASN and country information. Outputs median and 90 percentile graphs for each continent and graphs with three time slots separation.

**ISPPublicComparison**: It takes in the DHCP 2019 preprocessed file and the DHCP 2019 preprocessed file, both with information on the type and ASN of the recipient address. Returns as output, graphs of AS divided by ISP, public DNS and with individual provider split for public AS.

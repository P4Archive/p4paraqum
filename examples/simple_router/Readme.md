First change env.sh to give paths for p4cbm and behavioral-model

Generate json
./compile_bmv2.sh

Before this step change the path for the default arguments to give json and the behavioral-model
cd mininet
sudo python ./1sw_demo.py

(In a different terminal, going back one step)
./send_cmd.sh

Then try to ping using
mininet> h1 ping h2

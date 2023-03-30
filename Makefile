.PHONY: clean all


all: 
	./RunPackageIP.py
	./RunMakeImage.py
	./PushFiles.py

run:
	# This is a home automation script 
	# Obviously in real life I would do something more involved. 
	/opt/Jenkins/Local/RunRemote.py xilinx "cd AXIMasterStreamTutorial; ./RecvStream.py" 

clean:
	rm -rf project_1 FPGAImageProject 

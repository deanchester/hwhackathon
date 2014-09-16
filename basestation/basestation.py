from nrf24 import NRF24
import time
import requests, json
import datetime

url = "http://136.206.54.207:8084/red-sky-web/input/sensor"

def push_data_to_db(data):
	id = (data[0] << 8) | (data[1])
	timestamp = datetime.datetime.now()
	temp = (data[2] << 8) | (data[3])
	x = = (data[4] << 8) | (data[5])
	y = = (data[6] << 8) | (data[7])
	z = = (data[8] << 8) | (data[])
	# prepared_data = json.dumps({ 'dateTime': timestamp.strftime('%Y-%m-%dT%H:%M:%S'), 'accelerometerX': x, 'accelerometerY': y, 'accelerometerZ': z, 'animals':[{}'farm':{'id':1, 'name':"dean"}}]})

	prepared_data = json.dumps({ 'id':{'id':id,'dateTime': timestamp.strftime('%Y-%m-%dT%H:%M:%S') }, 'accelerometerX': x, 'accelerometerY': y, 'accelerometerZ': z})
	print(prepared_data)
	r = requests.post(url, data=prepared_data, headers={'mime-type': 'application/json', 'content-type': 'application/json'})
	print(r.status_code)
	print(r.text)


pipes = [[0xe7, 0xe7, 0xe7, 0xe7, 0xe7], [0xc2, 0xc2, 0xc2, 0xc2, 0xc2]]

radio = NRF24()
radio.begin(1, 0, "P8_23", "P8_24")

radio.setRetries(15,15)

radio.setPayloadSize(8)
radio.setChannel(0x60)
radio.setDataRate(NRF24.BR_250KBPS)
radio.setPALevel(NRF24.PA_MAX)

radio.setAutoAck(1)

radio.openWritingPipe(pipes[1])
radio.openReadingPipe(1, pipes[0])

radio.startListening()
radio.stopListening()

radio.printDetails()

radio.startListening()


while(True):
    #Wait for data
    pipe =[0]
    while not radio.available(pipe):
        time.sleep(10000/1000000.0)
    
    #Receive Data
    recv_buffer = []
    radio.read(recv_buffer)
    
    #Print the buffer
    print(' '.join('0x%02x' % b for b in recv_buffer))
    
    radio.stopListening()
    radio.write(recv_buffer)
    print("ACK Sent")
	push_data_to_db(recv_buffer)
    radio.startListening()
    
    
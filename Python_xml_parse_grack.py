import re
import xml.etree.ElementTree as ET
tree = ET.parse('config.xml')
root = tree.getroot()

print(root.tag)
print(root.attrib)

for child in root:
	print(child.tag, child.attrib)

print("___________________")

print(root[0].text)
for i in root.iter('time'):
	print("Timezone", i.find('timezone').text)
	print("NTP Enabled :",i[1][0].text)
	print("NTP :", i[1][1].text)

#print("Timezone :", root[1][3][0].text)

#print("Time Server Enabled(?) :", root[1][3][1][0].text)
#print("Time Server :", root[1][3][1][1].text)

print("Email Enabled(?):", root[1][4][0].text)
print("Email Server:", root[1][4][1].text)
print("Primary Email:", root[1][4][6].text)
print("Secondary Email:", root[1][4][7].text)
#Network
print("___________________")
print("Network: Hostname", root[1][7][0].text)
print("Network: Domainname", root[1][7][1].text)
print("___________________")

'''
#Network > Interface root[1][7][2]
print("Network: Interface", root[1][7][2][0][1].text)
print("Network: Method", root[1][7][2][0][2].text)
print("Network: IP Addr", root[1][7][2][0][3].text)
print("Network: Netmask", root[1][7][2][0][4].text)
print("Network: Gateway", root[1][7][2][0][5].text)
print("Network: Dns Server", root[1][7][2][0][10].text)
print("___________________")

'''

print(root[1][7][2].tag)
print(root[1][7][2].attrib)

print("Listing interfaces")
print("Total interfaces: ",len(root[1][7][2].findall('interface')))

'''
print(" List by looping")
for interface in root[1][7][2].findall('interface'):
	dev=interface.find('devicename').text
	print(dev)
'''
#Using Iter :	
print("Use iter (a cleaner way)")
for i in root.iter('interface'):
	print(i.find('devicename').text)
'''
# using loop and index
for i in range(len(root[1][7][2].findall('interface'))):
	print("Interface", root[1][7][2][i][1].text)
	print("Network: Method", root[1][7][2][i][2].text)
	print("Network: IP Addr", root[1][7][2][i][3].text)
	print("Network: Netmask", root[1][7][2][i][4].text)
	print("Network: Gateway", root[1][7][2][i][5].text)
	print("Network: Dns Server", root[1][7][2][i][10].text)
	print("___________________")
'''
#
# Using iter:
for i in root.iter('interface'):
	print("Interface :",i.find('devicename').text)
	print("Method: ",i.find('method').text)
	print("IP Addr: ",i.find('address').text)
	print("Netmask: ",i.find('netmask').text)
	print("Gateway: ",i.find('gateway').text)
	print("Dns Server: ",i.find('dnsnameservers').text)
	print("___________________")

'''
#Storage>btrfsraid: root[1][11][1]
#Storage>btrfsraid>raident: root[1][11][1][1]
print(root[1][11][1].tag)
print(root[1][11][1][1].tag)
print("Raid Level: ", root[1][11][1][1][2].text)
print("Recovery in progress: ", root[1][11][1][1][3].text)

'''

for i in root.iter('slave'):
	print("Device:",i.find('devicefile').text)
	print("Model:", i.find('model').text)
	print("Serial:",i.find('serialnumber').text)
	print("Desc:",i.find('description').text)
	print("Slot:",i.find('slotnumber').text)
	print("Hotspare", i.find('hotspare').text)
	print("___________________")



# OSI Model Reference — Week 2

## The 7 Layers

| Layer | Name | Key Protocols | Cloud Relevance |
|---|---|---|---|
| 7 | Application | HTTP, HTTPS, SSH, DNS, FTP | S3, EC2 SSH access |
| 6 | Presentation | TLS/SSL, JPEG, ASCII | HTTPS encryption |
| 5 | Session | SSH sessions, NetBIOS | Persistent EC2 connections |
| 4 | Transport | TCP, UDP | Security Group port rules |
| 3 | Network | IP, ICMP, routing | VPC, subnets, route tables |
| 2 | Data Link | Ethernet, ARP, MAC | ENIs, same-subnet comms |
| 1 | Physical | Cables, fiber, WiFi | AWS Direct Connect |

## Memory Device
Please Do Not Throw Sausage Pizza Away
(Physical → Application, bottom to top)

## Troubleshooting Order
Start at Layer 1, work up.
Don't debug Layer 7 (application config) if Layer 3 (routing) is broken.

## Encapsulation
Sender: Data → Segment → Packet → Frame → Bits
Receiver: Bits → Frame → Packet → Segment → Data

## Commands Per Layer
Layer 7: curl, nslookup, dig
Layer 4: ss -tuln, nc -zv
Layer 3: ip addr, ping, traceroute
Layer 2: ip link, arp -n

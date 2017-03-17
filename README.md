# Ansible Tower Docker Image

## How to run this image

### 1. Build or pull the image

```docker build -t dayglo/ansibletower .```

or 

```docker pull dayglo/ansibletower ```

### 2. Get a license

Go here and get a licence file.

http://www.ansible.com/license

Save it into license.txt somewhere.

### 3. Run the image

```
docker run -it \
	-p 80:80 -p 443:443 \
	-v /wherever/you/put/your/license/file/license.txt:/etc/tower/license \
	--name tower \
	--privileged \
	dayglo/ansibletower
```

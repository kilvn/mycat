# mycat
mycat for docker

Start command:

```shell
docker run -d -p 9066:9066 -p 8066:8066 -v ~/Documents/mycat:/usr/local/mycat/conf/ kilvn/mycat
```
- 9066 is the console port, and 8066 is the data port.
- Use -v to use the local configuration files.

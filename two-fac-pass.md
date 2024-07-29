## 多因密钥检测

### 双因密码检测

> 广泛应用在互联网行业，一般使用的是hmac-sha1 的算法，基于：
>
> - period 一般为30s
> - 用户和服务器都知道的一个密钥 secret，base32encode,（二维码阶段，扫到用户的设备
> 中，这个密钥要和设备绑定，如果更换了设备这个密钥要重新来
> - 基于时间的一个count，floor(ts/period)

```shell
v = hotp(hmacsha1(secret, floor(ts/period)))
```
#### hmacsha1后的hash计算6位数字
1. 获取动态偏移量（哈希值最后一个字节的低4位）
2. 从哈希值中提取4字节的动态截取码
3. 取模10^6得到六位数的TOTP值
4. 将TOTP值转换为字符串并填充为六位（可能需要补0）

#### python代码
> 利用pyotp库

```python
import pyotp

secret = 'mgxinby4glinbo2y5aypdioh7qk2bvnl5zupayw3dk2pdkt66jvq===='
secret_matt= 'zduuebtqqbs5a5cbjmhwq4yuttdisqcawczow5jyaisha25ulyla===='
secret_xinya = 'ppt5ypt4m36sdchjbpnlhv3g6vzuufmfuarn4tclsyt5nujinwgq===='

def get_hotp():
    totp = pyotp.TOTP(secret_matt)
    return totp.now()

print(get_hotp())
```
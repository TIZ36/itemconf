import hmac
import hashlib
import struct
import time

class HOTP:
    def __init__(self, secret, digits=6):
        self.secret = secret
        self.digits = digits

    def generate(self, counter):
        counter_bytes = struct.pack('>Q', counter)
        hmac_result = hmac.new(self.secret.encode(), counter_bytes, hashlib.sha1).digest()
        offset = hmac_result[-1] & 0xf
        code = struct.unpack('>I', hmac_result[offset:offset+4])[0]
        code = code & 0x7fffffff
        code = code % (10 ** self.digits)
        return f'{code:0{self.digits}d}'

    @staticmethod
    def verify(token, secret, counter, digits=6):
        hotp = HOTP(secret, digits)
        return hmac.compare_digest(token, hotp.generate(counter))

class TOTP(HOTP):
    def __init__(self, secret, digits=6, time_step=30):
        super().__init__(secret, digits)
        self.time_step = time_step
    
    def generate(self, timestamp=None):
        """Generate a TOTP token based on current time or provided timestamp"""
        if timestamp is None:
            timestamp = int(time.time())
        counter = timestamp // self.time_step
        return super().generate(counter)
    
    @staticmethod
    def verify(token, secret, timestamp=None, digits=6, time_step=30, tolerance=1):
        """
        Verify a TOTP token with tolerance window
        
        Args:
            token: The token to verify
            secret: The shared secret
            timestamp: The timestamp to use (default: current time)
            digits: Number of digits in the token
            time_step: Time step in seconds (default: 30)
            tolerance: Number of time steps to check before and after the current one (default: 1)
        
        Returns:
            bool: True if verification succeeds, False otherwise
        """
        if timestamp is None:
            timestamp = int(time.time())
        
        totp = TOTP(secret, digits, time_step)
        counter = timestamp // time_step
        
        # Check current and adjacent time windows based on tolerance
        for i in range(-tolerance, tolerance + 1):
            if hmac.compare_digest(token, totp.generate(timestamp + (i * time_step))):
                return True
        
        return False

# 创建HOTP实例
secret = "mysecretkey"
hotp = HOTP(secret)

# 生成HOTP
counter = 1
token = hotp.generate(counter)
print(f"Generated HOTP: {token}")

# 验证HOTP
is_valid = HOTP.verify(token, secret, counter)
print(f"HOTP is valid: {is_valid}")

# 创建TOTP实例
totp = TOTP(secret)

# 生成TOTP (基于当前时间)
token = totp.generate()
print(f"Generated TOTP: {token}")

# 验证TOTP (30秒内有效)
is_valid = TOTP.verify(token, secret)
print(f"TOTP is valid: {is_valid}")

# 演示时间容差 (模拟29秒后仍然有效)
future_time = int(time.time()) + 29
is_valid = TOTP.verify(token, secret, future_time)
print(f"TOTP is still valid after 29s: {is_valid}")
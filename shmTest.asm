
_shmTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        printf(1, "Error test: Unexpected success for closing non-existent id 999\n");
        exit();
    }
}

int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
    printf(1, "Starting shared memory test\n");
   f:	83 ec 08             	sub    $0x8,%esp
  12:	68 61 0d 00 00       	push   $0xd61
  17:	6a 01                	push   $0x1
  19:	e8 82 06 00 00       	call   6a0 <printf>
    printf(1, "\n=== Testing error cases ===\n");
  1e:	58                   	pop    %eax
  1f:	5a                   	pop    %edx
  20:	68 7e 0d 00 00       	push   $0xd7e
  25:	6a 01                	push   $0x1
  27:	e8 74 06 00 00       	call   6a0 <printf>
    test_error_cases();
  2c:	e8 1f 02 00 00       	call   250 <test_error_cases>

    printf(1, "\n=== Testing multiple processes with shared memory ===\n");
  31:	59                   	pop    %ecx
  32:	5b                   	pop    %ebx
  33:	68 d8 0b 00 00       	push   $0xbd8
  38:	6a 01                	push   $0x1
    for (int i = 0; i < NUM_CHILDREN; i++) {
  3a:	31 db                	xor    %ebx,%ebx
    printf(1, "\n=== Testing multiple processes with shared memory ===\n");
  3c:	e8 5f 06 00 00       	call   6a0 <printf>
  41:	83 c4 10             	add    $0x10,%esp
        int pid = fork();
  44:	e8 c2 04 00 00       	call   50b <fork>
        if (pid < 0) {
  49:	85 c0                	test   %eax,%eax
  4b:	0f 88 02 01 00 00    	js     153 <main+0x153>
            printf(1, "Fork failed\n");
            exit();
        } else if (pid == 0) {
  51:	0f 84 0f 01 00 00    	je     166 <main+0x166>
    for (int i = 0; i < NUM_CHILDREN; i++) {
  57:	83 c3 01             	add    $0x1,%ebx
  5a:	83 fb 03             	cmp    $0x3,%ebx
  5d:	75 e5                	jne    44 <main+0x44>
            exit();
        }
    }

    for (int i = 0; i < NUM_CHILDREN; i++) {
        wait();
  5f:	e8 b7 04 00 00       	call   51b <wait>
  64:	e8 b2 04 00 00       	call   51b <wait>
  69:	e8 ad 04 00 00       	call   51b <wait>
    }
    printf(1, "\n=== Testing memory deallocation ===\n");
  6e:	83 ec 08             	sub    $0x8,%esp
  71:	68 10 0c 00 00       	push   $0xc10
  76:	6a 01                	push   $0x1
  78:	e8 23 06 00 00       	call   6a0 <printf>
    void *shm_addr = open_shared_mem(SHM_ID);
  7d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  84:	e8 2a 05 00 00       	call   5b3 <open_shared_mem>
    if (shm_addr == (void *)-1) {
  89:	83 c4 10             	add    $0x10,%esp
  8c:	83 f8 ff             	cmp    $0xffffffff,%eax
  8f:	0f 84 98 00 00 00    	je     12d <main+0x12d>
        printf(1, "Failed to open shared memory for deallocation test\n");
        exit();
    }
    printf(1, "Main: Opened shared memory at address %p\n", shm_addr);
  95:	52                   	push   %edx
  96:	50                   	push   %eax
  97:	68 6c 0c 00 00       	push   $0xc6c
  9c:	6a 01                	push   $0x1
  9e:	e8 fd 05 00 00       	call   6a0 <printf>

    if (close_shared_mem(SHM_ID) < 0) {
  a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  aa:	e8 0c 05 00 00       	call   5bb <close_shared_mem>
  af:	83 c4 10             	add    $0x10,%esp
  b2:	85 c0                	test   %eax,%eax
  b4:	78 64                	js     11a <main+0x11a>
        printf(1, "Main: Failed to close shared memory\n");
        exit();
    }
    printf(1, "Main: Closed shared memory\n");
  b6:	50                   	push   %eax
  b7:	50                   	push   %eax
  b8:	68 a9 0d 00 00       	push   $0xda9
  bd:	6a 01                	push   $0x1
  bf:	e8 dc 05 00 00       	call   6a0 <printf>
    shm_addr = open_shared_mem(SHM_ID);
  c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cb:	e8 e3 04 00 00       	call   5b3 <open_shared_mem>
    if (shm_addr == (void *)-1) {
  d0:	83 c4 10             	add    $0x10,%esp
  d3:	83 f8 ff             	cmp    $0xffffffff,%eax
  d6:	74 68                	je     140 <main+0x140>
        printf(1, "Failed to reopen shared memory\n");
        exit();
    }
    printf(1, "Main: Reopened shared memory at address %p\n", shm_addr);
  d8:	53                   	push   %ebx
  d9:	50                   	push   %eax
  da:	68 e0 0c 00 00       	push   $0xce0
  df:	6a 01                	push   $0x1
  e1:	e8 ba 05 00 00       	call   6a0 <printf>

    if (close_shared_mem(SHM_ID) < 0) {
  e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ed:	e8 c9 04 00 00       	call   5bb <close_shared_mem>
  f2:	83 c4 10             	add    $0x10,%esp
  f5:	85 c0                	test   %eax,%eax
  f7:	78 21                	js     11a <main+0x11a>
        printf(1, "Main: Failed to close shared memory\n");
        exit();
    }
    printf(1, "Main: Closed shared memory again\n");
  f9:	50                   	push   %eax
  fa:	50                   	push   %eax
  fb:	68 0c 0d 00 00       	push   $0xd0c
 100:	6a 01                	push   $0x1
 102:	e8 99 05 00 00       	call   6a0 <printf>

    printf(1, "\nShared memory test completed\n");
 107:	5a                   	pop    %edx
 108:	59                   	pop    %ecx
 109:	68 30 0d 00 00       	push   $0xd30
 10e:	6a 01                	push   $0x1
 110:	e8 8b 05 00 00       	call   6a0 <printf>
    exit();
 115:	e8 f9 03 00 00       	call   513 <exit>
        printf(1, "Main: Failed to close shared memory\n");
 11a:	50                   	push   %eax
 11b:	50                   	push   %eax
 11c:	68 98 0c 00 00       	push   $0xc98
 121:	6a 01                	push   $0x1
 123:	e8 78 05 00 00       	call   6a0 <printf>
        exit();
 128:	e8 e6 03 00 00       	call   513 <exit>
        printf(1, "Failed to open shared memory for deallocation test\n");
 12d:	51                   	push   %ecx
 12e:	51                   	push   %ecx
 12f:	68 38 0c 00 00       	push   $0xc38
 134:	6a 01                	push   $0x1
 136:	e8 65 05 00 00       	call   6a0 <printf>
        exit();
 13b:	e8 d3 03 00 00       	call   513 <exit>
        printf(1, "Failed to reopen shared memory\n");
 140:	50                   	push   %eax
 141:	50                   	push   %eax
 142:	68 c0 0c 00 00       	push   $0xcc0
 147:	6a 01                	push   $0x1
 149:	e8 52 05 00 00       	call   6a0 <printf>
        exit();
 14e:	e8 c0 03 00 00       	call   513 <exit>
            printf(1, "Fork failed\n");
 153:	50                   	push   %eax
 154:	50                   	push   %eax
 155:	68 9c 0d 00 00       	push   $0xd9c
 15a:	6a 01                	push   $0x1
 15c:	e8 3f 05 00 00       	call   6a0 <printf>
            exit();
 161:	e8 ad 03 00 00       	call   513 <exit>
            test_shared_memory(SHM_ID, i);
 166:	50                   	push   %eax
 167:	50                   	push   %eax
 168:	53                   	push   %ebx
 169:	6a 01                	push   $0x1
 16b:	e8 10 00 00 00       	call   180 <test_shared_memory>
            exit();
 170:	e8 9e 03 00 00       	call   513 <exit>
 175:	66 90                	xchg   %ax,%ax
 177:	66 90                	xchg   %ax,%ax
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <test_shared_memory>:
void test_shared_memory(int id, int child_num) {
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
 185:	53                   	push   %ebx
 186:	83 ec 58             	sub    $0x58,%esp
 189:	8b 75 0c             	mov    0xc(%ebp),%esi
    void *shm_addr = open_shared_mem(SHM_ID);
 18c:	6a 01                	push   $0x1
 18e:	e8 20 04 00 00       	call   5b3 <open_shared_mem>
    if (shm_addr == (void *)-1) {
 193:	83 c4 10             	add    $0x10,%esp
 196:	83 f8 ff             	cmp    $0xffffffff,%eax
 199:	0f 84 85 00 00 00    	je     224 <test_shared_memory+0xa4>
    printf(1, "Child %d: Opened shared memory at address %p\n", child_num, shm_addr);
 19f:	50                   	push   %eax
    strcpy(message, "Hello from child ");
 1a0:	8d 7d b6             	lea    -0x4a(%ebp),%edi
 1a3:	89 c3                	mov    %eax,%ebx
    printf(1, "Child %d: Opened shared memory at address %p\n", child_num, shm_addr);
 1a5:	56                   	push   %esi
 1a6:	68 fc 09 00 00       	push   $0x9fc
 1ab:	6a 01                	push   $0x1
 1ad:	e8 ee 04 00 00       	call   6a0 <printf>
    strcpy(message, "Hello from child ");
 1b2:	58                   	pop    %eax
 1b3:	5a                   	pop    %edx
 1b4:	68 4f 0d 00 00       	push   $0xd4f
 1b9:	57                   	push   %edi
 1ba:	e8 01 01 00 00       	call   2c0 <strcpy>
    message[16] = '0' + child_num; 
 1bf:	8d 46 30             	lea    0x30(%esi),%eax
    strcpy(data, message);
 1c2:	59                   	pop    %ecx
    message[17] = '\0';
 1c3:	c6 45 c7 00          	movb   $0x0,-0x39(%ebp)
    message[16] = '0' + child_num; 
 1c7:	88 45 c6             	mov    %al,-0x3a(%ebp)
    strcpy(data, message);
 1ca:	58                   	pop    %eax
 1cb:	57                   	push   %edi
 1cc:	53                   	push   %ebx
 1cd:	e8 ee 00 00 00       	call   2c0 <strcpy>
    printf(1, "Child %d: Wrote '%s' to shared memory\n", child_num, data);
 1d2:	53                   	push   %ebx
 1d3:	56                   	push   %esi
 1d4:	68 2c 0a 00 00       	push   $0xa2c
 1d9:	6a 01                	push   $0x1
 1db:	e8 c0 04 00 00       	call   6a0 <printf>
    sleep(50);
 1e0:	83 c4 14             	add    $0x14,%esp
 1e3:	6a 32                	push   $0x32
 1e5:	e8 b9 03 00 00       	call   5a3 <sleep>
    printf(1, "Child %d: Read '%s' from shared memory\n", child_num, data);
 1ea:	53                   	push   %ebx
 1eb:	56                   	push   %esi
 1ec:	68 54 0a 00 00       	push   $0xa54
 1f1:	6a 01                	push   $0x1
 1f3:	e8 a8 04 00 00       	call   6a0 <printf>
    if (close_shared_mem(SHM_ID) < 0) {
 1f8:	83 c4 14             	add    $0x14,%esp
 1fb:	6a 01                	push   $0x1
 1fd:	e8 b9 03 00 00       	call   5bb <close_shared_mem>
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 2f                	js     238 <test_shared_memory+0xb8>
    printf(1, "Child %d: Closed shared memory\n", child_num);
 209:	83 ec 04             	sub    $0x4,%esp
 20c:	56                   	push   %esi
 20d:	68 b0 0a 00 00       	push   $0xab0
 212:	6a 01                	push   $0x1
 214:	e8 87 04 00 00       	call   6a0 <printf>
}
 219:	83 c4 10             	add    $0x10,%esp
 21c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 21f:	5b                   	pop    %ebx
 220:	5e                   	pop    %esi
 221:	5f                   	pop    %edi
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    
        printf(1, "Child %d: Failed to open shared memory with id %d\n", child_num, SHM_ID);
 224:	6a 01                	push   $0x1
 226:	56                   	push   %esi
 227:	68 c8 09 00 00       	push   $0x9c8
 22c:	6a 01                	push   $0x1
 22e:	e8 6d 04 00 00       	call   6a0 <printf>
        exit();
 233:	e8 db 02 00 00       	call   513 <exit>
        printf(1, "Child %d: Failed to close shared memory with id %d\n", child_num, SHM_ID);
 238:	6a 01                	push   $0x1
 23a:	56                   	push   %esi
 23b:	68 7c 0a 00 00       	push   $0xa7c
 240:	6a 01                	push   $0x1
 242:	e8 59 04 00 00       	call   6a0 <printf>
        exit();
 247:	e8 c7 02 00 00       	call   513 <exit>
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000250 <test_error_cases>:
void test_error_cases() {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	83 ec 14             	sub    $0x14,%esp
    void *shm_addr = open_shared_mem(-1);
 256:	6a ff                	push   $0xffffffff
 258:	e8 56 03 00 00       	call   5b3 <open_shared_mem>
    if (shm_addr == (void *)-1) {
 25d:	83 c4 10             	add    $0x10,%esp
 260:	83 f8 ff             	cmp    $0xffffffff,%eax
 263:	75 33                	jne    298 <test_error_cases+0x48>
        printf(1, "Error test: Correctly failed to open shared memory with invalid id -1\n");
 265:	83 ec 08             	sub    $0x8,%esp
 268:	68 d0 0a 00 00       	push   $0xad0
 26d:	6a 01                	push   $0x1
 26f:	e8 2c 04 00 00       	call   6a0 <printf>
    if (close_shared_mem(999) < 0) {
 274:	c7 04 24 e7 03 00 00 	movl   $0x3e7,(%esp)
 27b:	e8 3b 03 00 00       	call   5bb <close_shared_mem>
 280:	83 c4 10             	add    $0x10,%esp
 283:	85 c0                	test   %eax,%eax
 285:	79 24                	jns    2ab <test_error_cases+0x5b>
        printf(1, "Error test: Correctly failed to close non-existent shared memory id 999\n");
 287:	83 ec 08             	sub    $0x8,%esp
 28a:	68 4c 0b 00 00       	push   $0xb4c
 28f:	6a 01                	push   $0x1
 291:	e8 0a 04 00 00       	call   6a0 <printf>
}
 296:	c9                   	leave  
 297:	c3                   	ret    
        printf(1, "Error test: Unexpected success for invalid id -1\n");
 298:	52                   	push   %edx
 299:	52                   	push   %edx
 29a:	68 18 0b 00 00       	push   $0xb18
 29f:	6a 01                	push   $0x1
 2a1:	e8 fa 03 00 00       	call   6a0 <printf>
        exit();
 2a6:	e8 68 02 00 00       	call   513 <exit>
        printf(1, "Error test: Unexpected success for closing non-existent id 999\n");
 2ab:	50                   	push   %eax
 2ac:	50                   	push   %eax
 2ad:	68 98 0b 00 00       	push   $0xb98
 2b2:	6a 01                	push   $0x1
 2b4:	e8 e7 03 00 00       	call   6a0 <printf>
        exit();
 2b9:	e8 55 02 00 00       	call   513 <exit>
 2be:	66 90                	xchg   %ax,%ax

000002c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2c0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2c1:	31 c0                	xor    %eax,%eax
{
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	53                   	push   %ebx
 2c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 2d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 2d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 2d7:	83 c0 01             	add    $0x1,%eax
 2da:	84 d2                	test   %dl,%dl
 2dc:	75 f2                	jne    2d0 <strcpy+0x10>
    ;
  return os;
}
 2de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2e1:	89 c8                	mov    %ecx,%eax
 2e3:	c9                   	leave  
 2e4:	c3                   	ret    
 2e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 55 08             	mov    0x8(%ebp),%edx
 2f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2fa:	0f b6 02             	movzbl (%edx),%eax
 2fd:	84 c0                	test   %al,%al
 2ff:	75 17                	jne    318 <strcmp+0x28>
 301:	eb 3a                	jmp    33d <strcmp+0x4d>
 303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 307:	90                   	nop
 308:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 30c:	83 c2 01             	add    $0x1,%edx
 30f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 312:	84 c0                	test   %al,%al
 314:	74 1a                	je     330 <strcmp+0x40>
    p++, q++;
 316:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 318:	0f b6 19             	movzbl (%ecx),%ebx
 31b:	38 c3                	cmp    %al,%bl
 31d:	74 e9                	je     308 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 31f:	29 d8                	sub    %ebx,%eax
}
 321:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 324:	c9                   	leave  
 325:	c3                   	ret    
 326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 32d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 330:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 334:	31 c0                	xor    %eax,%eax
 336:	29 d8                	sub    %ebx,%eax
}
 338:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 33b:	c9                   	leave  
 33c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 33d:	0f b6 19             	movzbl (%ecx),%ebx
 340:	31 c0                	xor    %eax,%eax
 342:	eb db                	jmp    31f <strcmp+0x2f>
 344:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 34b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 34f:	90                   	nop

00000350 <strlen>:

uint
strlen(const char *s)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 356:	80 3a 00             	cmpb   $0x0,(%edx)
 359:	74 15                	je     370 <strlen+0x20>
 35b:	31 c0                	xor    %eax,%eax
 35d:	8d 76 00             	lea    0x0(%esi),%esi
 360:	83 c0 01             	add    $0x1,%eax
 363:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 367:	89 c1                	mov    %eax,%ecx
 369:	75 f5                	jne    360 <strlen+0x10>
    ;
  return n;
}
 36b:	89 c8                	mov    %ecx,%eax
 36d:	5d                   	pop    %ebp
 36e:	c3                   	ret    
 36f:	90                   	nop
  for(n = 0; s[n]; n++)
 370:	31 c9                	xor    %ecx,%ecx
}
 372:	5d                   	pop    %ebp
 373:	89 c8                	mov    %ecx,%eax
 375:	c3                   	ret    
 376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 37d:	8d 76 00             	lea    0x0(%esi),%esi

00000380 <memset>:

void*
memset(void *dst, int c, uint n)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 387:	8b 4d 10             	mov    0x10(%ebp),%ecx
 38a:	8b 45 0c             	mov    0xc(%ebp),%eax
 38d:	89 d7                	mov    %edx,%edi
 38f:	fc                   	cld    
 390:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 392:	8b 7d fc             	mov    -0x4(%ebp),%edi
 395:	89 d0                	mov    %edx,%eax
 397:	c9                   	leave  
 398:	c3                   	ret    
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <strchr>:

char*
strchr(const char *s, char c)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 45 08             	mov    0x8(%ebp),%eax
 3a6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 3aa:	0f b6 10             	movzbl (%eax),%edx
 3ad:	84 d2                	test   %dl,%dl
 3af:	75 12                	jne    3c3 <strchr+0x23>
 3b1:	eb 1d                	jmp    3d0 <strchr+0x30>
 3b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b7:	90                   	nop
 3b8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 3bc:	83 c0 01             	add    $0x1,%eax
 3bf:	84 d2                	test   %dl,%dl
 3c1:	74 0d                	je     3d0 <strchr+0x30>
    if(*s == c)
 3c3:	38 d1                	cmp    %dl,%cl
 3c5:	75 f1                	jne    3b8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 3c7:	5d                   	pop    %ebp
 3c8:	c3                   	ret    
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 3d0:	31 c0                	xor    %eax,%eax
}
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3df:	90                   	nop

000003e0 <gets>:

char*
gets(char *buf, int max)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 3e5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 3e8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 3e9:	31 db                	xor    %ebx,%ebx
{
 3eb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 3ee:	eb 27                	jmp    417 <gets+0x37>
    cc = read(0, &c, 1);
 3f0:	83 ec 04             	sub    $0x4,%esp
 3f3:	6a 01                	push   $0x1
 3f5:	57                   	push   %edi
 3f6:	6a 00                	push   $0x0
 3f8:	e8 2e 01 00 00       	call   52b <read>
    if(cc < 1)
 3fd:	83 c4 10             	add    $0x10,%esp
 400:	85 c0                	test   %eax,%eax
 402:	7e 1d                	jle    421 <gets+0x41>
      break;
    buf[i++] = c;
 404:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 408:	8b 55 08             	mov    0x8(%ebp),%edx
 40b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 40f:	3c 0a                	cmp    $0xa,%al
 411:	74 1d                	je     430 <gets+0x50>
 413:	3c 0d                	cmp    $0xd,%al
 415:	74 19                	je     430 <gets+0x50>
  for(i=0; i+1 < max; ){
 417:	89 de                	mov    %ebx,%esi
 419:	83 c3 01             	add    $0x1,%ebx
 41c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 41f:	7c cf                	jl     3f0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 421:	8b 45 08             	mov    0x8(%ebp),%eax
 424:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 428:	8d 65 f4             	lea    -0xc(%ebp),%esp
 42b:	5b                   	pop    %ebx
 42c:	5e                   	pop    %esi
 42d:	5f                   	pop    %edi
 42e:	5d                   	pop    %ebp
 42f:	c3                   	ret    
  buf[i] = '\0';
 430:	8b 45 08             	mov    0x8(%ebp),%eax
 433:	89 de                	mov    %ebx,%esi
 435:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 439:	8d 65 f4             	lea    -0xc(%ebp),%esp
 43c:	5b                   	pop    %ebx
 43d:	5e                   	pop    %esi
 43e:	5f                   	pop    %edi
 43f:	5d                   	pop    %ebp
 440:	c3                   	ret    
 441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 448:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44f:	90                   	nop

00000450 <stat>:

int
stat(const char *n, struct stat *st)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	56                   	push   %esi
 454:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 455:	83 ec 08             	sub    $0x8,%esp
 458:	6a 00                	push   $0x0
 45a:	ff 75 08             	push   0x8(%ebp)
 45d:	e8 f1 00 00 00       	call   553 <open>
  if(fd < 0)
 462:	83 c4 10             	add    $0x10,%esp
 465:	85 c0                	test   %eax,%eax
 467:	78 27                	js     490 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 469:	83 ec 08             	sub    $0x8,%esp
 46c:	ff 75 0c             	push   0xc(%ebp)
 46f:	89 c3                	mov    %eax,%ebx
 471:	50                   	push   %eax
 472:	e8 f4 00 00 00       	call   56b <fstat>
  close(fd);
 477:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 47a:	89 c6                	mov    %eax,%esi
  close(fd);
 47c:	e8 ba 00 00 00       	call   53b <close>
  return r;
 481:	83 c4 10             	add    $0x10,%esp
}
 484:	8d 65 f8             	lea    -0x8(%ebp),%esp
 487:	89 f0                	mov    %esi,%eax
 489:	5b                   	pop    %ebx
 48a:	5e                   	pop    %esi
 48b:	5d                   	pop    %ebp
 48c:	c3                   	ret    
 48d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 490:	be ff ff ff ff       	mov    $0xffffffff,%esi
 495:	eb ed                	jmp    484 <stat+0x34>
 497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 49e:	66 90                	xchg   %ax,%ax

000004a0 <atoi>:

int
atoi(const char *s)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	53                   	push   %ebx
 4a4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4a7:	0f be 02             	movsbl (%edx),%eax
 4aa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 4ad:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 4b0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 4b5:	77 1e                	ja     4d5 <atoi+0x35>
 4b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4be:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 4c0:	83 c2 01             	add    $0x1,%edx
 4c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 4c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 4ca:	0f be 02             	movsbl (%edx),%eax
 4cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 4d0:	80 fb 09             	cmp    $0x9,%bl
 4d3:	76 eb                	jbe    4c0 <atoi+0x20>
  return n;
}
 4d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4d8:	89 c8                	mov    %ecx,%eax
 4da:	c9                   	leave  
 4db:	c3                   	ret    
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	8b 45 10             	mov    0x10(%ebp),%eax
 4e7:	8b 55 08             	mov    0x8(%ebp),%edx
 4ea:	56                   	push   %esi
 4eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ee:	85 c0                	test   %eax,%eax
 4f0:	7e 13                	jle    505 <memmove+0x25>
 4f2:	01 d0                	add    %edx,%eax
  dst = vdst;
 4f4:	89 d7                	mov    %edx,%edi
 4f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 500:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 501:	39 f8                	cmp    %edi,%eax
 503:	75 fb                	jne    500 <memmove+0x20>
  return vdst;
}
 505:	5e                   	pop    %esi
 506:	89 d0                	mov    %edx,%eax
 508:	5f                   	pop    %edi
 509:	5d                   	pop    %ebp
 50a:	c3                   	ret    

0000050b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 50b:	b8 01 00 00 00       	mov    $0x1,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <exit>:
SYSCALL(exit)
 513:	b8 02 00 00 00       	mov    $0x2,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <wait>:
SYSCALL(wait)
 51b:	b8 03 00 00 00       	mov    $0x3,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <pipe>:
SYSCALL(pipe)
 523:	b8 04 00 00 00       	mov    $0x4,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <read>:
SYSCALL(read)
 52b:	b8 05 00 00 00       	mov    $0x5,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <write>:
SYSCALL(write)
 533:	b8 10 00 00 00       	mov    $0x10,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <close>:
SYSCALL(close)
 53b:	b8 15 00 00 00       	mov    $0x15,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <kill>:
SYSCALL(kill)
 543:	b8 06 00 00 00       	mov    $0x6,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <exec>:
SYSCALL(exec)
 54b:	b8 07 00 00 00       	mov    $0x7,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <open>:
SYSCALL(open)
 553:	b8 0f 00 00 00       	mov    $0xf,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <mknod>:
SYSCALL(mknod)
 55b:	b8 11 00 00 00       	mov    $0x11,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <unlink>:
SYSCALL(unlink)
 563:	b8 12 00 00 00       	mov    $0x12,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <fstat>:
SYSCALL(fstat)
 56b:	b8 08 00 00 00       	mov    $0x8,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <link>:
SYSCALL(link)
 573:	b8 13 00 00 00       	mov    $0x13,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <mkdir>:
SYSCALL(mkdir)
 57b:	b8 14 00 00 00       	mov    $0x14,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <chdir>:
SYSCALL(chdir)
 583:	b8 09 00 00 00       	mov    $0x9,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <dup>:
SYSCALL(dup)
 58b:	b8 0a 00 00 00       	mov    $0xa,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <getpid>:
SYSCALL(getpid)
 593:	b8 0b 00 00 00       	mov    $0xb,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <sbrk>:
SYSCALL(sbrk)
 59b:	b8 0c 00 00 00       	mov    $0xc,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <sleep>:
SYSCALL(sleep)
 5a3:	b8 0d 00 00 00       	mov    $0xd,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <uptime>:
SYSCALL(uptime)
 5ab:	b8 0e 00 00 00       	mov    $0xe,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <open_shared_mem>:
SYSCALL(open_shared_mem)
 5b3:	b8 16 00 00 00       	mov    $0x16,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <close_shared_mem>:
SYSCALL(close_shared_mem)
 5bb:	b8 17 00 00 00       	mov    $0x17,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <monitor_init>:
SYSCALL(monitor_init)
 5c3:	b8 18 00 00 00       	mov    $0x18,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <monitor_increase_all_elems>:
SYSCALL(monitor_increase_all_elems)
 5cb:	b8 19 00 00 00       	mov    $0x19,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <monitor_close_shared_mem>:
SYSCALL(monitor_close_shared_mem)
 5d3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <monitor_read_shared_mem>:
SYSCALL(monitor_read_shared_mem)
 5db:	b8 1b 00 00 00       	mov    $0x1b,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    
 5e3:	66 90                	xchg   %ax,%ax
 5e5:	66 90                	xchg   %ax,%ax
 5e7:	66 90                	xchg   %ax,%ax
 5e9:	66 90                	xchg   %ax,%ax
 5eb:	66 90                	xchg   %ax,%ax
 5ed:	66 90                	xchg   %ax,%ax
 5ef:	90                   	nop

000005f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	83 ec 3c             	sub    $0x3c,%esp
 5f9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 5fc:	89 d1                	mov    %edx,%ecx
{
 5fe:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 601:	85 d2                	test   %edx,%edx
 603:	0f 89 7f 00 00 00    	jns    688 <printint+0x98>
 609:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 60d:	74 79                	je     688 <printint+0x98>
    neg = 1;
 60f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 616:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 618:	31 db                	xor    %ebx,%ebx
 61a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 61d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 620:	89 c8                	mov    %ecx,%eax
 622:	31 d2                	xor    %edx,%edx
 624:	89 cf                	mov    %ecx,%edi
 626:	f7 75 c4             	divl   -0x3c(%ebp)
 629:	0f b6 92 24 0e 00 00 	movzbl 0xe24(%edx),%edx
 630:	89 45 c0             	mov    %eax,-0x40(%ebp)
 633:	89 d8                	mov    %ebx,%eax
 635:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 638:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 63b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 63e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 641:	76 dd                	jbe    620 <printint+0x30>
  if(neg)
 643:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 646:	85 c9                	test   %ecx,%ecx
 648:	74 0c                	je     656 <printint+0x66>
    buf[i++] = '-';
 64a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 64f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 651:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 656:	8b 7d b8             	mov    -0x48(%ebp),%edi
 659:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 65d:	eb 07                	jmp    666 <printint+0x76>
 65f:	90                   	nop
    putc(fd, buf[i]);
 660:	0f b6 13             	movzbl (%ebx),%edx
 663:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 666:	83 ec 04             	sub    $0x4,%esp
 669:	88 55 d7             	mov    %dl,-0x29(%ebp)
 66c:	6a 01                	push   $0x1
 66e:	56                   	push   %esi
 66f:	57                   	push   %edi
 670:	e8 be fe ff ff       	call   533 <write>
  while(--i >= 0)
 675:	83 c4 10             	add    $0x10,%esp
 678:	39 de                	cmp    %ebx,%esi
 67a:	75 e4                	jne    660 <printint+0x70>
}
 67c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 67f:	5b                   	pop    %ebx
 680:	5e                   	pop    %esi
 681:	5f                   	pop    %edi
 682:	5d                   	pop    %ebp
 683:	c3                   	ret    
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 688:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 68f:	eb 87                	jmp    618 <printint+0x28>
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop

000006a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 6ac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 6af:	0f b6 13             	movzbl (%ebx),%edx
 6b2:	84 d2                	test   %dl,%dl
 6b4:	74 6a                	je     720 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 6b6:	8d 45 10             	lea    0x10(%ebp),%eax
 6b9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 6bc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 6bf:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 6c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6c4:	eb 36                	jmp    6fc <printf+0x5c>
 6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
 6d0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 6d3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 6d8:	83 f8 25             	cmp    $0x25,%eax
 6db:	74 15                	je     6f2 <printf+0x52>
  write(fd, &c, 1);
 6dd:	83 ec 04             	sub    $0x4,%esp
 6e0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 6e3:	6a 01                	push   $0x1
 6e5:	57                   	push   %edi
 6e6:	56                   	push   %esi
 6e7:	e8 47 fe ff ff       	call   533 <write>
 6ec:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 6ef:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 6f2:	0f b6 13             	movzbl (%ebx),%edx
 6f5:	83 c3 01             	add    $0x1,%ebx
 6f8:	84 d2                	test   %dl,%dl
 6fa:	74 24                	je     720 <printf+0x80>
    c = fmt[i] & 0xff;
 6fc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 6ff:	85 c9                	test   %ecx,%ecx
 701:	74 cd                	je     6d0 <printf+0x30>
      }
    } else if(state == '%'){
 703:	83 f9 25             	cmp    $0x25,%ecx
 706:	75 ea                	jne    6f2 <printf+0x52>
      if(c == 'd'){
 708:	83 f8 25             	cmp    $0x25,%eax
 70b:	0f 84 07 01 00 00    	je     818 <printf+0x178>
 711:	83 e8 63             	sub    $0x63,%eax
 714:	83 f8 15             	cmp    $0x15,%eax
 717:	77 17                	ja     730 <printf+0x90>
 719:	ff 24 85 cc 0d 00 00 	jmp    *0xdcc(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 720:	8d 65 f4             	lea    -0xc(%ebp),%esp
 723:	5b                   	pop    %ebx
 724:	5e                   	pop    %esi
 725:	5f                   	pop    %edi
 726:	5d                   	pop    %ebp
 727:	c3                   	ret    
 728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72f:	90                   	nop
  write(fd, &c, 1);
 730:	83 ec 04             	sub    $0x4,%esp
 733:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 736:	6a 01                	push   $0x1
 738:	57                   	push   %edi
 739:	56                   	push   %esi
 73a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 73e:	e8 f0 fd ff ff       	call   533 <write>
        putc(fd, c);
 743:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 747:	83 c4 0c             	add    $0xc,%esp
 74a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 74d:	6a 01                	push   $0x1
 74f:	57                   	push   %edi
 750:	56                   	push   %esi
 751:	e8 dd fd ff ff       	call   533 <write>
        putc(fd, c);
 756:	83 c4 10             	add    $0x10,%esp
      state = 0;
 759:	31 c9                	xor    %ecx,%ecx
 75b:	eb 95                	jmp    6f2 <printf+0x52>
 75d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 760:	83 ec 0c             	sub    $0xc,%esp
 763:	b9 10 00 00 00       	mov    $0x10,%ecx
 768:	6a 00                	push   $0x0
 76a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 76d:	8b 10                	mov    (%eax),%edx
 76f:	89 f0                	mov    %esi,%eax
 771:	e8 7a fe ff ff       	call   5f0 <printint>
        ap++;
 776:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 77a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 77d:	31 c9                	xor    %ecx,%ecx
 77f:	e9 6e ff ff ff       	jmp    6f2 <printf+0x52>
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 788:	8b 45 d0             	mov    -0x30(%ebp),%eax
 78b:	8b 10                	mov    (%eax),%edx
        ap++;
 78d:	83 c0 04             	add    $0x4,%eax
 790:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 793:	85 d2                	test   %edx,%edx
 795:	0f 84 8d 00 00 00    	je     828 <printf+0x188>
        while(*s != 0){
 79b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 79e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 7a0:	84 c0                	test   %al,%al
 7a2:	0f 84 4a ff ff ff    	je     6f2 <printf+0x52>
 7a8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 7ab:	89 d3                	mov    %edx,%ebx
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7b0:	83 ec 04             	sub    $0x4,%esp
          s++;
 7b3:	83 c3 01             	add    $0x1,%ebx
 7b6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7b9:	6a 01                	push   $0x1
 7bb:	57                   	push   %edi
 7bc:	56                   	push   %esi
 7bd:	e8 71 fd ff ff       	call   533 <write>
        while(*s != 0){
 7c2:	0f b6 03             	movzbl (%ebx),%eax
 7c5:	83 c4 10             	add    $0x10,%esp
 7c8:	84 c0                	test   %al,%al
 7ca:	75 e4                	jne    7b0 <printf+0x110>
      state = 0;
 7cc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 7cf:	31 c9                	xor    %ecx,%ecx
 7d1:	e9 1c ff ff ff       	jmp    6f2 <printf+0x52>
 7d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7dd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 7e0:	83 ec 0c             	sub    $0xc,%esp
 7e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7e8:	6a 01                	push   $0x1
 7ea:	e9 7b ff ff ff       	jmp    76a <printf+0xca>
 7ef:	90                   	nop
        putc(fd, *ap);
 7f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 7f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 7f6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 7f8:	6a 01                	push   $0x1
 7fa:	57                   	push   %edi
 7fb:	56                   	push   %esi
        putc(fd, *ap);
 7fc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7ff:	e8 2f fd ff ff       	call   533 <write>
        ap++;
 804:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 808:	83 c4 10             	add    $0x10,%esp
      state = 0;
 80b:	31 c9                	xor    %ecx,%ecx
 80d:	e9 e0 fe ff ff       	jmp    6f2 <printf+0x52>
 812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 818:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 81b:	83 ec 04             	sub    $0x4,%esp
 81e:	e9 2a ff ff ff       	jmp    74d <printf+0xad>
 823:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 827:	90                   	nop
          s = "(null)";
 828:	ba c5 0d 00 00       	mov    $0xdc5,%edx
        while(*s != 0){
 82d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 830:	b8 28 00 00 00       	mov    $0x28,%eax
 835:	89 d3                	mov    %edx,%ebx
 837:	e9 74 ff ff ff       	jmp    7b0 <printf+0x110>
 83c:	66 90                	xchg   %ax,%ax
 83e:	66 90                	xchg   %ax,%ax

00000840 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 840:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 841:	a1 24 11 00 00       	mov    0x1124,%eax
{
 846:	89 e5                	mov    %esp,%ebp
 848:	57                   	push   %edi
 849:	56                   	push   %esi
 84a:	53                   	push   %ebx
 84b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 84e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 858:	89 c2                	mov    %eax,%edx
 85a:	8b 00                	mov    (%eax),%eax
 85c:	39 ca                	cmp    %ecx,%edx
 85e:	73 30                	jae    890 <free+0x50>
 860:	39 c1                	cmp    %eax,%ecx
 862:	72 04                	jb     868 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 864:	39 c2                	cmp    %eax,%edx
 866:	72 f0                	jb     858 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 868:	8b 73 fc             	mov    -0x4(%ebx),%esi
 86b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 86e:	39 f8                	cmp    %edi,%eax
 870:	74 30                	je     8a2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 872:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 875:	8b 42 04             	mov    0x4(%edx),%eax
 878:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 87b:	39 f1                	cmp    %esi,%ecx
 87d:	74 3a                	je     8b9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 87f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 881:	5b                   	pop    %ebx
  freep = p;
 882:	89 15 24 11 00 00    	mov    %edx,0x1124
}
 888:	5e                   	pop    %esi
 889:	5f                   	pop    %edi
 88a:	5d                   	pop    %ebp
 88b:	c3                   	ret    
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 890:	39 c2                	cmp    %eax,%edx
 892:	72 c4                	jb     858 <free+0x18>
 894:	39 c1                	cmp    %eax,%ecx
 896:	73 c0                	jae    858 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 898:	8b 73 fc             	mov    -0x4(%ebx),%esi
 89b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 89e:	39 f8                	cmp    %edi,%eax
 8a0:	75 d0                	jne    872 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 8a2:	03 70 04             	add    0x4(%eax),%esi
 8a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a8:	8b 02                	mov    (%edx),%eax
 8aa:	8b 00                	mov    (%eax),%eax
 8ac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 8af:	8b 42 04             	mov    0x4(%edx),%eax
 8b2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 8b5:	39 f1                	cmp    %esi,%ecx
 8b7:	75 c6                	jne    87f <free+0x3f>
    p->s.size += bp->s.size;
 8b9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 8bc:	89 15 24 11 00 00    	mov    %edx,0x1124
    p->s.size += bp->s.size;
 8c2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 8c5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 8c8:	89 0a                	mov    %ecx,(%edx)
}
 8ca:	5b                   	pop    %ebx
 8cb:	5e                   	pop    %esi
 8cc:	5f                   	pop    %edi
 8cd:	5d                   	pop    %ebp
 8ce:	c3                   	ret    
 8cf:	90                   	nop

000008d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	57                   	push   %edi
 8d4:	56                   	push   %esi
 8d5:	53                   	push   %ebx
 8d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8dc:	8b 3d 24 11 00 00    	mov    0x1124,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e2:	8d 70 07             	lea    0x7(%eax),%esi
 8e5:	c1 ee 03             	shr    $0x3,%esi
 8e8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 8eb:	85 ff                	test   %edi,%edi
 8ed:	0f 84 9d 00 00 00    	je     990 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 8f5:	8b 4a 04             	mov    0x4(%edx),%ecx
 8f8:	39 f1                	cmp    %esi,%ecx
 8fa:	73 6a                	jae    966 <malloc+0x96>
 8fc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 901:	39 de                	cmp    %ebx,%esi
 903:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 906:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 90d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 910:	eb 17                	jmp    929 <malloc+0x59>
 912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 918:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 91a:	8b 48 04             	mov    0x4(%eax),%ecx
 91d:	39 f1                	cmp    %esi,%ecx
 91f:	73 4f                	jae    970 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 921:	8b 3d 24 11 00 00    	mov    0x1124,%edi
 927:	89 c2                	mov    %eax,%edx
 929:	39 d7                	cmp    %edx,%edi
 92b:	75 eb                	jne    918 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 92d:	83 ec 0c             	sub    $0xc,%esp
 930:	ff 75 e4             	push   -0x1c(%ebp)
 933:	e8 63 fc ff ff       	call   59b <sbrk>
  if(p == (char*)-1)
 938:	83 c4 10             	add    $0x10,%esp
 93b:	83 f8 ff             	cmp    $0xffffffff,%eax
 93e:	74 1c                	je     95c <malloc+0x8c>
  hp->s.size = nu;
 940:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 943:	83 ec 0c             	sub    $0xc,%esp
 946:	83 c0 08             	add    $0x8,%eax
 949:	50                   	push   %eax
 94a:	e8 f1 fe ff ff       	call   840 <free>
  return freep;
 94f:	8b 15 24 11 00 00    	mov    0x1124,%edx
      if((p = morecore(nunits)) == 0)
 955:	83 c4 10             	add    $0x10,%esp
 958:	85 d2                	test   %edx,%edx
 95a:	75 bc                	jne    918 <malloc+0x48>
        return 0;
  }
}
 95c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 95f:	31 c0                	xor    %eax,%eax
}
 961:	5b                   	pop    %ebx
 962:	5e                   	pop    %esi
 963:	5f                   	pop    %edi
 964:	5d                   	pop    %ebp
 965:	c3                   	ret    
    if(p->s.size >= nunits){
 966:	89 d0                	mov    %edx,%eax
 968:	89 fa                	mov    %edi,%edx
 96a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 970:	39 ce                	cmp    %ecx,%esi
 972:	74 4c                	je     9c0 <malloc+0xf0>
        p->s.size -= nunits;
 974:	29 f1                	sub    %esi,%ecx
 976:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 979:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 97c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 97f:	89 15 24 11 00 00    	mov    %edx,0x1124
}
 985:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 988:	83 c0 08             	add    $0x8,%eax
}
 98b:	5b                   	pop    %ebx
 98c:	5e                   	pop    %esi
 98d:	5f                   	pop    %edi
 98e:	5d                   	pop    %ebp
 98f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 990:	c7 05 24 11 00 00 28 	movl   $0x1128,0x1124
 997:	11 00 00 
    base.s.size = 0;
 99a:	bf 28 11 00 00       	mov    $0x1128,%edi
    base.s.ptr = freep = prevp = &base;
 99f:	c7 05 28 11 00 00 28 	movl   $0x1128,0x1128
 9a6:	11 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 9ab:	c7 05 2c 11 00 00 00 	movl   $0x0,0x112c
 9b2:	00 00 00 
    if(p->s.size >= nunits){
 9b5:	e9 42 ff ff ff       	jmp    8fc <malloc+0x2c>
 9ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 9c0:	8b 08                	mov    (%eax),%ecx
 9c2:	89 0a                	mov    %ecx,(%edx)
 9c4:	eb b9                	jmp    97f <malloc+0xaf>

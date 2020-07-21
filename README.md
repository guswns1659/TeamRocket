# 프로젝트 명 : 잘먹었습니다

## 1. 프로젝트 소개
음식물 쓰레기로 발생하는 환경오염을 줄이기 위한 프로젝트. 사용자가 음식을 다 먹은 후 빈 그릇을 사진 찍고 인증하면 에코 포인트가 발행된다. 사용자는 획득한 에코포인트로 다양한 기업들의 사회공헌 프로젝트에 기부할 수 있다. 기업들은 프로젝트 참여를 통해 홍보효과를 누릴 수 있다.


- 프로젝트 배경 
    - 하루 1만 4천여 톤 발생, 전체 쓰레기 발생량의 28.7% 차지
    - 음식물의 1/7이 쓰레기로 버려짐.
    - 경제적 손실 연간 20조 원 이상
    - 하루에 1만 5천톤, 매립이나 소각에 1톤 당 최소 15만원.
    - 소각할 곳은 부족하고 비용이 드니 불법 투기 증가.

- 음식물 쓰레기로 인한 문제 상황 
    - 연간 온실가스 배출량 885만 톤 co2e
    - 음식물쓰레기 처리 비용 연간 8,000억원
    ![](https://i.imgur.com/BR4yP5H.png)

- 얼마나 줄여야 환경오염에 도움이 될까?
  - 전 국민이 음식물쓰레기를 20% 줄이면 연간 1,600억원의 쓰레기 처리 비용이 줄고 에너지 절약 등으로 5조 원에 달하는 경제적 이익이 생김.
  - 18억kwh가 절약돼 39만 가구가 겨울을 날 수 있는 연탄 1억 8,600만 장을 보급할 수 있다.


## 애플리케이션을 통한 문제 해결 : 음식물 쓰레기 챌린지!
- 음식물 쓰레기 구성의 30%인 먹고 남긴 음식물을 줄이는 챌린지를 시도하자!

![](https://i.imgur.com/llFKxIg.png)

- 어플리케이션의 확장성
    - 음식물쓰레기 인증을 확장해 플라스틱 분리배출, 친환경 용기 재활용, 텀블러 사용 등 환경 보호에 도움이 되는 활동으로 확장 가능.

-----

## 2. 협업
사용 툴 : Slack, Github Issue, Adobe XD, Swagger

### 팀 협업 
- Github 저장소의 이슈 탭의 라벨을 활용하여 각 기능 분업 
    - BE : 백엔드 개발자 작업 
    - iOS : iOS 개발자 작업 
    - Team : 팀 단위 함께 논의할 작업  
![](https://i.imgur.com/vEa3p2L.png)

- Swagger를 이용한 API 가이드 문서
    - [프로젝트 Swagger URL](http://15.164.255.212/api/swagger-ui.html)
    - Swagger 예시  

![](https://i.imgur.com/Szd4sJj.png)


- Adobe XD를 이용한 UI 디자인 ([링크](https://xd.adobe.com/view/508425a2-ea77-4841-aabc-9028dc4a7087-05d7/))
<img src = "https://i.imgur.com/slv5gXQ.png" width = 50%/>


### iOS 
- Delma : 기획, 디자인, iOS 개발
- Cory : 기획, 디자인, iOS 개발

### BackEnd 개발
#### 기술 스택
Java8, Spring Boot 2.2.2, AWS RDS MySQL8.0, AWS EC2, Nginx

#### 맡은 역할
- 아이디어 기획
- 메인, 지도, 기부하기 등 5개 화면 [총 API 17개](http://15.164.255.212/api/swagger-ui.html) 구현
- TDD 적용, 테스트 커버리지 70% 이상 : 레포지토리부터 컨트롤러까지 모든 레이어 테스트 코드 작성.
![](https://i.imgur.com/iclYgkQ.png)

----

## 기능 설명

### 홈
<img src = "https://i.imgur.com/auSTlid.png" width = 50%/><img src = "https://i.imgur.com/NkGnPXV.png" width = 50%/>

- 처음 '잘먹었습니다' 서비스를 이용하는 사용자에게 사용법을 알려줄 수 있는 가이드 버튼
- 사용자가 이제까지 참여한 챌린지를 토대로 감소된 온실가스 데이터
- 오늘 하루 전체 사용자가 참여한 챌린지, 사용자가 참여한 챌린지
- 이번주에 참여한 챌린지 참여 사진들을 표시
- 진행 중인 기부 프로젝트 일부를 표시
- 주변에 '잘먹었습니다' 참여 식당을 보여주는 버튼

**튜토리얼**
<img src = "https://i.imgur.com/PEvu5iv.png" width = 30%/><img src = "https://i.imgur.com/rxERfCP.png)" width = 30%/><img src = "https://i.imgur.com/Hb5IqiQ.png" width = 30%/>
- 가이드 선택시 튜토리얼 화면 보여짐
- 잘먹었습니다 서비스 설명 및 인증 방법과 인증 기준, 포인트 사용법 설명

**지도**
<img src = "https://i.imgur.com/vFEjVro.png" width = 50%/>
- 사용자의 현재 위치를 기반으로 연계된 식당 위치 표시



### 기부하기

<img src = "https://i.imgur.com/K7zRLuA.png" width = 50%/>
<img src = "https://i.imgur.com/ylqcrGR.png" width = 50%/>
- 종료가 임박한 기부 프로젝트를 상단에 보여줌
- 하단에는 도움이 필요한 모든 프로젝트 목록 확인 가능

**상세화면** 
<img src = "https://i.imgur.com/o9OdvbJ.jpg" width = 40%/><img src = "https://i.imgur.com/5t0GkP5.jpg" width = 40%/>
- 해당 프로젝트에 자세한 내용 확인
- 보유한 포인트 이내로 기부 가능

### 챌린지 인증
<img src = "https://i.imgur.com/sW3KrQk.jpg" width = 30%/><img src = "https://i.imgur.com/iehVSnm.jpg" width = 30%/><img src = "https://i.imgur.com/yYZVMPs.jpg" width = 30%/><img src = "https://i.imgur.com/K7A6laT.png" width = 30%/>

- 챌린지 인증 탭을 누르고 사진을 촬영하게 되면 간단한 설명 기입 가능

<br>

<img src = "https://i.imgur.com/7yRK3Ij.jpg" width = 30%/><img src = "https://i.imgur.com/jF1LOmX.jpg" width = 30%/>

- 잘먹었습니다 챌린지 참여 가게에서 QR코드를 통해 인증하게 되면 추가 설명 표시
- 등록시 QRCode에 등록된 가게 이름을 표시


<br>

### 챌린지 피드
<img src = "https://i.imgur.com/OBK47ky.png" width = 50%/>
<img src = "https://i.imgur.com/rQ66Jgn.png" width = 50%/>

- 챌린지에 참여한 다른 유저들의 이미지 확인
- 화면 선택시 식당 이름, 유저, 좋아요 눌린 수, 설명 등을 확인

### 마이페이지

<img src = "https://i.imgur.com/ChluNvv.png" width = 50%/>
- 마이페이지에서 프로필 이미지, 보유 에코포인트 확인
- 오늘 챌린지 참여 횟수와 이로 인해 절감된 온실가스 양 확인
- 적립하고 기부한 포인트 히스토리 확인

------
## 데모영상
- [유튜브](https://youtu.be/8t26aRF6UJM)

## 참고자료
- [음식물 쓰레기에 관한 환경부 자료](https://me.go.kr/home/file/readDownloadFile2.do?fileId=25739&fileSeq=1&fileName=02cbe80dbf2710b9209383edeed724b311598d616211b9cb4ca7ed1c3af7e5abf2edcfedf069048834db3fe6f29e09aa&openYn=Y#:~:text=%EC%9D%8C%EC%8B%9D%EB%AC%BC%EC%93%B0%EB%A0%88%EA%B8%B0%EB%8A%94%20%EC%B2%98%EB%A6%AC%EA%B3%BC%EC%A0%95,%EC%98%A8%EC%8B%A4%EA%B0%80%EC%8A%A4%EA%B0%80%20%EB%B0%B0%EC%B6%9C%EB%90%A9%EB%8B%88%EB%8B%A4)
- [MBC 기사](https://imnews.imbc.com/replay/2018/nwtoday/article/4582674_30187.html)


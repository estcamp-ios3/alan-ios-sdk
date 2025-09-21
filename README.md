# Alan AI for iOS SDK
Swift로 이스트소프트의 앨런 AI를 쉽게 사용하기 위한 라이브러리입니다.

## 설치

Swift 패키지 매니페스트 파일에 Alan AI for iOS SDK를 추가합니다.

```swift
.package(
    url: "https://github.com/estcamp-ios3/alan-ios-sdk",
    from: "latest alan-ios-sdk tag"
)
``` 

Target의 종속성에 Alan AI를 추가합니다.
```swift
.product(name: "AlanAI", package: "alan-ios-sdk")
```

## 사용방법

AlanAI를 import합니다.
```swift
import AlanAI
```

AlanAI 타입의 인스턴스를 생성합니다. ClientID는 이스트소프트를 통해 별도로 제공받아 적용합니다.
```swift
let clientId = "(여러분의 key)"
let alanAI = AlanAI(clientID: clientId)

```

준비된 프롬프트를 사용해 앨런 AI에 질의하고 답을 얻습니다.
```swift

do {
    let response: AlanResponse? = try await alanAI.question(query: "오늘 서울 날씨 어때?")
    
    if let response {
        print(response.content ?? "(none)")
    }
} catch {
    print(error.localizedDescription)
}
```

## 응답
AlanResponse 타입을 참고합니다.

## 오류
AlanAIError 타입을 참고합니다.

|Code|Description|
|--|--|
|invalidRequest|올바르지 않은 요청입니다|
|noServerResponse|서버 응답이 없습니다|
|unknown|그 밖의 알 수 없는 오류입니다|

## 참고
[앨런 AI API 명세서](https://www.notion.so/oreumi/AI-API-25aebaa8982b8047906dee625ca7816c)


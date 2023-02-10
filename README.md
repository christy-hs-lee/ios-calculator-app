# ➕➖ 계산기 프로젝트 II ➗✖️


## 목차
1. [소개](#1-소개)
2. [팀원](#2-팀원)
3. [핵심경험](#3-핵심경험)
4. [타임라인](#4-타임라인)
5. [프로젝트 구조](#5-프로젝트-구조)
6. [실행화면(기능 설명)](#6-실행-화면기능-설명)
7. [트러블슈팅](#7-트러블-슈팅)
8. [참고 문서](#8-참고-문서)
9. [팀 회고](#9-팀-회고)

</br>

## 1. 소개
> 계산기 프로젝트에서 서로 작성한 코드를 합쳐 리팩토링하여 하나의 코드로 완성합니다.


</br>

## 2. 팀원

|<center>[Christy](https://github.com/christy-hs-lee)</center>|<center>[무리](https://github.com/parkmuri)</center>
| :--------: |---|
|<img height="180px" src="https://i.imgur.com/kHLXeMG.png">|<img width="200" alt="image" src=https://i.imgur.com/U7TmXby.jpg>|

</br>

## 3. 핵심경험
### STEP 1
- [X] UML을 기반으로 한 코드병합
- [X] 협업 중 스토리보드 병합
### STEP 2
- [X] 기존 코드의 리팩터링
- [ ] 단위 테스트를 통해 리팩터링 과정의 코드 오류를 최소화
- [X] 제네릭을 활용하여 범용적인 타입 구현(선택)


</br>

## 4. 타임라인
### 프로젝트 진행 기간
**23.02.06 ~ 23.02.10** 

| 날짜 | STEP | 타임라인 |
| --- | --- | --- |
|23.02.06 (월)| STEP1 | - 각자의 코드 파악 및 더 나은 코드 선정 | 
|23.02.07 (화)| STEP1 | - operator enqueue 수정</br>- ViewController 작성 및 리팩토링</br>- Formula 변수 수정 및 while loop 조건 변경</br>- dequeue 로직 수정 및 전체적인 프로퍼티, 메서드 리팩토링</br>- Operator caculate메서드 변수 추가하여 리팩토링 및 컨벤션 수정</br>- stackView hidden처리 및 변수명 수정 |
|23.02.08 (수)| STEP2 | - 고차함수 적용, 개행 수정 |
|23.02.09 (목)| STEP2 | - formatNumber메서드 input 타입 Decimal로 변경</br>- 소수점 처리방식 변경</br>- 입력값이 20자일때 dot, 0버튼 비활성화 조건 추가</br>- 4자리 이상의 숫자 입력 후 연산자 입력시 오류 수정</br>- 컨벤션 및 변수명 수정|
|23.02.10 (금)| STEP2 | - 리드미 작성 |


</br>

## 5. 프로젝트 구조

- ### 폴더 구조
```
  .
  ├── Calculator
  │   ├── Controller
  │   │   ├── AppDelegate.swift
  │   │   ├── SceneDelegate.swift
  │   │   └── ViewController.swift
  │   └── Model
  │       ├── CalculateItem.swift
  │       ├── CalculatorItemQueue.swift
  │       ├── ExpressionParser.swift
  │       ├── Extension.swift
  │       ├── Formula.swift
  │       ├── Operator.swift
  │       └── Sign.swift
  ├── CalculatorItemQueueTests
  │   └── CalculatorItemQueueTests.swift
  ├── FormulaTests
  │   └── FormulaTests.swift
  └── OperatorTests
      └── OperatorTests.swift
     
```







</br>

- ### UML

<details>
<summary> UML </summary>
<div markdown="1">

![](https://i.imgur.com/69KLl3S.png)

</div>
</details>






</br>

## 6. 실행 화면(기능 설명)


<details>
<summary>실행 화면</summary>
<div markdown="1">

| AC 버튼 | CE 버튼 | ⁺⁄₋ 버튼 |
| :-----: | :-----: | :-----: |
|<img src="https://i.imgur.com/6RpAnpX.gif" width=250>| <img src="https://i.imgur.com/R1JVchm.gif" width=250>| <img src="https://i.imgur.com/aiT38ls.gif" width=250>|



| 0으로 나눌 경우 | 연산자 누르기 |  `,` 찍기 |
| :-----: | :-----: | :-----: |
|<img src="https://i.imgur.com/Fgz0CtB.gif" width=250>| <img src="https://i.imgur.com/FitKeG8.gif" width=250>| <img src="https://i.imgur.com/zAfA9LS.gif" width=250>|


| = 버튼 | 
| :-----: |
|<img src="https://i.imgur.com/4GS0rA3.gif" width=220>|

</div>
</details>





</br>

## 7. 트러블 슈팅
### 1. `,`없는 10000 or Double의 `0` 무시
먼저 파일 병합 후, 문제가 없는지 시뮬레이터를 돌려보다 이와 같은 문제를 발견하게됐습니다. 
> 같은 자리 수여도 `12,345`는 `,`가 입력이 되지만, `10000`는 `,`가 찍히지 않고 출력되었습니다. 

- 이를 처리하기 위해서 `zeroButtonTapped`에 `numberFormatter`를 적용하여 출력하니 이번에는 다음과 같은 문제가 발생하게되었습니다.
> 계산기에 `1.02`를 입력하기 위해 `1.0`을 입력하면 소수점 뒤 `0`이 입력되지 않았습니다. 

- `Double`을 사용하여 생기는 문제로 파악되며 이것을 해결하기 위해 소수점 아래를 나타내는 `NumberFormatter`의 `minimumSiginificant` 프로퍼티를 이용하려고 하니, `minimumSignificant`를 6자리를 설정 해주면 `1.00000`이 출력되는 문제가 발생했습니다.

위의 문제들은 NumberFormatter를 사용할 때 매개변수의 타입으로 설정해놓은 Double을 Decimal타입으로 변경하여 해결할 수 있었습니다! 

</br>

### 2. 스택뷰에 첫 `,` 앞부분의 숫자만 입력되는 오류
위의 트러블슈팅 1️⃣을 해결하고 큰 숫자를 입력하면 `1`, 혹은 `12`처럼 터무니없이 작은 숫자가 입력되었습니다. `12,345`를 입력하면 스택뷰에 `12`로, `1,123,123,123`을 입력하면 `1`로 입력이 되는것을 보아 맨 앞 `,`의 숫자만 입력이 되는것을 볼 수 있었습니다. `,`로 인한 오류라고 생각되어 `removeComma()`를 통해 `,`를 제거하여 해결할 수 있었습니다.

```swift
let removedComma = removeComma(currentOperand)
newStackView = makeStackView(currentOperator,
                             formatNumber(Decimal(string: removedComma) ?? 0))
```
</br>

### 3. `,`를 포함한 currentOperand의 수가 20개 찍히는 문제

```swift
// 수정 전
guard let number = sender.currentTitle,
    currentOperand.count < 26 else { return }
// 수정 후
guard let number = sender.currentTitle,
    currentOperand.filter({ Int(String($0)) != nil }).count < 20 else { return }
```
요구사항에 숫자의 입력은 20자리까지만 받는다는 조건이 있어, `,`를 포함하여 26개 까지를 받는 방법으로 진행하게되었는데 이렇게 되면 `,`뿐만 아니라 `.`의 입력이 포함되어 어쩔때는 숫자가 19자리만 들어오는 경우가 있었습니다. 이를 해결하기 위해 guard문에 `currentOperand`의 인자들을 `Int`로 변환 시 `nil`이 아닌 인자의 갯수를 필터링하는 조건을 추가하여 숫자를 20자 까지 입력받을 수 있었습니다. 
 

</br>


## 8. 참고 문서

> - [🍎 Apple Developer 공식문서 - Decimal](https://developer.apple.com/documentation/foundation/decimal)
> - [우아한형제들 기술블로그 - 우린 Git-flow를 사용하고 있어요](https://techblog.woowahan.com/2553/)
> - [찬영블로그 - 다양한 브랜치 전략](https://chanyeong.com/blog/post/15)

</br>

## 9. 팀 회고


<details>
<summary> 팀 회고 </summary>
<div markdown="1">

### 👩무리스티👧가 잘한 점
- 친한 만큼 서로의 의견을 편하게 말할 수 있었어요.
- 항상 서로를 배려하며 모든 과정을 즐겁게 진행했어요.
- 상대의 속도를 고려하여 모르는 부분을 명확하게 집고 넘어갔어요.
### 👩무리스티👧의 아쉬운 점
- ~~2주가 끝인게 아쉬워요...~~
- 다른 얘기가 나오면 참지못하고 수다를 떨게되었어요...!

### 서로에게 한마디🫶
#### 무리 -> 크리스티
항상 긍정적인 모습 너무 보기좋았습니다. 보고 많이 배웠어요! `계산기 I` 하면서 저도 크리스티도 맘고생 많이했는데 훌훌 털어버리고 `계산기 II` 같이 할수있어서 정말 행복했습니다🫶 야.아.하면서 만난 베스트 팀아닐까요...?☺️ 방학 끝나고 다음 프로젝트에서도 함께 팀이 된다면... 더 재미있게 해보아요! 고생 많으셨고 감사했읍니다.

#### 크리스티 -> 무리
`계산기 I`을 하며 많이 힘들었던 시간을 무리와 함께 극복할 수 있었습니다! 조급해하지 않고 모든 부분 이해하고 넘어갈 수 있도록 배려해 주셔서 너무 감사했습니다. 중간에 포기하지 않고 앞으로 나아갈 수 있도록 응원해 주셔서 너무 감사했습니다🙌🏻 우리 다음에 또 만나요~~~ 🥰

</div>
</details>


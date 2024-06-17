# Markdown Editor

## 프로젝트 소개
macOS 전용으로 만들어진 마크다운 에디터 앱입니다.</br>
실시간으로 프리뷰를 같이 보면서 쓸 수 있는 경량화된 마크다운 에디터를 직접 만들어보고 싶었습니다.

## 설치방법
1. 파일 다운로드
2. 압축해제
3. MarkdownEditor.app을 응용프로그램 폴더로 이동

## 개발환경
- xcode 15.4
- macOS Sonoma 14.5

## 사용한 라이브러리
- SwiftUI
- MarkdownUI

## 주요기능

### 마크다운 실시간 프리뷰
- 사용자가 입력한 텍스트를 실시간으로 프리뷰로 보여줍니다.
- 현재 입력중인 내용을 Editor Only , Editor & Preview, Preview Only 3가지 형식으로 선택해서 볼 수 있습니다.

### 마크다운 파일 저장 및 불러오기
- 사용자가 입력한 텍스트를 .md 확장자를 가진 마크다운 파일로 저장할 수 있고, 불러올 수 있습니다.

### 파일 내보내기
- 사용자가 입력한 텍스트를 임의의 확장자로 내보낼 수 있습니다.

### CommandGroup
- CommandGroup을 활용해 메뉴바에 기능을 추가할 수 있고, 이를 단축키로 실행할 수 있다.

### 실행화면
|에디터|<img width="1236" alt="EditorOnly" src="https://github.com/jjw8959/MarkdownEditor/assets/76551806/a11b992d-806e-4e62-8083-1f507eb2c3b9">|
|---|---|
|프리뷰와 에디터|<img width="1236" alt="EditorNPreview" src="https://github.com/jjw8959/MarkdownEditor/assets/76551806/cb51de32-77dc-4090-8280-c482f7cac404">|
|프리뷰|<img width="1236" alt="PreviewOnly" src="https://github.com/jjw8959/MarkdownEditor/assets/76551806/cfdf00c1-5fff-4f7e-b1e2-772d5f86fc0c">|
|파일 메뉴바|<img width="476" alt="커맨드그룹파일" src="https://github.com/jjw8959/MarkdownEditor/assets/76551806/d2301aeb-546f-4ae8-9603-5fad96c63589">|
|뷰 메뉴바|<img width="446" alt="커맨드그룹뷰" src="https://github.com/jjw8959/MarkdownEditor/assets/76551806/41fb2f48-54d7-414d-8289-cbb5a057f33f">|
|파일 저장|![SaveFile](https://github.com/jjw8959/MarkdownEditor/assets/76551806/9f291db2-6f8e-432a-8b61-4fafb40e4859)|
|파일 불러오기|![fileOpen](https://github.com/jjw8959/MarkdownEditor/assets/76551806/5383f486-85e6-4e3e-9b18-7075fe819e48)|

## 배운점
- MarkdownUI로 현재 작성중인 텍스트를 마크다운 프리뷰로 보여줄 수 있다.
- fileImporter를 통해 파일 불러오기를 할 수 있다.
- fileExporter를 통해 파일 내보내기를 할 수 있다.
- NSSavePanel을 통해 파일을 저장할 수 있다.
- CommandGroup을 사용해 메뉴바에 기능 추가 및 단축키 활용이 가능하다.

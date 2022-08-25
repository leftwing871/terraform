module을 통해 관련있는 요소끼리 모아 패키지 별로 관리하자.
- 모듈의 장점
1. 캡슐화 : 서로 관련있는 요소들 끼리만 캡슐화를 하여 의도치 않은 문제 발생을 예방할 수 있다.
2. 재사용성 : 모듈을 사용하여 리소스를 정의하면 다른 환경에서도 해당 리소스를 쉽게 재사용할 수 있다.
3. 일관성 : 매번 새로 작성하게 되면 사람에 따라 리소스의 옵션이 빠지는 부분이 생길수도 있고 매번 같을 수 없기에 모듈을 재 사용시 일관성을 가지게 된다.


Data Source 를 활용해 Hard coding 을 줄여보자.
Use this data source to get the ID of a registered AMI for use in other resources.
url : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami


backend를 사용해 팀작업이 가능하도록 하자.


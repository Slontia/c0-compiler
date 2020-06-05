# C0-compiler
Compiler Technology, BUAA C0文法编译器

本应用支持C0代码的编译和优化，生成中间代码和最终的MIPS汇编代码。同时**支持代码自动生成，可以同时生存C0代码和对应的C代码**，更方便地进行正确性验证。

---

## 文件说明
 - code：源代码，开发环境为Code::Blocks 13.12 (Windows 8.1)，在**main.h**中可以对编译器行为进行简单的设置；

    - NEW_TAR：是否开启优化
    - AUTO_TEST：自动生成C0代码并编译
    - LAST_AUTO_TEST：编译上一次生成的C0代码

 - document：文档，包括**设计文档**和**申优文章**；
 - test_code：测试用的C0代码，test代码可正确编译，error代码会编译错误。具体预期结果在document的设计文档中说明。
 
## 运行说明
  运行后键入C0代码所在的路径，即可在output文件夹中生成产生的中间代码，以及最终的MIPS代码。

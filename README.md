# Picpay Salesforce PJ

## Sumário

- [Sobre](#Sobre)
- [Pré requisitos para desenvolvimento](#Pré-requisitos-para-desenvolvimento)
- [Ambiente de desenvolvimento](#Ambiente-de-desenvolvimento)
- [Fluxo de trabalho](#Fluxo-de-trabalho)
- [Ambiente de Stage](#Ambiente-de-Stage)
- [Ambiente de Produção](#Ambiente-de-Produção)
- [Finalizando a esteira de desenvolvimento](#Finalizando-a-esteira-de-desenvolvimento)

## Sobre

Repositório responsável por versionar o código da ferramenta de CRM Salesforce PJ, além de controlar o pipeline de continuous integration e continuous delivery responsável pela automação do deploy nos ambientes da ferramenta (sandbox e produção).

Para solicitar alterações em produção será necessária a abertura de Pull requests e da respectiva GMUD.

## Pré requisitos para desenvolvimento

`Salesforce CLI`
`vscode`
`git`

## Ambiente de desenvolvimento

Para iniciar o ambiente de desenvolvimento, vá até o diretório do projeto e utilize:

```
git init
```

Este comando cria um repositório Git vazio, basicamente um diretório .git com subdiretórios para os arquivos objects, refs/heads, refs/tags e arquivos modelo. Também é criado um arquivo inicial HEAD que tem como referencia o HEAD do ramo principal.


Para vincular este repositório remoto ao seu repositório local, utilize:

```
git remote add origin https://github.com/PicPay/salesforce-pj.git
```

Para baixar commits, arquivos e referências de um repositório remoto para seu repositório local, utilize:

```
git fetch --all
```

Lembre-se de atualizar seu arquivo local `.gitignore`, gerado ao inicializar o repositório, para ignorar todos os arquivos diferentes daqueles versionados no branch master.

## Fluxo de trabalho

Para iniciar o desenvolvimento de novas implementações, preferencialmente vinculadas aos cards priorizados durante a sprint corrente, no board do time Salesforce no Jira, será necessário utilizar uma branch apartada, que deverá ser criada com base na branch master (Produção), do repositório remoto. 

Garanta que o branch remoto da master esteja atualizado com as últimas alterações realizadas:

```
git checkout master
git pull origin master
```

Para efetuar a criação da branch de uma nova feature/correção e, automaticamente, alterar a branch corrente, utilize (onde TISFXXX seja o nome da branch - que deve referenciar uma história ou tarefa do Jira):
```
git checkout -b TISFXXX master
```

A partir daí, com o seu projeto baixado localmente e autorizado na org de desenvolvimento, codifique as alterações e defina, na ferramenta, as configurações necessárias para atendimento da história ou tarefa, lembrando sempre de publicar suas alterações no ambiente.

Para que a pipeline consiga publicar corretamente suas alterações nas esteiras de homologação e produção, é necessário atualizar os metadados alterados/incluídos no arquivo package/package.xml. Para facilitar este controle, é possível utilizar a extensão [Salesforce Package.xml Generator Extension for VS Code](https://marketplace.visualstudio.com/items?itemName=VignaeshRamA.sfdx-package-xml-generator). 

Outra opção é baixar o plugin [sfdx-git-delta](https://github.com/scolladon/sfdx-git-delta) e utilizar o seguinte comando:

 ```
sfdx sgd:source:delta --to TISFXXX --from origin/master --output .`
 ```

O arquivo package/package.xml será atualizado automaticamente com as diferenças entre as branches.

Após isso, adicione os arquivos alterados/incluídos utilizando:
```
git add
```

Para commitar as alterações nos arquivos alterados/incluídos, utilize:
```
git commit -m “(TISFXXX) Mensagem informando as alterações realizadas.”
```

## Ambiente de Stage

Ao finalizar o desenvolvimento, os testes unitários e avaliar que todas as alterações commitadas já estão aptas para serem replicadas, acesse o branch remoto do ambiente de Stage, utilizando:
```
git checkout stage
```

Na sequência, puxe as últimas atualizações realizadas na branch remota de Stage:

```
git pull origin stage
```

Assim, você poderá realizar o merge do branch responsável por consolidar o desenvolvimento da sua nova feature/correção com a branch remota de Stage, utilizando:
```
git merge TISFXXX
```

Nesta etapa, tenha muito cuidado ao mesclar as alterações realizadas no branch da sua feature/correção (no caso, TISFXXX) com o código presente na branch remota do ambiente de Stage. Não se esqueça de conferir se todos os metadados atualizados estão referenciados no arquivo package/package.xml. Caso contrário, a pipeline do ambiente não publicará automaticamente suas alterações.

Para enviar o conteúdo da branch remota (origin/stage) mesclado com o desenvolvimento realizado na branch local (TISFXXX), utilize:
```
git push origin stage
```

Neste momento, acompanhe via GitHub a execução do worfklow que irá publicar automaticamente no ambiente de Stage as alterações desenvolvidas na branch.

Uma vez que todas as alterações tenham sido publicadas, acesse o ambiente de Stage no Salesforce e valide todos os casos de testes necessários para garantir o pleno funcionamento da feature/correção. Caso você não possua acesso a algum dos ambientes listados neste tópico, entre em contato com o time tech Salesforce PJ para avaliarmos a necessidade.

Nesta etapa, além de acessar a org e garantir que tudo foi replicado e atendeu aos requisitos levantados, conforme esperado, é necessário receber o OK formal da área de negócios (Planejamento Comercial) e produto, garantindo o atendimento da nova feature/correção à proposta priorizada, em ambiente de stage.

## Ambiente de Produção

Assim, caso todas as etapas de validação tenham sido superadas, sejam elas de responsabilidade do time tech de Salesforce PJ, da área de Planejamento Comercial ou da área de Produto, envie sua branch local ao repositório remoto, utilizando:
```
git push origin TISFXXX
```

A partir daí, acesse novamente o GitHub e, a partir da aba Pull Request, compare as alterações efetuadas no branch replicado no repositório remoto com o branch base Master (Produção).

Realize a revisão dos pontos alterados, em comparação com o código presente em produção e, caso todas as alterações estejam valiadas, efetue a criação de uma nova Pull request.

Abra a GMUD responsável por realizar a formalização da mudança proposta e não se esqueça de criar todas as subtarefas, plano de rollback e de linkar esta PR na descrição do item criado. Solicite a aprovação do gestor responsável.

Nesta etapa, seu código será revisado e, caso atenda a todas as premissas de desenvolvimento, como boas práticas, otimização de código, entre outras, alinhadas com a necessidade de implementação daquela alteração, sua Pull Request poderá mesclada com a branch Master e o seu código será automaticamente publicado em ambiente de produção. Caso surjam dúvidas sobre as permissões necessárias para revisão e aprovação dos merges, entre em contato com o time tech Salesforce PJ.

## Finalizando a esteira de desenvolvimento

Com a confirmação e validação de que todas as alterações propostas foram replicadas em ambiente de produção, delete a branch remota, caso você não tenha realizado este passo via github, utilizando:
```
git push origin --delete TISFXXX
```

Agora, como última etapa, se desejar, remova a branch do seu repositório local:
```
git branch -D TISFXXX
```

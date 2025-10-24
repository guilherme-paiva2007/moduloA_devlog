# modulo_a_devlog - YoutanPanel

Aplicação de controle de ativos da YouTan

## Instalação

### Uso geral

#### 1. Baixar biblioteca de provedor de HTTP local (usando build/web)

O projeto precisa ser iniciado como um SPA (Single Page Application).
Uma boa alternativa é a biblitoca `serve` do NPM.

Para inicializar o próximo passo, é necessário ter o Node.js e NPM no PATH, para utilizar bibliotecas globais como uma CLI.

Instale globalmente:
```bash
npm install -g serve
```

#### 2. Inicie o provedor

Para servir a aplicação localmente, use
```bash
serve -s ./build/web -p 8080
```

Isso iniciará um servidor HTTP no localhost na porta `8080`.

#### 3. Abra o localhost no navegador

Em qualquer navegador, acesse `http://localhost:8080` para navegar ao diretório padrão da aplicação.

### Modo de Desenvolvimento

A inicialização em modo de desenvolvimento permite usar as ferramentas de debug de Flutter, mas requer mais passos e instalações para utilizar.

#### 1. Instalar Flutter SDK

No site oficial do Flutter[https://docs.flutter.dev/get-started/quick], siga os passos para instalar o Flutter SDK e adicioná-lo ao PATH.

#### 2. Instale os pacotes

Para compilar, é necessário instalar as dependências do projeto.

```bash
flutter pub get
```
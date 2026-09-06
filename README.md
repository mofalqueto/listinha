# 🛒 Listinha

### Pra não esquecer nada. 💛

O **Listinha** é um aplicativo de lista de compras desenvolvido em **Flutter**, criado para tornar a organização das compras mais simples, rápida e intuitiva.

O projeto foi desenvolvido como atividade acadêmica do curso de **Desenvolvimento de Software Multiplataforma (DSM)** da **FATEC Franca**, aplicando conceitos de desenvolvimento mobile, persistência local, experimentação A/B e CI/CD.

---

## ✨ Sobre o projeto

Com o Listinha, o usuário pode criar e organizar sua lista de compras, acompanhar os itens já adquiridos e visualizar o valor estimado da compra.

A interface foi desenvolvida priorizando simplicidade, organização visual e facilidade de uso.

### Principais funcionalidades

- 📝 Adicionar produtos à lista
- 🔢 Definir quantidade dos produtos
- 💰 Informar o preço estimado
- ✅ Marcar produtos como comprados
- 🗑️ Excluir itens
- 🗂️ Organizar produtos por categorias
- 📊 Acompanhar o valor estimado da compra
- 💾 Persistência local dos dados
- 🧪 Experimento A/B de interface

---

## 🎨 Categorias

Os produtos podem ser organizados em quatro categorias:

- 🛒 **Compras**
- 🍎 **Hortifruti**
- 🧹 **Limpeza**
- 🏠 **Casa**

---

## 🧪 Teste A/B

O Listinha possui um experimento A/B para avaliar como a posição da funcionalidade **Categorias** influencia sua utilização.

### Versão A

A seção **Categorias** pode ser acessada por:

- cards disponíveis na Home;
- barra de navegação inferior.

### Versão B

A seção **Categorias** pode ser acessada somente pelos cards disponíveis na Home.

### Pergunta do experimento

> **A presença da funcionalidade Categorias na barra de navegação inferior aumenta sua utilização pelos usuários?**

A versão do experimento é atribuída automaticamente e armazenada localmente, mantendo a mesma experiência durante o uso daquela instalação.

O aplicativo também possui uma tela de demonstração dos resultados do experimento, utilizando **dados simulados para fins acadêmicos**.

---

## 🛠️ Tecnologias utilizadas

- **Flutter**
- **Dart**
- **SharedPreferences**
- **Git**
- **GitHub**
- **GitHub Actions**

---

## 💾 Persistência de dados

O aplicativo utiliza **SharedPreferences** para armazenamento local.

Dessa forma, a lista de compras e as informações necessárias ao experimento podem permanecer disponíveis mesmo após o aplicativo ser fechado e aberto novamente.

O projeto não utiliza backend ou sistema de autenticação.

---

## 🔄 CI/CD

O projeto utiliza **GitHub Actions** para automatizar etapas de integração e entrega contínua.

A automação permite validar o projeto Flutter sempre que novas alterações são enviadas ao repositório.

---

## 📱 Plataforma

O projeto foi desenvolvido em Flutter, com execução e testes durante o desenvolvimento em ambiente Windows.

---

## 📚 Projeto acadêmico

Projeto desenvolvido para a disciplina de desenvolvimento mobile do curso de:

**Desenvolvimento de Software Multiplataforma — DSM**  
**FATEC Franca**

---

## 👩‍💻 Desenvolvedora

**Monica Aímola Falqueto**

Estudante de Desenvolvimento de Software Multiplataforma na FATEC Franca.

Disciplina: Laboratório de Desenvolvimento de Dispositivos Móveis

---

<p align="center">
  <strong>Listinha 💛</strong><br>
  <em>Pra não esquecer nada.</em>
</p>
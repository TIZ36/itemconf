Minikube tutoiral

| macos

1. install minikube using homebrew
```shell
brew install minikube

#If which minikube fails after installation via brew, you may have to remove the old minikube links and link the newly installed binary
brew unlink minikube
brew link minikube
```

2. start minikube
```shell
minikube start
```